
## 1 AWS Certified Solutions Architect - Associate
## 2 CompTIA Security+ (SY0-701)
## 3 AWS Certified Security - Specialty



---

## 문서별 경쟁률 순위 비교

| 출처             | Security Engineering | DevOps/SRE     | 더 낮은 경쟁률     |
|----------------|----------------------|----------------|--------------|
| claude.pdf     | 4위                   | 7위             | **Security** |
| Grok.pdf       | 3위 (CR 4.8)          | 6위 (CR 6.0)    | **Security** |
| chatgpt.pdf    | CR 0.025             | CR 0.0031      | **DevOps**   |
| Komo.pdf       | CR 1.05              | CR 1.10        | **Security** |
| Felo.pdf       | 3위 (CR 2.4)          | 7위 (CR 4.3)    | **Security** |
| Gemini.pdf     | 1위 (CR 14.8)         | 3위 (CR 28.6)   | **Security** |
| perplexity.pdf | 5위 (Score 3.2)       | 6위 (Score 3.5) | **Security** |

**7개 문서 중 6개에서 Security가 DevOps보다 경쟁률이 낮습니다.**

---

## 핵심 데이터 근거

### Security Engineering

**claude.pdf:**
> "Global workforce gap 4.8 million unfilled positions" (ISC2 2024)
> "Organizations understaffed 65% in cybersecurity/compliance"
> 단, "Entry-level supply/demand 10% worker SURPLUS at 0-2 years"

**Gemini.pdf:**
> "Competition Ratio 14.8 - the lowest among all ten domains"
> "For every open entry-level role, only 14.8 qualified candidates are identified"
> "89% of hiring managers accept entry-level certifications as a proxy for experience"

### DevOps/SRE

**claude.pdf:**
> "Junior-level role percentage Only 5% of DevOps positions"
> "Recruiter difficulty finding candidates 19%"

**Gemini.pdf:**
> "Competition Ratio 28.6"
> "83% of organizations have adopted DevOps, yet the field remains one of the hardest to fill"

---

## 구조적 차이 분석

```
Security Engineering 경쟁 구조:
┌─────────────────────────────────────────┐
│ 수요: 4.8M 미충원 포지션 (매우 높음)      │
│ 공급: Entry-level 10% 과잉 공급          │
│ 진입 장벽: 자격증 필수 (높음)             │
│ 결과: Mid-level 부족, Entry-level 포화   │
└─────────────────────────────────────────┘

DevOps/SRE 경쟁 구조:
┌─────────────────────────────────────────┐
│ 수요: 443% 채용 공고 증가 (매우 높음)     │
│ 공급: Entry-level 포지션 자체가 5%만 존재 │
│ 진입 장벽: 1-2년 경험 요구 (매우 높음)    │
│ 결과: Entry-level 포지션 자체가 희소      │
└─────────────────────────────────────────┘
```

---

## Entry-Level 관점에서의 핵심 차이

| 항목                   | Security              | DevOps     |
|:----------------------|-----------------------|------------|
| Entry-level 포지션 비율  | 상대적으로 많음          | **5%만 존재** |
| Entry-level 경쟁 상황   | 10% 공급 과잉           | 포지션 자체가 적음 |
| 자격증으로 진입 가능       | **가능 (89% 인정)**     | 경험 우선      |
| 무경험자 채용 가능성       | 중간                   | 낮음         |

**claude.pdf 인용:**
> "DevOps/SRE has exceptionally high barriers to entry because the role inherently requires operational experience. With only 5% of positions targeting junior candidates, competition for those limited entry-level roles is intense."

---

## 결론

| 측면                  | Security | DevOps        | 승자           |
|----------------------|----------|---------------|--------------|
| 전체 경쟁률             | 낮음       | 중간          | **Security** |
| Entry-level 포지션 존재 | 많음       | **5%만**     | **Security** |
| 자격증으로 진입          | 가능       | 어려움         | **Security** |
| Entry-level 공급 과잉  | 10% 과잉   | 해당 없음       | DevOps       |

---

## Jhin 상황에 대한 시사점

**Security Engineer가 DevOps보다 진입이 용이합니다.**

| 이유      | 설명                                           
|----------|----------------------------------------------
| 포지션 존재 | DevOps는 entry-level이 5%뿐, Security는 상대적으로 많음 
| 자격증 인정 | Security는 89%가 자격증을 경험 대체로 인정                
| 경쟁률     | 7개 문서 중 6개에서 Security가 더 낮음                  

**단, 주의점:**
Security entry-level에서 10% 공급 과잉이 있으므로, **Security+ 만으로는 부족**하고 AWS Security Specialty 같은 전문 자격증이 차별화 요소가 됩니다.

---

## 최종 자격증 조합 재확인

이 분석을 바탕으로:

```
SAA → Security+ → AWS Security Specialty
```

이 조합이 **취업 확률 측면에서 최적**입니다.

- Security Engineer: 경쟁률 낮음 + 자격증 인정률 높음
- DevSecOps: Security 비중 50-60%로 Security 자격증이 핵심
- DevOps 백업 필요 시: 자격증보다 **포트폴리오로 보완** (GitHub Actions, Terraform 프로젝트)