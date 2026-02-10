# AWS 배포 가이드
## www.zaraconsultingss.com Next.js 프로젝트 배포

### 📋 전체 순서
1. EC2 인스턴스 생성
2. Route 53 도메인 설정
3. EC2 서버 환경 구축
4. 애플리케이션 배포
5. Nginx 리버스 프록시 설정
6. SSL 인증서 설정

---

## 1. EC2 인스턴스 생성

### 1.1 AWS 콘솔 접속
- AWS Management Console 로그인
- 서비스 > EC2 선택
- "인스턴스 시작" 버튼 클릭

### 1.2 AMI(Amazon Machine Image) 선택
- **Ubuntu Server 22.04 LTS (HVM), SSD Volume Type** 선택
- 64비트(x86) 아키텍처 선택
- "선택" 버튼 클릭

### 1.3 인스턴스 유형 선택
- **t2.micro** 선택 (프리티어 사용 가능)
- vCPU: 1, 메모리: 1GB
- "다음: 인스턴스 세부 정보 구성" 클릭

### 1.4 인스턴스 세부 정보 구성
- **네트워크**: 기본 VPC 선택
- **서브넷**: 기본값 사용
- **퍼블릭 IP 자동 할당**: 활성화
- **기타 설정**: 기본값 유지
- "다음: 스토리지 추가" 클릭

### 1.5 스토리지 추가
- **크기**: 20GB (프리티어는 30GB까지 무료)
- **볼륨 유형**: gp3
- **종료 시 삭제**: 체크
- "다음: 태그 추가" 클릭

### 1.6 태그 추가
- **키**: Name
- **값**: zara-consulting-server
- "다음: 보안 그룹 구성" 클릭

### 1.7 보안 그룹 구성
- **새 보안 그룹 생성** 선택
- **보안 그룹 이름**: zara-consulting-sg
- **규칙 추가**:
  ```
  유형        프로토콜  포트범위  소스
  SSH         TCP      22        내 IP
  HTTP        TCP      80        0.0.0.0/0
  HTTPS       TCP      443       0.0.0.0/0
  ```

### 1.8 검토 및 시작
- 모든 설정 내용 확인
- "인스턴스 시작" 클릭

### 1.9 키 페어 생성
- **새 키 페어 생성** 선택
- **키 페어 이름**: zara-consulting-key
- **키 페어 유형**: RSA
- "키 페어 다운로드" 클릭 (.pem 파일 안전하게 보관)
- "인스턴스 시작" 클릭

### 1.10 탄력적 IP 할당
- EC2 대시보드 > 네트워크 및 보안 > 탄력적 IP
- "탄력적 IP 주소 할당" 클릭
- "할당" 클릭
- 할당된 IP 선택 > 작업 > 탄력적 IP 주소 연결
- 인스턴스 선택 > "연결" 클릭
- **⚠️ 할당받은 IP 주소 메모 (예: 54.123.45.67)**

---

## 2. Route 53 도메인 설정

### 2.1 도메인 준비
**옵션 A: Route 53에서 도메인 구매**
- Route 53 > 도메인 등록 > 도메인 등록
- zaraconsultingss.com 검색
- "장바구니에 추가" > "계속" 
- 연락처 정보 입력 > 구매 완료

**옵션 B: 외부 도메인 사용**
- 기존 도메인 등록업체에서 네임서버 변경 필요

### 2.2 호스팅 존 생성
- Route 53 > 호스팅 영역 > "호스팅 영역 생성"
- **도메인 이름**: zaraconsultingss.com
- **유형**: 퍼블릭 호스팅 영역
- "호스팅 영역 생성" 클릭

### 2.3 DNS 레코드 추가
- 생성한 호스팅 영역 클릭하여 들어가기
- 호스팅 영역 상세 페이지에서 "레코드 생성" 버튼 클릭

**2.3.1 루트 도메인 A 레코드**
- "레코드 생성" 클릭
- **레코드 이름**: (비워둠)
- **레코드 유형**: A - IPv4 주소로 트래픽 라우팅
- **값**: [1.10에서 메모한 탄력적 IP]
- **TTL**: 300
- "레코드 생성" 클릭

**2.3.2 www 서브도메인 A 레코드**
- "레코드 생성" 클릭
- **레코드 이름**: www
- **레코드 유형**: A - IPv4 주소로 트래픽 라우팅
- **값**: [1.10에서 메모한 탄력적 IP]
- **TTL**: 300
- "레코드 생성" 클릭

### 2.4 네임서버 확인 (외부 도메인 사용시)
- 호스팅 영역 상세 정보에서 NS 레코드 확인
- 4개의 네임서버 주소를 도메인 등록업체에 등록

---

## 3. EC2 서버 환경 구축

### 3.1 SSH 접속 준비
```bash
# 터미널 열기 (Mac/Linux) 또는 Git Bash (Windows)
# .pem 파일이 있는 위치로 이동 (보통 Downloads 폴더)
cd ~/Downloads

# 키 파일 권한 설정 (SSH 접속에 필수)
chmod 400 zara-consulting-key.pem
```

### 3.2 SSH로 서버 접속
```bash
# .pem 파일이 있는 위치에서 실행
ssh -i zara-consulting-key.pem ubuntu@[탄력적_IP_주소]

  AWS EC2에서 탄력적 IP 주소 확인 방법:
  1. AWS 콘솔 → EC2 → 네트워크 및 보안 → 탄력적 IP
  2. 또는 EC2 → 인스턴스 → 해당 인스턴스 선택 → 퍼블릭 IPv4 주소 확인

  * Error case
    * ssh: connect to host [IP address] port 22: Connection refused
    * reason : Different IP address by changing ip address with hotspot or wifi. 핫스팟 연결할 때랑 와이파이 연결할때 둘다 ip 가 달라서 벌어지는 상황. 
    * solution : IP는 핸드폰 핫스팟으로 고정, 즉 배포는 보안을 위해 핸드폰 핫스팟 연결해서 할 것. aws ec2 > Network & Security > Security Groups > SSH > Inbound Rules > Edit > Source = Custom -> My IP


# 예시
ssh -i zara-consulting-key.pem ubuntu@[탄력적_IP_주소]

# 다른 폴더에서 접속하려면 전체 경로 사용
ssh -i ~/Downloads/zara-consulting-key.pem ubuntu@[탄력적_IP_주소]
```

### 3.3 시스템 패키지 업데이트
```bash
# 패키지 목록 업데이트
sudo apt update

# 설치된 패키지 업그레이드
sudo apt upgrade -y
```

### 3.4 Node.js 20.x 설치
```bash
# NodeSource 저장소 추가
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

# Node.js 설치
sudo apt-get install -y nodejs

# 설치 확인
node -v  # v20.x.x 출력
npm -v   # 10.x.x 출력
```

### 3.5 필수 도구 설치
```bash
# Git 설치 (프로젝트 클론용)
sudo apt-get install -y git

# PM2 설치 (Node.js 프로세스 관리)
sudo npm install -g pm2

# Nginx 설치 (웹 서버/리버스 프록시)
sudo apt-get install -y nginx
```

---

## 4. 애플리케이션 배포

### 4.1 프로젝트 클론
```bash
# 홈 디렉토리로 이동
cd ~

# GitHub에서 프로젝트 클론
git clone https://github.com/[your-username]/zara_source.git

# 프로젝트 디렉토리로 이동
cd zara_source
```

### 4.2 의존성 패키지 설치
```bash
# package.json에 정의된 모든 패키지 설치
npm install

# 설치 중 오류 발생시
npm cache clean --force
npm install
```

### 4.3 프로덕션 빌드
```bash
# Next.js 프로덕션 빌드
npm run build

# 빌드 성공 메시지 확인
```

### 4.4 PM2로 애플리케이션 실행
```bash
# PM2로 Next.js 애플리케이션 시작
pm2 start npm --name "zara-consulting" -- start

# PM2 프로세스 상태 확인
pm2 status

# 로그 확인
pm2 logs zara-consulting
```

### 4.5 PM2 자동 시작 설정
```bash
# 현재 PM2 프로세스 저장
pm2 save

# 시스템 재부팅시 자동 시작 설정
pm2 startup systemd

# 위 명령어 실행 후 출력되는 sudo 명령어 복사해서 실행
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu

# 예: sudo env PATH=$PATH:/usr/bin pm2 startup systemd -u ubuntu --hp /home/ubuntu
```

---

## 5. Nginx 리버스 프록시 설정

### 5.1 Nginx 설정 파일 생성
```bash
# Nginx 설정 파일 생성
sudo nano /etc/nginx/sites-available/zaraconsultingss
```

### 5.2 Nginx 설정 내용 입력
```nginx
server {
    listen 80;
    listen [::]:80;
    server_name zaraconsultingss.com www.zaraconsultingss.com;

    # 프록시 설정
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }
}
```
- Ctrl+X, Y, Enter로 저장

### 5.3 Nginx 설정 활성화
```bash
# 심볼릭 링크 생성으로 설정 활성화
sudo ln -s /etc/nginx/sites-available/zaraconsultingss /etc/nginx/sites-enabled/

# 기본 설정 파일 제거
sudo rm /etc/nginx/sites-enabled/default
```

### 5.4 Nginx 설정 테스트 및 재시작
```bash
# 설정 파일 문법 검사
sudo nginx -t

# Nginx 재시작
sudo systemctl restart nginx

# Nginx 상태 확인
sudo systemctl status nginx
```

---

## 6. SSL 인증서 설정 (HTTPS)

### 6.1 Certbot 설치
```bash
# Certbot 및 Nginx 플러그인 설치
sudo apt-get install -y certbot python3-certbot-nginx
```

### 6.2 SSL 인증서 발급
```bash
# Let's Encrypt SSL 인증서 발급
sudo certbot --nginx -d zaraconsultingss.com -d www.zaraconsultingss.com
```

### 6.3 Certbot 설정 과정
1. 이메일 주소 입력 (인증서 만료 알림용)
2. 서비스 약관 동의: A 입력
3. 이메일 수신 동의: N 입력 (선택사항)
4. HTTP를 HTTPS로 리다이렉트: 2 선택 (권장)

### 6.4 자동 갱신 확인
```bash
# 자동 갱신 테스트
sudo certbot renew --dry-run

# 성공 메시지 확인
ubuntu@ip-xxx-xx-xx-xxx:~/zara_source$ sudo certbot --nginx -d zaraconsultingss.com -d www.zaraconsultingss.com
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Enter email address (used for urgent renewal and security notices)
 (Enter 'c' to cancel): [your-email@example.com]

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Please read the Terms of Service at
https://letsencrypt.org/documents/LE-SA-v1.5-February-24-2025.pdf. You must
agree in order to register with the ACME server. Do you agree?
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: Y

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Would you be willing, once your first certificate is successfully issued, to
share your email address with the Electronic Frontier Foundation, a founding
partner of the Let's Encrypt project and the non-profit organization that
develops Certbot? We'd like to send you email about our work encrypting the web,
EFF news, campaigns, and ways to support digital freedom.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: N
Account registered.
Requesting a certificate for zaraconsultingss.com and www.zaraconsultingss.com

Successfully received certificate.
Certificate is saved at: /etc/letsencrypt/live/zaraconsultingss.com/fullchain.pem
Key is saved at:         /etc/letsencrypt/live/zaraconsultingss.com/privkey.pem
This certificate expires on 2025-12-03.
These files will be updated when the certificate renews.
Certbot has set up a scheduled task to automatically renew this certificate in the background.

Deploying certificate
Successfully deployed certificate for zaraconsultingss.com to /etc/nginx/sites-enabled/zaraconsultingss
Successfully deployed certificate for www.zaraconsultingss.com to /etc/nginx/sites-enabled/zaraconsultingss
Congratulations! You have successfully enabled HTTPS on https://zaraconsultingss.com and https://www.zaraconsultingss.com

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
If you like Certbot, please consider supporting our work by:
 * Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
 * Donating to EFF:                    https://eff.org/donate-le
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ubuntu@ip-xxx-xx-xx-xxx:~/zara_source$ sudo certbot renew --dry-run
Saving debug log to /var/log/letsencrypt/letsencrypt.log

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Processing /etc/letsencrypt/renewal/zaraconsultingss.com.conf
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Account registered.
Simulating renewal of an existing certificate for zaraconsultingss.com and www.zaraconsultingss.com

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Congratulations, all simulated renewals succeeded: 
  /etc/letsencrypt/live/zaraconsultingss.com/fullchain.pem (success)
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
ubuntu@ip-xxx-xx-xx-xxx:~/zara_source$ 

```

---

## 7. 배포 확인 및 테스트

### 7.1 서비스 상태 확인
```bash
# PM2 프로세스 확인
pm2 status

# Nginx 상태 확인
sudo systemctl status nginx

# 포트 사용 현황 확인
sudo netstat -tlnp | grep -E ':(80|443|3000)'
```

### 7.2 웹 브라우저 테스트
1. http://www.zaraconsultingss.com 접속
2. https://www.zaraconsultingss.com 자동 리다이렉트 확인
3. SSL 인증서 확인 (브라우저 주소창 자물쇠 아이콘)
4. 사이트 정상 동작 확인

### 7.3 DNS 전파 확인
```bash
# DNS 조회 테스트
nslookup www.zaraconsultingss.com
dig www.zaraconsultingss.com
```

---

## 8. 유지보수

### 8.1 코드 업데이트

**8.1.1 SSH 접속**
```bash
# 로컬 터미널에서 SSH 접속 (.pem 파일 있는 위치에서 실행)
ssh -i ./zara-consulting-key.pem ubuntu@[탄력적_IP_주소]
```

  AWS EC2에서 탄력적 IP 주소 확인 방법:
  1. AWS 콘솔 → EC2 → 네트워크 및 보안 → 탄력적 IP
  2. 또는 EC2 → 인스턴스 → 해당 인스턴스 선택 → 퍼블릭 IPv4 주소 확인

  * Error case
    * 1.
    * ssh: connect to host [IP address] port 22: Connection refused
    * reason: Different IP address by changing ip address with hotspot or wifi. 핫스팟 연결할 때랑 와이파이 연결할때 둘다 ip 가 달라서 벌어지는 상황. 
    * solution : IP는 핸드폰 핫스팟으로 고정, 즉 배포는 보안을 위해 핸드폰 핫스팟 연결해서 할 것. aws ec2 > Network & Security > Security Groups > SSH > Inbound Rules > Edit > Source = Custom -> My IP

    * 2. 
    * Instance status checks: Instance reachability check failed
      1. Instance ran out of memory or CPU - System became unresponsive
      2. Misconfigured network settings - Firewall rules or network config broke SSH access
      3. Kernel panic or system crash
      4. Full disk space - The system can't operate
      5. Incorrect file system modifications
    * solution : In AWS Console → EC2 → Instances → Select the instance → Actions → Instance State → Reboot Instance

    * 3.
    * 502 bad gateway error
    * reason:   The .next/BUILD_ID file is missing - this means the app was never built or the build folder is incomplete/corrupted. You cannot run npm start (production mode) without first running npm run build.
    * solution :  cd ~/zara_source -> npm run build -> pm2 restart zara-consulting




**8.1.2 프로젝트 디렉토리 이동**
```bash
cd ~/zara_source
```

**8.1.3 최신 코드 가져오기**
```bash
git pull origin main
```

**8.1.4 의존성 업데이트**
```bash
npm install
```

**8.1.5 프로덕션 빌드**
```bash
npm run build
```

**8.1.6 PM2 재시작**
```bash
pm2 restart zara-consulting
```

**8.1.7 상태 확인**
```bash
pm2 status
```

### 8.2 로그 모니터링
```bash
# PM2 로그
pm2 logs zara-consulting

# Nginx 에러 로그
sudo tail -f /var/log/nginx/error.log

# Nginx 접속 로그
sudo tail -f /var/log/nginx/access.log
```

### 8.3 서버 재시작
```bash
# PM2 애플리케이션 재시작
pm2 restart zara-consulting

# Nginx 재시작
sudo systemctl restart nginx

# 서버 재부팅
sudo reboot
```

---

## 💰 예상 비용
- **EC2 t2.micro**: 프리티어 12개월 무료
- **탄력적 IP**: EC2 연결시 무료
- **Route 53 호스팅 존**: $0.50/월
- **도메인**: $12-15/년 (.com 기준)
- **월 총 비용**: 약 $1.5 (프리티어 기간)