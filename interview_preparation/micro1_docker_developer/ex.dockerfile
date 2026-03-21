# example

FROM python:3.11-slim

WORKDIR /interview_preparation/micro1_docker_developer

COPY requirements.txt /interview_preparation/micro1_docker_developer/
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD [ "python" ]