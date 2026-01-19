
Swap memory
================================================================================
  로그를 보면 애플리케이션은 정상 시작되었지만, 헬스체크 중에 kill됩니다. 이는 EC2 인스턴스의  
  다른 프로세스가 메모리를 사용하고 있거나, 스왑 메모리가 없을 가능성이 있습니다.  

- 스왑 메모리(Swap Memory)란?                                                                  
                                                                                               
  비유:                                                                                        
  - RAM(물리 메모리): 책상 위의 작업 공간                                                      
  - 스왑(디스크 공간): 책상 옆 서랍                                                            
                                                                                               
  책상이 가득 차면 덜 중요한 서류를 서랍에 넣고, 필요할 때 다시 꺼냅니다.                      
                                                                                               
  기술적 정의:                                                                                 
  - 디스크를 RAM처럼 사용하는 가상 메모리                                                      
  - RAM이 부족할 때 임시로 사용                                                                
  - 느리지만 시스템이 죽는 것을 방지                                                           
                                                                                               
  왜 스왑이 없으면 프로세스가 Kill되나?                                                        
                                                                                               
  Linux OOM (Out Of Memory) Killer 작동 방식:                                                  
                                                                                               
  RAM 사용량 증가 → 100% 도달                                                                  
           ↓                                                                                   
     스왑 메모리 있음?                                                                         
           ↓                                                                                   
      NO → 긴급 상황!                                                                          
           ↓                                                                                   
     프로세스 강제 종료 (Killed)                                                               
     (메모리를 많이 쓰는 프로세스 우선)                                                        
                                                                                               
  EC2에서 일어난 일:                                                                           
  1. Java 애플리케이션 시작                                                                    
  2. RAM 3.8GB 중 약 3GB 사용                                                                  
  3. 헬스체크 요청 → Spring이 추가 메모리 필요                                                 
  4. RAM 부족 → 스왑 없음!                                                                     
  5. OOM Killer: "Java 프로세스가 메모리를 가장 많이 쓰네?" → KILL!                            
                                                                                               
  Java가 메모리를 많이 쓰는 이유                                                               
                                                                                               
  1. JVM (Java Virtual Machine) 구조                                                           
                                                                                               
  Java는 OS 위에서 자체 가상 머신을 실행합니다:                                                
                                                                                               
  ┌─────────────────────────────┐                                                              
  │   Java Application          │                                                              
  ├─────────────────────────────┤                                                              
  │   JVM (Java Virtual Machine)│                                                              
  │   - Heap (객체 저장)        │  ← 여기서 메모리 많이 씀                                     
  │   - Metaspace (클래스 정보) │                                                              
  │   - Thread Stack            │                                                              
  │   - Garbage Collector       │                                                              
  ├─────────────────────────────┤                                                              
  │   Operating System          │                                                              
  └─────────────────────────────┘                                                              
                                                                                               
  2. Spring Boot가 특히 메모리를 많이 쓰는 이유                                                
                                                                                               
  Spring Boot는 기능이 많습니다:                                                               
                                                                                               
  // 애플리케이션 시작 시 메모리에 로드되는 것들:                                              
                                                                                               
  1. Spring Framework 자체                                                                     
     - IoC Container                                                                           
     - Bean Factory                                                                            
     - Dependency Injection                                                                    
                                                                                               
  2. Spring Boot Auto-configuration                                                            
     - Tomcat 웹 서버                                                                          
     - Hibernate (JPA)                                                                         
     - Security                                                                                
     - Actuator                                                                                
     - Jackson (JSON 처리)                                                                     
                                                                                               
  3. 데이터베이스 연결 풀                                                                      
     - HikariCP (최소 10개 연결 유지)                                                          
                                                                                               
  4. 애플리케이션 코드                                                                         
     - Entity 클래스                                                                           
     - Repository                                                                              
     - Service                                                                                 
     - Controller                                                                              
                                                                                               
  3. 메모리 사용 패턴                                                                          
                                                                                               
  시작 시:                                                                                     
  초기 메모리: 256MB (Xms256m)                                                                 
        ↓                                                                                      
  클래스 로딩, Bean 생성                                                                       
        ↓                                                                                      
  메모리 증가: 400-500MB                                                                       
                                                                                               
  첫 HTTP 요청 시 (헬스체크):                                                                  
  Spring DispatcherServlet 초기화                                                              
        ↓                                                                                      
  추가 Bean 로딩 (지연 로딩)                                                                   
        ↓                                                                                      
  메모리 급증: 600-800MB                                                                       
        ↓                                                                                      
  스왑 없으면 → KILLED!                                                                        
                                                                                               
  왜 배포 중에 특히 문제가 되는가?                                                             
                                                                                               
  배포 스크립트의 타이밍:                                                                      
                                                                                               
  1. 애플리케이션 시작                                                                         
     nohup java -jar app.jar &                                                                 
                                                                                               
  2. PID 저장                                                                                  
     echo $! > app.pid                                                                         
                                                                                               
  3. 15초 대기                                                                                 
     sleep 15                                                                                  
                                                                                               
  4. 헬스체크 시작 (12번 시도, 5초 간격)                                                       
     curl http://localhost:8005/actuator/health                                                
                                                                                               
     ← 여기서 첫 HTTP 요청 발생!                                                               
     ← Spring이 추가 초기화 수행                                                               
     ← 메모리 급증!                                                                            
     ← 스왑 없으면 OOM Killer 발동                                                             
                                                                                               
  로그에서 본 것:                                                                              
                                                                                               
  Started SfxaApiServerApplication in 11.294 seconds  ← 시작 성공                              
  Tomcat started on port 8005                         ← 시작 성공                              
  Initializing Spring DispatcherServlet               ← 첫 요청 처리 시작                      
  bash: line 177: 31899 Killed                        ← 메모리 부족으로 Kill!                  
                                                                                               
  해결책 정리                                                                                  
                                                                                               
  1. Java 힙 메모리 제한 (-Xmx1024m -Xms512m)                                                  
                                                                                               
  의미:                                                                                        
  - -Xms512m: 시작 시 512MB 할당                                                               
  - -Xmx1024m: 최대 1GB까지만 사용                                                             
                                                                                               
  효과:                                                                                        
  - Java가 무한정 메모리를 요구하지 못하게 제한                                                
  - 다른 프로세스와 메모리 공유                                                                
                                                                                               
  2. 스왑 메모리 추가 (2GB)                                                                    
                                                                                               
  효과:                                                                                        
  - RAM이 부족해도 즉시 kill되지 않음                                                          
  - 일시적 메모리 급증을 스왑으로 처리                                                         
  - 속도는 느리지만 안정성 확보                                                                
                                                                                               
  전체 구조:                                                                                   
                                                                                               
  총 가용 메모리: 3.8GB RAM + 2GB Swap = 5.8GB                                                 
                                                                                               
  사용 중:                                                                                     
  - Java (최대 1GB)                                                                            
  - Next.js (184MB)                                                                            
  - 시스템 프로세스 (~500MB)                                                                   
  - 여유 공간 (~4GB)                                                                           
                                                                                               
  → 안정적으로 실행 가능!                                                                      
                                                                                               
  비유로 정리                                                                                  
                                                                                               
  스왑 없을 때:                                                                                
  책상(RAM): 3.8GB                                                                             
  서류(Java): "1GB 필요해요"                                                                   
  책상: "꽉 찼는데?"                                                                           
  매니저(OOM Killer): "그럼 Java를 내보내!" → KILLED                                           
                                                                                               
  스왑 있을 때:                                                                                
  책상(RAM): 3.8GB                                                                             
  서랍(Swap): 2GB                                                                              
  서류(Java): "1GB 필요해요"                                                                   
  책상: "꽉 찼으니 덜 중요한 걸 서랍에 넣을게"                                                 
  → 천천히지만 계속 작동  


- situation: 
Github Actions에서 ec2로 자동 배포하는 중에 실패함. 

- diagnosys:
핵심 문제: 스왑 메모리가 없습니다!                                                           
                                                                                               
  현재 상황:                                                                                   
  - 총 메모리: 3.8GB                                                                           
  - 사용 가능: 2.8GB (충분함)                                                                  
  - Java 앱: 416MB 사용 중                                                                     
  - Next.js 서버: 184MB 사용 중                                                                
  - 스왑: 0B ← 이게 문제!                                                                      
                                                                                               
  왜 Kill되는가?                                                                               
                                                                                               
  스왑 메모리가 없으면, JVM이 초기화/GC 중 일시적으로 메모리가 급증할 때 OOM Killer가 즉시     
  프로세스를 죽입니다. 로그를 보면 애플리케이션은 시작되지만, 첫 HTTP 요청(헬스체크) 처리 시   
  추가 메모리가 필요해서 kill됩니다.                                                           
                                                                                               
  해결 방법: 스왑 메모리 추가                                                                  
                                                                                               
  EC2에서 다음 명령어를 실행하세요:                                                            
                                                                                               
  # 2GB 스왑 파일 생성                                                                         
  sudo fallocate -l 2G /swapfile                                                               
                                                                                               
  # 권한 설정                                                                                  
  sudo chmod 600 /swapfile                                                                     
                                                                                               
  # 스왑 영역으로 설정                                                                         
  sudo mkswap /swapfile                                                                        
                                                                                               
  # 스왑 활성화                                                                                
  sudo swapon /swapfile                                                                        
                                                                                               
  # 확인                                                                                       
  free -h                                                                                      
                                                                                               
  영구 설정 (재부팅 후에도 유지):                                                              
  # /etc/fstab에 추가                                                                          
  echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab                                   
                                                                                               
  # 확인                                                                                       
  cat /etc/fstab | grep swapfile                                                               
                                                                                               
  스왑 설정 최적화 (선택 사항):                                                                
  # 스왑 사용 빈도 조절 (기본 60 → 10으로 낮춤)                                                
  sudo sysctl vm.swappiness=10                                                                 
                                                                                               
  # 영구 설정                                                                                  
  echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf                                       
                                                                                               
  스왑 추가 후                                                                                 
                                                                                               
  스왑 추가가 완료되면:                                                                        
                                                                                               
  # 스왑 확인                                                                                  
  free -h                                                                                      
                                                                                               
  Swap 줄에 2GB가 표시되어야 합니다:                                                           
  Swap:           2.0Gi          0B       2.0Gi    


     
================================================================================