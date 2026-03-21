# find 5 problems and fix them

FROM ubuntu:latest

RUN apt-get install -y python3 python3-pip curl

COPY . /app
COPY requirements.txt /app/requirements.txt
RUN pip3 install -r /app/requirements.txt

ENV API_KEY=sk-abc123secret

EXPOSE 8000

CMD python3 /app/train.py

















































# answer

FROM ubuntu:22.04

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip curl \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["python3", "train.py"]

# explanation

# 1. latest → 버전 고정


# # Bad
# FROM ubuntu:latest
# # Good
# FROM ubuntu:22.04
# latest는 시간에 따라 바뀌므로 빌드 재현성이 깨짐

# 2. apt-get update && install 한 줄로


# # Bad
# RUN apt-get install -y python3
# # Good
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     python3 python3-pip curl \
#     && rm -rf /var/lib/apt/lists/*
# update 없으면 패키지를 못 찾음. rm으로 캐시 삭제하여 이미지 경량화

# 3. requirements.txt를 먼저 COPY → install → 그다음 소스 COPY


# COPY requirements.txt /app/requirements.txt
# RUN pip3 install -r /app/requirements.txt
# COPY . /app          # 소스코드는 나중에!
# 코드가 바뀌어도 의존성 레이어는 캐시에서 재사용됨

# 4. 비밀키는 Dockerfile에 절대 넣지 않는다


# # Bad - 둘 다 틀림
# ENV API_KEY=sk-abc123secret
# ENV API_KEY=process.ENV.API_KEY    # 이건 그냥 문자열 "process.ENV.API_KEY"가 됨

# # Good - 런타임에 주입
# # Dockerfile에는 아예 안 쓰고, 실행 시:
# # docker run -e API_KEY=$API_KEY myapp
# process.env는 Node.js 런타임 코드이지, Dockerfile 문법이 아닙니다!

# 5. CMD는 exec form으로


# # Bad (shell form - PID 1이 sh가 됨, 시그널 전달 안 됨)
# CMD python3 /app/train.py

# # Good (exec form - python3가 PID 1, SIGTERM 직접 수신)
# CMD ["python3", "/app/train.py"]