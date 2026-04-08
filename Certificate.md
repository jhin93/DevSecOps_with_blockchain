
## 1순위: AWS SAA 취득
모든 것의 기반이다. AWS SAA가 있으면 Cloud Riverdale 인프라 개선 작업의 신뢰도가 올라가고, 이력서의 기술 스택 검증이 된다. CKA보다 먼저 하는 이유는 루마니아 JD에서 AWS 경험이 Kubernetes보다 더 자주 등장하고, SAA 공부 중 배우는 내용을 Cloud Riverdale에 즉시 적용할 수 있기 때문이다.

## 2순위: Terraform으로 현재 인프라 코드화 (AWS SAA 공부와 병렬)
AWS SAA 공부하면서 동시에 진행한다. 지금 수동으로 구성된 EC2, VPC, IAM 등을 Terraform으로 코드화하는 작업이다. 공부한 내용을 바로 적용하기 때문에 학습 속도도 빠르고, 완성되면 GitHub 레포가 생기면서 포트폴리오 문제도 해결된다. IaC 갭도 동시에 메워진다.

## 3순위: CKA 취득 (AWS SAA 취득 후)
AWS SAA 취득 후 바로 시작한다. CKA는 실습 기반 시험이라 공부하면서 Cloud Riverdale 서비스를 Kubernetes로 운영하는 작업을 병행한다. CI/CD 파이프라인에 K8s 배포를 통합하면 경력 기술서가 한층 강해진다.

## 4순위: 모니터링 스택 구성 (CKA 공부와 병렬)
Prometheus + Grafana를 Cloud Riverdale 프로덕션에 붙인다. CKA 공부 중 어차피 모니터링 개념이 나오기 때문에 병렬로 진행하기 좋다. 완성되면 "프로덕션 모니터링 구축 경험"이 이력서에 추가된다.

## 5순위: 3번째 자격증 결정 및 취득
CKA 취득 후 진행한다. 목표가 DevSecOps면 Terraform Associate 또는 CKS(Certified Kubernetes Security Specialist) 중 하나다. Terraform Associate는 2순위에서 이미 실무 경험을 쌓았기 때문에 준비 기간이 짧다. CKS는 CKA 이후에만 응시 가능하고 DevSecOps 방향성과 가장 직접 연결된다. Oct 2026 타임라인에 맞는지 확인 후 결정한다.

## 6순위: Cloud Riverdale 계약 연장 또는 대체 경력 확보
Jun 2026 계약 종료 후 갭이 생기지 않도록 지금부터 준비한다. 연장이 가능하면 연장, 불가능하면 루마니아 현지 또는 원격 junior DevOps 포지션 지원을 Jun 2026 이전에 시작한다. 이게 늦어지면 Oct 2026 졸업 시점에 4개월 갭이 생긴다.


## 취득 순서: SAA → Terraform → CKA

---

### 이유

**1단계: AWS SAA**
- 준비 시간: 40~80시간
- Terraform과 CKA 모두 클라우드 인프라 이해를 전제한다. SAA가 이 베이스를 만든다.
- 먼저 따지 않으면 Terraform 공부할 때 AWS 리소스 개념을 동시에 배워야 해서 비효율적이다.

**2단계: Terraform Associate (004)**
- 준비 시간: 2~6주 (하루 1~2시간)
- SAA로 쌓은 AWS 리소스 지식을 IaC로 그대로 연결 가능하다. 지식 전이율이 높다.
- 상대적으로 짧고 객관식 시험이라 CKA 전에 빠르게 처리하고 가는 게 효율적이다.

**3단계: CKA**
- 준비 시간: 60~120시간 이상 (랩 중심)
- performance-based 시험이라 3개 중 난이도가 가장 높다.
- SAA + Terraform으로 클라우드/인프라 개념이 잡힌 상태에서 접근해야 쿠버네티스 네트워킹, 스토리지 개념이 더 빠르게 연결된다.
- 마지막에 집중 투자하는 게 맞다.

---

## 전체 타임라인 추정

| 단계 | 기간 |
|---|---|
| AWS SAA | 1.5~2개월 |
| Terraform Associate | 1~1.5개월 |
| CKA | 2~3개월 |
| **총합** | **약 5~6개월** |

졸업(2026년 12월) 전에 병행 가능한 일정이다.

---

**[Confidence Level]**
High — 지식 의존성 구조는 명확하고, 준비 시간 수치는 이전 검색 결과에서 확인된 값이다.

**[Caveats]**
- 현재 Cloud Riverdale에서 DevOps 실무 중이므로 CKA 랩 실습 시간은 실무와 병행 시 단축 가능
- Terraform은 이미 실무에서 쓰고 있다면 1단계로 앞당겨도 무방