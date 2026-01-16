# DevSecOps Learning Roadmap & Certification Strategy
## 12-Month Plan: From Blockchain Developer to Mid-Level DevSecOps Engineer

## 📋 Table of Contents
1. [Learning Philosophy](#learning-philosophy)
2. [Monthly Learning Plan](#monthly-learning-plan)
3. [Certification Strategy](#certification-strategy)
4. [Learning Resources](#learning-resources)
5. [Study Platforms](#study-platforms)
6. [Budget Planning](#budget-planning)
7. [Weekly Study Schedule](#weekly-study-schedule)
8. [Success Tracking](#success-tracking)

---

## 1. Learning Philosophy

### 🎯 Learning Objectives

**Primary Goal:** Achieve Mid-Level DevSecOps Engineer competency through:
- Deep technical knowledge (not just surface-level)
- Practical hands-on experience (60% practice, 40% theory)
- Industry-recognized certifications (3 critical certifications)
- Real-world problem solving (Bug Bounty, OSS contributions)

**Learning Approach:**
```yaml
Theory (40%):
  - Video courses (structured learning)
  - Official documentation (authoritative source)
  - Books (deep understanding)
  
Practice (60%):
  - Hands-on labs (guided exercises)
  - Personal projects (real infrastructure)
  - CTF challenges (gamified learning)
  - Bug bounty (real vulnerabilities)
```

### 💡 Key Principles

1. **Spaced Repetition**: Review material 3 times (Day 1, Week 1, Month 1)
2. **Active Learning**: Build something with every new concept
3. **Public Learning**: Document progress (blog, GitHub)
4. **Community Engagement**: Ask questions, help others
5. **Consistency Over Intensity**: 2-3 hours daily beats 10-hour weekends

---

## 2. Monthly Learning Plan

### **Month 1: Linux Fundamentals & Security Hardening**

#### Week 1-2: Linux Basics
**Study Materials:**
- Course: "Linux Foundation LFS101x" (Free, edX)
- Book: "The Linux Command Line" by William Shotts
- Practice: Linux Journey (https://linuxjourney.com)

**Topics:**
- File system hierarchy (/etc, /var, /usr)
- User/group management
- Permissions (chmod, chown, setuid/setgid)
- Process management (ps, top, kill, systemd)
- Package management (apt, yum)

**Hands-On:**
- [ ] Set up Ubuntu VM (VirtualBox or AWS EC2)
- [ ] Complete 50+ CLI exercises (Linux Journey)
- [ ] Write 5 shell scripts (backup, log parser, etc.)

#### Week 3-4: Security Hardening
**Study Materials:**
- Course: "Linux Security and Hardening" (Udemy)
- Documentation: CIS Benchmarks for Ubuntu
- Tool: Lynis (automated security audit)

**Topics:**
- SSH hardening (key-based auth, port change)
- Firewall configuration (iptables, ufw)
- Fail2Ban setup
- Kernel parameter tuning (sysctl.conf)
- SELinux/AppArmor basics

**Hands-On:**
- [ ] Harden SSH configuration (score 100/100 with ssh-audit)
- [ ] Configure iptables rules (block all except 22, 80, 443)
- [ ] Achieve Lynis score 85+ (from baseline ~60)

**Assessment:**
- [ ] Complete Linux Security Quiz (TryHackMe)
- [ ] Write blog post: "10 Essential Linux Security Hardening Steps"

---

### **Month 2: Shell Scripting & Automation**

#### Week 1-2: Bash Scripting
**Study Materials:**
- Course: "Bash Scripting and Shell Programming" (Udemy)
- Book: "The AWK Programming Language" (Aho, Weinberger, Kernighan)
- Practice: HackerRank Shell Scripting

**Topics:**
- Variables, conditionals, loops
- Functions and error handling
- Text processing (awk, sed, grep)
- Regular expressions
- Debugging techniques (set -x, trap)

**Hands-On:**
- [ ] Build log analyzer script (awk + grep)
- [ ] Create backup automation script
- [ ] Develop system health check script
- [ ] Complete 20 HackerRank challenges

#### Week 3-4: Advanced Automation
**Study Materials:**
- Documentation: Bash manual (man bash)
- GitHub: Browse popular bash scripts

**Topics:**
- Argument parsing (getopts)
- Signal handling (trap)
- Parallel execution (xargs, GNU parallel)
- Cron jobs and systemd timers
- Script performance optimization

**Hands-On:**
- [ ] Create security audit automation suite
- [ ] Build IPFS integrity checker
- [ ] Develop automated patching script
- [ ] Set up cron jobs for monitoring

**Assessment:**
- [ ] All scripts in GitHub with documentation
- [ ] Code review by online community

---

### **Month 3: Networking & CVE Analysis**

#### Week 1-2: Networking Deep Dive
**Study Materials:**
- Course: "Computer Networking" (Coursera - University of Illinois)
- Book: "TCP/IP Illustrated, Vol. 1" (Richard Stevens)
- Practice: Wireshark tutorials

**Topics:**
- OSI 7-layer model
- TCP/IP suite (TCP handshake, UDP, ICMP)
- DNS, DHCP, ARP
- VPN, NAT, Subnetting
- Network troubleshooting (tcpdump, netstat, ss)

**Hands-On:**
- [ ] Analyze 10 packet captures (Wireshark)
- [ ] Configure VPN server (OpenVPN)
- [ ] Set up DNS server (BIND)
- [ ] Troubleshoot network issues (labs)

#### Week 3-4: CVE Research & Exploitation
**Study Materials:**
- Database: NVD (https://nvd.nist.gov)
- Course: "Ethical Hacking Essentials" (EC-Council free)
- Practice: TryHackMe CVE rooms

**Topics:**
- CVE numbering system
- CVSS scoring
- Exploit databases (Exploit-DB, Metasploit)
- Vulnerability assessment
- Penetration testing basics

**Hands-On:**
- [ ] Analyze 20 CVEs (see project README)
- [ ] Exploit 5 vulnerable machines (Metasploitable, DVWA)
- [ ] Write PoC exploits for 3 CVEs
- [ ] Document findings in portfolio

**Assessment:**
- [ ] Present 5-minute CVE analysis to study group
- [ ] Publish CVE analysis blog post

---

### **Month 4: AWS Fundamentals & SAA Certification**

#### Week 1-2: AWS Core Services
**Study Materials:**
- Course: "AWS Certified Solutions Architect Associate" (Udemy - Stephane Maarek)
- Documentation: AWS Well-Architected Framework
- Practice: AWS Free Tier hands-on

**Topics:**
- Compute (EC2, Auto Scaling, Lambda)
- Storage (S3, EBS, EFS)
- Database (RDS, DynamoDB)
- Networking (VPC, Route 53, CloudFront)
- Security (IAM, KMS, CloudTrail)

**Hands-On:**
- [ ] Deploy 3-tier web application on AWS
- [ ] Configure VPC with public/private subnets
- [ ] Set up RDS Multi-AZ database
- [ ] Create S3 bucket with versioning and encryption

#### Week 3-4: SAA Exam Preparation
**Study Materials:**
- Practice Exams: TutorialsDojo (6 full exams)
- Flashcards: Anki deck (AWS SAA)
- Video: AWS re:Invent sessions

**Topics:**
- High availability and fault tolerance
- Cost optimization
- Performance efficiency
- Operational excellence
- Security best practices

**Hands-On:**
- [ ] Complete 6 practice exams (target: 80%+ score)
- [ ] Review incorrect answers (Anki flashcards)
- [ ] Build 3 mini-projects (serverless, containers, ML)

**Assessment:**
- [ ] **AWS SAA Certification Exam** (Month 4, Week 4)
- [ ] Share certificate on LinkedIn

---

### **Month 5: Terraform & Infrastructure as Code**

#### Week 1-2: Terraform Basics
**Study Materials:**
- Course: "HashiCorp Certified: Terraform Associate" (A Cloud Guru)
- Documentation: Terraform official docs
- Practice: Terraform Cloud free tier

**Topics:**
- HCL syntax (blocks, arguments, expressions)
- Providers and resources
- State management (local vs remote)
- Variables and outputs
- Modules and workspaces

**Hands-On:**
- [ ] Create VPC module (reusable)
- [ ] Deploy EKS cluster with Terraform
- [ ] Set up remote state in S3 with DynamoDB locking
- [ ] Build 5 custom modules

#### Week 3-4: Advanced IaC & Policy-as-Code
**Study Materials:**
- Course: "Advanced Terraform" (Linux Academy)
- Documentation: Sentinel documentation
- Tool: Terragrunt

**Topics:**
- Terraform Cloud integration
- Sentinel policies (enforcement)
- Terragrunt (DRY principle)
- Terraform testing (Terratest)
- CI/CD for IaC

**Hands-On:**
- [ ] Write 5 Sentinel policies
- [ ] Restructure project with Terragrunt
- [ ] Set up Terraform CI/CD pipeline
- [ ] Implement drift detection

**Assessment:**
- [ ] Deploy entire infrastructure from code (zero manual)
- [ ] Pass Sentinel policy checks

---

### **Month 6: AWS Security Specialty Certification**

#### Week 1-2: AWS Security Services
**Study Materials:**
- Course: "AWS Certified Security Specialty" (A Cloud Guru)
- Documentation: AWS Security documentation
- Whitepaper: AWS Security Pillar

**Topics:**
- Identity & Access (IAM, Cognito, SSO)
- Detection (GuardDuty, Security Hub, Macie)
- Infrastructure Protection (WAF, Shield, Firewall Manager)
- Data Protection (KMS, Secrets Manager, Certificate Manager)
- Incident Response (CloudWatch, Config, Systems Manager)

**Hands-On:**
- [ ] Configure AWS Security Hub (centralized findings)
- [ ] Set up GuardDuty threat detection
- [ ] Create AWS Config Rules for compliance
- [ ] Implement KMS key rotation
- [ ] Deploy AWS WAF rules (OWASP Top 10)

#### Week 3-4: Security Specialty Exam Prep
**Study Materials:**
- Practice Exams: TutorialsDojo Security Specialty (4 exams)
- Book: "AWS Security" (Dylan Shields)
- Video: AWS Security webcasts

**Topics:**
- Incident response in AWS
- Logging and monitoring
- Security automation
- Compliance frameworks (PCI-DSS, HIPAA, SOC2)
- Penetration testing in AWS

**Hands-On:**
- [ ] Simulate security incident response
- [ ] Complete 4 practice exams (target: 75%+)
- [ ] Build security automation with Lambda

**Assessment:**
- [ ] **AWS Security Specialty Certification Exam** (Month 6, Week 4)
- [ ] Update LinkedIn and resume

---

### **Month 7: Container Security & Docker**

#### Week 1-2: Docker Mastery
**Study Materials:**
- Course: "Docker & Kubernetes: The Complete Guide" (Udemy - Stephen Grider)
- Book: "Docker Deep Dive" (Nigel Poulton)
- Practice: Play with Docker (labs.play-with-docker.com)

**Topics:**
- Container architecture (namespaces, cgroups)
- Dockerfile best practices (multi-stage, caching)
- Docker Compose (orchestration)
- Docker networking (bridge, host, overlay)
- Volume management (bind mounts, volumes)

**Hands-On:**
- [ ] Build 10 optimized Dockerfiles
- [ ] Create multi-service app with Docker Compose
- [ ] Implement health checks
- [ ] Set up private Docker registry

#### Week 3-4: Container Security Hardening
**Study Materials:**
- Guide: Docker CIS Benchmark
- Tool: Docker Bench for Security
- Course: "Container Security Fundamentals" (Linux Foundation)

**Topics:**
- Non-root containers
- Linux capabilities (dropping)
- Seccomp profiles
- AppArmor/SELinux profiles
- Container image scanning

**Hands-On:**
- [ ] Harden 5 Docker containers
- [ ] Run Docker Bench (achieve 80%+ compliance)
- [ ] Integrate Trivy in Docker build
- [ ] Create custom seccomp profile

**Assessment:**
- [ ] All containers pass security scans (zero critical)
- [ ] Docker Bench score 80%+

---

### **Month 8: Kubernetes & CKS Certification**

#### Week 1-2: Kubernetes Fundamentals
**Study Materials:**
- Course: "Certified Kubernetes Administrator (CKA)" (KodeKloud)
- Documentation: Kubernetes official docs
- Practice: Kubernetes The Hard Way

**Topics:**
- K8s architecture (control plane, nodes)
- Pods, Deployments, Services, Ingress
- ConfigMaps and Secrets
- Persistent Volumes
- Scheduling and affinity

**Hands-On:**
- [ ] Deploy multi-tier app in Kubernetes
- [ ] Configure Ingress with TLS
- [ ] Implement resource quotas
- [ ] Set up autoscaling (HPA, VPA)

#### Week 3-4: CKS Certification Prep
**Study Materials:**
- Course: "Certified Kubernetes Security Specialist (CKS)" (KodeKloud)
- Practice: Killer.sh CKS simulator (×2 attempts)
- Documentation: K8s security docs

**Topics:**
- Cluster hardening (kube-apiserver, etcd)
- Pod Security Standards (Baseline, Restricted)
- Network Policies (isolation)
- RBAC (least privilege)
- Supply chain security (image signing)
- Runtime security (Falco)

**Hands-On:**
- [ ] Complete all CKS labs (KodeKloud)
- [ ] Complete Killer.sh simulator (×2, score 80%+)
- [ ] Harden K8s cluster (CIS Benchmark)
- [ ] Deploy Falco and create custom rules

**Assessment:**
- [ ] **CKS Certification Exam** (Month 8, Week 4)
- [ ] Share certificate on LinkedIn

---

### **Month 9: CI/CD Security Pipelines**

#### Week 1-2: GitHub Actions Mastery
**Study Materials:**
- Documentation: GitHub Actions docs
- Course: "GitHub Actions for CI/CD" (Coursera)
- Examples: Explore popular GitHub repos

**Topics:**
- Workflow syntax (triggers, jobs, steps)
- Secrets management
- Matrix builds
- Caching strategies
- Reusable workflows

**Hands-On:**
- [ ] Build 5-stage security pipeline
- [ ] Integrate SAST tools (SonarQube, Semgrep)
- [ ] Add container scanning (Trivy, Snyk)
- [ ] Implement IaC scanning (tfsec, Checkov)

#### Week 3-4: Advanced Security Automation
**Study Materials:**
- Tool: GitHub Advanced Security (CodeQL)
- Documentation: OWASP SAMM
- Course: "DevSecOps Fundamentals" (PracticalDevSecOps)

**Topics:**
- SAST vs DAST vs IAST
- Shift-left security
- Security gates and policies
- Automated remediation
- Vulnerability management

**Hands-On:**
- [ ] Add DAST with OWASP ZAP
- [ ] Implement security gates (fail on critical)
- [ ] Create security metrics dashboard
- [ ] Automate vulnerability patching

**Assessment:**
- [ ] Complete security pipeline (7 stages)
- [ ] Zero critical vulnerabilities pass through

---

### **Month 10: Observability & Monitoring**

#### Week 1-2: Prometheus & Grafana
**Study Materials:**
- Course: "Monitoring with Prometheus" (Udemy)
- Book: "Prometheus: Up & Running" (Brian Brazil)
- Practice: PromLabs exercises

**Topics:**
- Prometheus architecture
- PromQL queries (aggregation, functions)
- Service discovery
- Recording rules and alerts
- Grafana dashboards

**Hands-On:**
- [ ] Deploy Prometheus Operator
- [ ] Create 5 custom dashboards
- [ ] Set up alerting (AlertManager)
- [ ] Configure PagerDuty integration

#### Week 3-4: ELK Stack & Distributed Tracing
**Study Materials:**
- Course: "Complete Guide to Elasticsearch" (Udemy)
- Documentation: Jaeger docs
- Tool: OpenTelemetry

**Topics:**
- Elasticsearch basics (indexing, querying)
- Logstash pipelines (grok patterns)
- Kibana visualizations
- Distributed tracing (Jaeger)
- OpenTelemetry instrumentation

**Hands-On:**
- [ ] Deploy ELK Stack
- [ ] Create security dashboards (failed logins, etc.)
- [ ] Integrate Jaeger tracing
- [ ] Instrument application with OpenTelemetry

**Assessment:**
- [ ] Full 3-pillar observability (Metrics, Logs, Traces)
- [ ] Detect anomalies within 5 minutes

---

### **Month 11: Practical Security Experience**

#### Week 1-2: Bug Bounty Hunting
**Study Materials:**
- Platform: TryHackMe, HackTheBox (complete 20 rooms)
- Course: "Web Application Penetration Testing" (PortSwigger Academy)
- Tool: Burp Suite Pro (free trial)

**Topics:**
- OWASP Top 10 (practical exploitation)
- Authentication/authorization flaws
- Injection attacks (SQL, XSS, command)
- Insecure deserialization
- SSRF and XXE

**Hands-On:**
- [ ] Complete PortSwigger Academy (all labs)
- [ ] Submit 5+ bug reports (HackerOne/Bugcrowd)
- [ ] Achieve 3 valid submissions
- [ ] Document findings (portfolio)

#### Week 3-4: Open-Source Contributions
**Study Materials:**
- Guide: "How to Contribute to Open Source" (GitHub)
- Projects: CNCF landscape (choose 3)
- Community: Join Slack/Discord channels

**Topics:**
- Git advanced (rebase, squash, cherry-pick)
- Code review best practices
- Writing good PRs
- Communication in OSS

**Hands-On:**
- [ ] Fix 2 documentation issues
- [ ] Add 1 unit test
- [ ] Fix 1 bug (code contribution)
- [ ] Add 1 security improvement
- [ ] Review 5 PRs from others

**Assessment:**
- [ ] 5+ merged PRs
- [ ] Active contributor badge (1 project)

---

### **Month 12: Portfolio & Job Preparation**

#### Week 1-2: Portfolio Development
**Study Materials:**
- Guide: "How to Build a Developer Portfolio" (freeCodeCamp)
- Examples: Browse portfolios on GitHub

**Topics:**
- Technical writing
- Project documentation
- Case study structure (problem → solution → result)
- Visual design (architecture diagrams)

**Hands-On:**
- [ ] Complete all project README files
- [ ] Create 5 architecture diagrams
- [ ] Write 3 blog posts
- [ ] Record 1 video demo (10 minutes)
- [ ] Build portfolio website (optional)

#### Week 3: UTS Master's Graduation
**Milestones:**
- [ ] Complete all coursework
- [ ] Submit final project (if applicable)
- [ ] Attend graduation ceremony (October 2026)
- [ ] Obtain official transcript

#### Week 4: Interview Preparation
**Study Materials:**
- Book: "Cracking the Coding Interview" (Gayle McDowell)
- Practice: LeetCode (20 easy, 10 medium problems)
- Mock Interviews: Pramp, Interviewing.io

**Topics:**
- STAR method (behavioral questions)
- System design interviews
- Technical deep-dives
- Salary negotiation

**Hands-On:**
- [ ] Prepare 10 STAR stories
- [ ] Practice 5 system design problems
- [ ] Complete 30 LeetCode problems
- [ ] Conduct 3 mock interviews

**Assessment:**
- [ ] Ready to apply for Mid-Level DevSecOps roles
- [ ] CV/resume updated with quantifiable achievements

---

## 3. Certification Strategy

### 🎓 Certification Timeline
```yaml
Month 5 (May 2026):
  Certification: AWS Solutions Architect Associate
  Cost: $150 USD
  Preparation Time: 60-80 hours
  Pass Rate: 85% (industry average)
  Validity: 3 years
  
Month 6 (June 2026):
  Certification: AWS Certified Security - Specialty
  Cost: $300 USD
  Preparation Time: 80-100 hours
  Pass Rate: 70% (harder)
  Validity: 3 years
  
Month 8 (August 2026):
  Certification: Certified Kubernetes Security Specialist (CKS)
  Cost: $395 USD
  Preparation Time: 60-80 hours
  Pass Rate: 65% (very challenging)
  Validity: 2 years
  
Optional - Month 11 (November 2026):
  Certification: Offensive Security Certified Professional (OSCP)
  Cost: $1,649 USD (Learn One package)
  Preparation Time: 120-200 hours
  Pass Rate: 40% (extremely difficult)
  Validity: Lifetime
  Notes: Only pursue if ahead of schedule
```

### 📊 Certification ROI Analysis

| Certification | Cost | Time Investment | Salary Impact | Job Postings Requiring |
|--------------|------|-----------------|---------------|------------------------|
| AWS SAA | $150 | 70h | +$5,000/year | 45% |
| AWS Security Specialty | $300 | 90h | +$10,000/year | 28% |
| CKS | $395 | 70h | +$8,000/year | 18% |
| OSCP | $1,649 | 160h | +$15,000/year | 12% |
| **Total** | **$2,494** | **390h** | **+$38,000/year** | - |

**Note:** Salary impacts are conservative estimates based on industry surveys (Dice, Robert Half 2024-2025).

### 🎯 Exam Taking Strategy

**Before Exam Day:**
1. Complete all course material (100%)
2. Score 80%+ on 3 consecutive practice exams
3. Review weak areas (Anki flashcards)
4. Get 8 hours sleep night before
5. Test exam environment (ID, camera, internet)

**Exam Day:**
1. Read each question carefully (don't rush)
2. Flag difficult questions (return later)
3. Eliminate obviously wrong answers
4. Guess intelligently (no penalty for guessing)
5. Review flagged questions before submitting

**After Exam:**
1. If passed: Share on LinkedIn immediately
2. If failed: Schedule retake within 14 days
3. Review weak areas (exam feedback)
4. Don't beat yourself up (failure is learning)

---

## 4. Learning Resources

### 📚 Essential Books
```yaml
Linux & Security:
  - "The Linux Command Line" by William Shotts (Free PDF)
  - "Linux Security Cookbook" by Daniel J. Barrett
  - "Practical Linux Forensics" by Bruce Nikkel
  
Cloud & Infrastructure:
  - "AWS Certified Solutions Architect Study Guide" (Sybex)
  - "Terraform: Up & Running" by Yevgeniy Brikman
  - "Kubernetes Security" by Liz Rice & Michael Hausenblas
  
DevSecOps:
  - "The DevOps Handbook" by Gene Kim
  - "Accelerate" by Nicole Forsgren
  - "Web Application Security" by Andrew Hoffman
  
Penetration Testing:
  - "The Web Application Hacker's Handbook" by Stuttard & Pinto
  - "Metasploit: The Penetration Tester's Guide" by Kennedy et al.
```

### 🎥 Video Courses (Recommended Platforms)
```yaml
Udemy:
  Best For: Practical hands-on courses
  Average Cost: $10-15 (on sale)
  Recommended Instructors:
    - Stephane Maarek (AWS)
    - Mumshad Mannambeth (Kubernetes)
    - Zeal Vora (DevOps)
    
A Cloud Guru / Linux Academy:
  Best For: Comprehensive learning paths
  Cost: $39/month (Pro plan)
  Strengths: Hands-on labs, AWS sandboxes
  
Coursera:
  Best For: University-level courses
  Cost: $49/month (Plus plan)
  Recommended: Google Cloud, IBM courses
  
LinkedIn Learning:
  Best For: Short, focused topics
  Cost: $29.99/month (Premium)
  Strengths: Professional development, soft skills
```

### 🛠️ Practice Platforms
```yaml
TryHackMe:
  Type: Gamified cybersecurity training
  Cost: $10/month (Premium)
  Best For: Beginners to intermediate
  Focus: Guided learning paths, walkthroughs
  
HackTheBox:
  Type: Realistic pentesting labs
  Cost: $20/month (VIP)
  Best For: Intermediate to advanced
  Focus: Real-world scenarios, OSCP-style
  
KodeKloud:
  Type: DevOps hands-on labs
  Cost: $30/month (Pro)
  Best For: CKA/CKS preparation
  Focus: Kubernetes, Docker, Ansible
  
PortSwigger Academy:
  Type: Web security training
  Cost: Free (Burp Suite Community)
  Best For: Web application security
  Focus: OWASP Top 10, practical labs
  
Katacoda / Killercoda:
  Type: Interactive browser-based labs
  Cost: Free
  Best For: Kubernetes, Linux practice
  Focus: Quick, scenario-based learning
```

---

## 5. Study Platforms

### 🎓 Platform Comparison

| Platform | Monthly Cost | Best For | Hands-On Labs | Quality | Recommendation |
|----------|--------------|----------|---------------|---------|----------------|
| **TryHackMe** | $10 | Security beginners | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | Must-have |
| **HackTheBox** | $20 | Advanced pentesting | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | Month 11 only |
| **KodeKloud** | $30 | K8s/DevOps | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | Critical for CKS |
| **A Cloud Guru** | $39 | AWS certifications | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | Month 4-6 only |
| **Udemy** | $10-15/course | Specific topics | ⭐⭐⭐ | ⭐⭐⭐⭐ | Best value |
| **Coursera** | $49 | Academic depth | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | Optional |
| **Linux Academy** | Merged with ACG | - | - | - | Use ACG instead |

### 📱 Mobile Learning Apps
```yaml
Anki:
  Type: Spaced repetition flashcards
  Cost: Free (iOS $25 one-time)
  Use Case: Memorize AWS services, kubectl commands
  Time: 15-20 min/day during commute
  
Brilliant:
  Type: Interactive math/CS courses
  Cost: $25/month
  Use Case: Strengthen algorithms, cryptography
  Time: 10-15 min/day
  
Leetcode:
  Type: Coding interview practice
  Cost: $35/month (Premium)
  Use Case: Interview preparation (Month 12)
  Time: 30 min/day
```

---

## 6. Budget Planning

### 💰 12-Month Budget Breakdown
```yaml
Certifications:
  AWS SAA (Month 5): $150
  AWS Security Specialty (Month 6): $300
  CKS (Month 8): $395
  OSCP (Month 11, Optional): $1,649
  Subtotal: $2,494 ($845 without OSCP)

Learning Platforms (Monthly Subscriptions):
  TryHackMe Premium: $10 × 12 = $120
  KodeKloud Pro: $30 × 4 (Month 7-8, 11-12) = $120
  A Cloud Guru: $39 × 3 (Month 4-6) = $117
  HackTheBox VIP: $20 × 2 (Month 11-12) = $40
  Subtotal: $397

Books & Resources:
  Essential books: $100 (5 books @ $20 avg)
  O'Reilly Learning (optional): $499/year
  Subtotal: $100-$600

AWS Infrastructure Costs:
  AWS Free Tier: $0 (Month 1-12)
  Additional AWS usage: $50-100/month × 8 = $400-800
  (Note: Use Free Tier maximally, spot instances)
  Subtotal: $400-$800

Tools & Software:
  Burp Suite Pro (1-month trial): $0
  JetBrains IDEs (student license): $0
  Docker Desktop: $0
  Subtotal: $0

Conference & Events:
  OWASP Sydney Chapter: $0 (free)
  BSides Canberra (virtual): $0-50
  SecTalks Sydney: $0 (free)
  Subtotal: $0-$50

TOTAL (Conservative): $3,391
TOTAL (With OSCP): $5,040
TOTAL (Maximum with O'Reilly): $5,641

Monthly Average: $283-$470
```

### 💡 Cost Optimization Strategies
```yaml
Save Money By:
  1. Udemy Sales: Only buy courses at $10-15 (wait for sales)
  2. AWS Credits: Apply for AWS Activate (startups get $1,000 free)
  3. Student Discounts: Use .edu email for GitHub, JetBrains
  4. Free Alternatives: Use KillerCoda instead of KodeKloud when possible
  5. Library Access: Check if Sydney library has O'Reilly subscription
  6. Company Sponsorship: Some employers cover cert costs (negotiate)
  7. AWS Free Tier: Stay within limits (750 hours EC2, 5GB S3)
  8. Community Resources: Use free Discord/Slack communities for support

Stretch Budget Further:
  - Buy certifications one at a time (spread costs)
  - Use trial periods strategically (A Cloud Guru 7-day free trial)
  - Share subscription with study partner (some allow multiple devices)
  - Sell OSCP voucher on Reddit if not ready (r/oscp)
```

---

## 7. Weekly Study Schedule

### 📅 Typical Week (Months 1-11)
```yaml
Monday - Friday (Weekdays):
  06:00 - 06:30: Morning review (Anki flashcards)
  09:00 - 17:00: UTS coursework (until graduation Month 12)
  18:00 - 20:00: DevSecOps study (video courses, reading)
  20:00 - 21:00: Hands-on practice (labs, coding)
  21:00 - 21:30: Documentation (blog, notes)
  
  Daily Total: 3.5 hours (2h theory + 1.5h practice)

Saturday:
  09:00 - 12:00: Deep work session (build projects)
  12:00 - 13:00: Lunch + review notes
  13:00 - 16:00: Hands-on labs (intensive practice)
  16:00 - 17:00: Community engagement (forums, OSS)
  
  Saturday Total: 7 hours (mostly hands-on)

Sunday:
  09:00 - 11:00: Weekly review (what did I learn?)
  11:00 - 13:00: Plan next week (tasks, goals)
  13:00 - 14:00: Recreational coding (fun projects)
  14:00 - 15:00: Blog writing or video creation
  15:00 - 16:00: Rest and recharge
  
  Sunday Total: 5 hours (reflection + planning)

Weekly Total: 27.5 hours (17.5h weekdays + 12h weekends)
Monthly Total: ~110 hours
```

### 🎯 Study Intensity by Month
```yaml
Months 1-3 (Foundation):
  Intensity: 70% (2-3 hours/day)
  Focus: Building habits, fundamentals
  
Months 4-6 (Certification Sprint):
  Intensity: 90% (3-4 hours/day)
  Focus: AWS certifications (SAA, Security)
  
Months 7-8 (Technical Deep-Dive):
  Intensity: 85% (3-3.5 hours/day)
  Focus: Containers, Kubernetes, CKS prep
  
Months 9-10 (Implementation):
  Intensity: 80% (2.5-3 hours/day)
  Focus: Building pipeline, observability
  
Months 11-12 (Practical Experience):
  Intensity: 90% (3-4 hours/day)
  Focus: Bug bounty, OSS, portfolio, interviews
```

### ⚠️ Burnout Prevention
```yaml
Every 3 Months:
  - Take 1 week with 50% reduced study time
  - Do only fun projects (no certifications)
  - Catch up on sleep and exercise
  
Weekly:
  - 1 full day off (no study) - recommend Sunday evening
  - Exercise 3-4 times per week (gym, running)
  - Social time with friends/family
  
Daily:
  - 8 hours sleep (non-negotiable)
  - Breaks every 50 minutes (Pomodoro technique)
  - No screen time 1 hour before bed
```

---

## 8. Success Tracking

### 📊 Monthly Check-Ins

At the end of each month, assess:
```yaml
Technical Skills:
  - [ ] Completed all planned courses/chapters?
  - [ ] Finished hands-on labs/projects?
  - [ ] Can explain concepts to someone else?
  - [ ] Built something new this month?
  
Certifications:
  - [ ] On track with study plan?
  - [ ] Practice exam scores improving?
  - [ ] Ready to schedule real exam?
  
Practical Experience:
  - [ ] GitHub contributions this month?
  - [ ] Blog posts written?
  - [ ] Community engagement?
  
Wellbeing:
  - [ ] Feeling overwhelmed? (If yes, reduce intensity)
  - [ ] Enjoying the learning? (If no, find fun projects)
  - [ ] Maintaining work-life balance?
```

### 🎯 Key Performance Indicators (KPIs)
```yaml
Month 1-3:
  ✅ Lynis score: 85+
  ✅ GitHub commits: 50+
  ✅ Blog posts: 1
  
Month 4-6:
  ✅ AWS SAA: PASSED
  ✅ AWS Security: PASSED
  ✅ Terraform modules: 10+
  
Month 7-9:
  ✅ CKS: PASSED
  ✅ Docker images hardened: 5+
  ✅ Security pipeline: Operational
  
Month 10-12:
  ✅ Bug bounty submissions: 3+ valid
  ✅ OSS contributions: 5+ merged PRs
  ✅ Conference talk: 1
  ✅ Portfolio: Complete
```

### 📈 Progress Dashboard (Monthly Update)

Create a simple spreadsheet to track:
```yaml
Study Hours:
  - Target: 110 hours/month
  - Actual: ___ hours
  - Variance: +/- ___
  
Certifications:
  - AWS SAA: Not Started / In Progress / PASSED / FAILED
  - AWS Security: Not Started / In Progress / PASSED / FAILED
  - CKS: Not Started / In Progress / PASSED / FAILED
  
Projects:
  - NFT Pipeline: ___ % complete
  - Security Pipeline: ___ % complete
  - Observability: ___ % complete
  
Community:
  - GitHub commits: ___
  - Blog posts: ___
  - OSS PRs: ___
  - Conference talks: ___
```

---

## 🎉 Final Thoughts

### Remember:

1. **Consistency Beats Intensity**: 2 hours every day beats 14 hours on Sunday.

2. **Hands-On First**: Always prioritize building over reading.

3. **Community Matters**: Don't learn in isolation. Join communities.

4. **Document Everything**: Your future self (and interviewers) will thank you.

5. **Failure is Learning**: Failed certification? That's data. Try again.

6. **Enjoy the Journey**: If you're not having fun, you're doing it wrong.

---

## 📞 Support & Resources

- **Study Group**: Join DevSecOps Discord (https://discord.gg/devsecops)
- **Reddit**: r/AWSCertifications, r/kubernetes, r/devops
- **Accountability Partner**: Find one on Twitter #100DaysOfCode
- **Questions?**: DM me on LinkedIn or GitHub Issues

---

**Good luck on your DevSecOps journey! 🚀**

**Remember:** This is a marathon, not a sprint. Pace yourself, stay consistent, and you WILL succeed.

**Author:** Jinkyung Kim  
**Last Updated:** January 2026  
**Contact:** [LinkedIn](https://www.linkedin.com/in/jinkyung-kim-64a28b1b2/) | [GitHub](https://github.com/jhin93)