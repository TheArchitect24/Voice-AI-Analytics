# 🎙️ Voice AI Analytics

**Role:** Analytics Engineer
**Stack:** Docker · PostgreSQL · dbt · Python · Metabase · VS Code

---

## 📌 Project Overview

This project analyzes **Voice AI interactions** to evaluate accessibility, efficiency, adoption, friction, and error reduction using real conversational data.

The solution is implemented using a **modern analytics engineering stack**, emphasizing:

* Reproducibility
* Data quality & governance
* Clear analytical reasoning
* Stakeholder-ready insights

The final output supports:

* KPI tracking
* Root-cause analysis of friction and abandonment
* Error-reduction measurement
* Trustworthy dashboards via Metabase

---

## 🧱 Full Tech Stack

| Layer              | Technology                           | Purpose                             |
| ------------------ | ------------------------------------ | ----------------------------------- |
| Orchestration      | Docker / Docker Compose              | Reproducible local environment      |
| Database           | PostgreSQL                           | Raw + analytics warehouse           |
| Transformation     | dbt                                  | Staging, marts, testing, governance |
| Analysis           | Python (Pandas, SQLAlchemy, sklearn) | Statistical analysis & modeling     |
| BI / Visualization | Metabase                             | Stakeholder dashboards              |
| Dev Environment    | VS Code (Dev Containers)             | Seamless containerized development  |

---

## 🏗️ Architecture Overview

```
CSV Data
  ↓
PostgreSQL (raw tables)
  ↓
dbt Staging Models (stg_*)
  ↓
dbt Fact Models (fact_voice_ai_sessions)
  ↓
Metabase Dashboards
  ↓
Stakeholder Insights
```

**Design principles:**

* One fact table = one grain (session-level)
* No business logic in dashboards
* All metrics validated before exposure
* Python used only where SQL is insufficient

---

## 🚀 Environment Setup (Step-by-Step)

### 1️⃣ Prerequisites

* Docker & Docker Compose
* VS Code + Dev Containers extension

---

### 2️⃣ Clone Repository

```bash
git clone <repo-url>
cd <repo-name>
```

---

### 3️⃣ Build & Start Containers

```bash
docker compose up --build
```

This starts:

* `postgres` (persistent volume)
* `analytics` (Python + dbt)
* `metabase`

---

### 4️⃣ Attach VS Code to Container

In VS Code:

```
Command Palette → Dev Containers: Attach to Running Container
→ analytics
```

Your local workspace is now **mounted into the container**.

---

### 5️⃣ Load Data into PostgreSQL

Data is loaded once and persists via Docker volumes.

```bash
docker exec -it postgres psql -U analyst -d irembo
```

---

### 6️⃣ dbt Setup

```bash
cd /workspace/dbt
dbt deps
dbt debug
```

---

### 7️⃣ Run Transformations & Tests

```bash
dbt build
```

This will:

* Build staging models
* Build fact models
* Run data quality tests

---

### 8️⃣ Access Metabase

```
http://localhost:3000
```

Connect Metabase to:

* Host: `postgres`
* Database: `irembo`
* Schema: `analytics`

---

## 📂 Repository Structure

```
.
├── docker-compose.yml
├── Dockerfile
├── requirements.txt
├── dbt/
│   ├── dbt_project.yml
│   ├── packages.yml
│   ├── models/
│   │   └── irembo/
│   │       ├── staging/
│   │       └── marts/
│   └── tests/
├── notebooks/
│   └── analysis.ipynb
└── README.md
```

---

# 🧠 Walkthrough & Approach

---

## **Part 1: Analytics Design & Monitoring (KPIs)**

### 🎯 Goals & KPIs

#### Accessibility / Inclusivity

* Completion rate for first-time users
* Rural vs urban completion gap
* Average ASR confidence by user type

#### Efficiency

* Average turns per session
* Average session duration
* Error rate per session

#### Adoption

* Share of sessions using Voice AI
* Repeat usage rate
* Voice vs non-voice completion delta

**Approach:**
KPIs are session-level metrics aggregated from turn-level data and materialized in `fact_voice_ai_sessions`.

---

## **Part 2: Data Modeling**

### Core Fact Table

**`fact_voice_ai_sessions`**

* Grain: **1 row per session**
* Source: `voice_turns` only (applications excluded after validation)
* Metrics:

  * Error proportions
  * ASR & intent confidence
  * Turn counts
  * Final outcome

**Why:**
Sessions are the natural decision unit for Voice AI effectiveness.

---

## **Part 3: Insight Generation**

### Key Findings (Stakeholder Summary)

1. **Primary friction driver is ASR performance**, not conversation length.
2. **Users abandon early**, indicating initial recognition issues.
3. **Voice AI performs better for first-time digital users** than non-voice channels.
4. **Rural users benefit disproportionately** from Voice AI accessibility.

**Tools Used:**

* SQL → aggregations & KPIs
* Python → Logistic Regression, segmentation, statistical validation

---

## **Part 4: Impact & Error Reduction**

### Defining an Error

An error is any turn marked as:

* `misunderstanding`
* `silence`
* or repeated intent failures

### Baseline Error Rate

```
error_turns / total_turns
```

### Measuring Improvement

* Compare pre/post model deployments
* Control for user mix & session length
* Track statistically significant deltas

### Avoiding Misleading Conclusions

* Segment by channel & user type
* Avoid raw averages
* Require confidence intervals

### Twist: Logistic Regression Insight

Modeling **non-completion** revealed:

* ASR confidence as the strongest abandonment predictor
* Errors occur early, not due to long sessions

➡️ **Strategy shift:** Fix ASR first, not dialogue flow.

---

## **Part 5: Data Quality & Governance**

### dbt Tests Implemented

* Not null & uniqueness
* Relationship tests
* Accepted ranges (0–1)
* Business logic tests:

  * Error proportions ≤ 100%
  * Sessions must have turns

### PII Protection

* No raw audio
* User IDs anonymized
* Aggregated reporting only

Metabase only queries **certified dbt models**.

---

## **Part 6: Production Readiness**

### What Makes This Production-Grade

* Deterministic builds
* Persistent volumes
* Versioned transformations
* Automated data quality enforcement
* BI governance boundary

---

## 🏆 Final Notes

This project was designed as:

* A **real analytics platform**, not a one-off analysis
* A showcase of **6+ years Analytics Engineering maturity**
* A system that scales beyond the assignment

> **Key philosophy:**
> *If Metabase can see it, it has already been tested.*

---

## ✅ Next Steps (Optional Enhancements)

* CI pipeline for dbt tests
* Snapshotting for longitudinal analysis
* Feature store for ML reuse

---