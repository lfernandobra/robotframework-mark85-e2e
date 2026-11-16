# Mark85 — Robot Framework + Browser Library (Playwright) E2E Suite

[![Mark85 Robot Framework CI](https://github.com/lfernandobra/robotframework-mark85-e2e/actions/workflows/ci.yml/badge.svg)](https://github.com/lfernandobra/robotframework-mark85-e2e/actions/workflows/ci.yml)
[![Robot Framework](https://img.shields.io/badge/Robot%20Framework-7.4.2-000000?style=flat-square&logo=robotframework&logoColor=white)](https://robotframework.org/)
[![Browser Library](https://img.shields.io/badge/Playwright-Browser%2020.4-2EAD33?style=flat-square&logo=playwright&logoColor=white)](https://robotframework-browser.org/)
[![MongoDB](https://img.shields.io/badge/MongoDB-7-47A248?style=flat-square&logo=mongodb&logoColor=white)](https://www.mongodb.com/)
[![OpenAPI](https://img.shields.io/badge/OpenAPI-3.0.3-6BA539?style=flat-square&logo=openapiinitiative&logoColor=white)](docs/swagger/openapi.yaml)
[![Postman](https://img.shields.io/badge/Postman-FF6C37?style=flat-square&logo=postman&logoColor=white)](docs/postman/Mark85.postman_collection.json)

Keyword-driven **End-to-End (E2E)** test automation suite for the **Mark85** task manager (`app/mark85/web` + `app/mark85/api` + **MongoDB**), built with **Robot Framework**, **Browser Library (Playwright)**, **RequestsLibrary**, **pymongo**, and **Robocop**, running end-to-end in **GitHub Actions**.

---

## 1. QA Strategy & Artifacts

| Artifact | Purpose | Location |
| :--- | :--- | :--- |
| **Test Plan** | Scope, hybrid MongoDB/API seeding, traceability, and exit criteria | [`docs/qa/TEST_PLAN.md`](docs/qa/TEST_PLAN.md) |
| **Test Case Inventory** | 18 automated Robot Framework cases across 6 suites | [`docs/qa/TEST_CASES.md`](docs/qa/TEST_CASES.md) |
| **BDD Specifications** | Gherkin scenarios for signup, authentication, and task CRUD | [`specs/features/`](specs/features/) |
| **Bug / Tech Debt Report** | Analysis of `Sleep 1` in tag entry & parallel user isolation | [`BUG-001`](docs/qa/bug-reports/BUG-001-sleep-and-parallel-user-collision.md) |
| **OpenAPI / Swagger** | OpenAPI 3.0.3 contract for `/users`, `/sessions`, and `/tasks` | [`docs/swagger/openapi.yaml`](docs/swagger/openapi.yaml) |
| **Postman Collection** | Collection v2.1 with `pm.test` assertions & JWT token chaining | [`docs/postman/Mark85.postman_collection.json`](docs/postman/Mark85.postman_collection.json) |

---

## 2. Architecture & Design Highlights

* **Page & Component Objects (`resources/pages/`):** UI locators and assertions are modularized into pages (`LoginPage`, `SignupPage`, `TaskCreatePage`, `TasksPage`) and shared components (`Alert`, `Header`, `Notice`).
* **Direct MongoDB Seeding (`resources/libs/database.py`):** Custom Python keyword library (`Clean User From Database`, `Remove User From Database`, `Insert User From Database`) connects lazily via `MONGO_URI` and hashes test passwords with `bcrypt` for deterministic test state.
* **Hybrid API + UI Setup (`resources/services.resource`):** Authenticates via `POST /sessions` and pre-populates tasks via `POST /tasks` (`RequestsLibrary`) before validating UI interactions (`line-through` completion, duplicate alerts, DOM detachment).
* **Data-Driven Fixtures & Templates:** Scenarios consume JSON fixtures (`resources/fixtures/tasks.json`) and test password boundaries (`1..5` chars) via reusable keyword templates.
* **Automated Visual Evidence & Linting:** Captures screenshots on every test teardown (`log.html`) and enforces Robot Framework lint standards with **Robocop** (`pyproject.toml`).

---

## 3. Repository Structure

```text
.
├── .github/workflows/
│   └── ci.yml                          # CI: MongoDB 7 + Mark85 API/Web + Robocop + Robot E2E
├── app/mark85/
│   ├── api/                            # Node.js Express + Mongoose REST API (port 3333)
│   └── web/                            # React frontend server (port 3000)
├── docs/
│   ├── postman/                        # Collection v2.1 and local environment
│   ├── qa/
│   │   ├── bug-reports/
│   │   │   └── BUG-001-sleep-and-parallel-user-collision.md
│   │   ├── TEST_CASES.md
│   │   └── TEST_PLAN.md
│   └── swagger/
│       └── openapi.yaml                # OpenAPI 3.0.3 specification
├── resources/
│   ├── fixtures/tasks.json             # JSON test payloads
│   ├── libs/database.py                # Custom pymongo + bcrypt Robot keyword library
│   ├── pages/                          # Page and UI component .resource files
│   ├── base.resource                   # Shared setup, fixtures, and helper keywords
│   ├── env.resource                    # Base URLs and browser selection
│   └── services.resource               # RequestsLibrary REST API keywords
├── specs/features/                     # BDD specifications in Gherkin (.feature)
├── tests/
│   ├── tasks/                          # Task create, update, and delete suites
│   ├── login.robot
│   ├── online.robot
│   └── signup.robot
├── pyproject.toml                      # Robocop linter configuration
└── requirements.txt                    # Python & Robot Framework dependencies
```

---

## 4. Setup & Local Execution

### Prerequisites
* **Python 3.10+**
* **Node.js `>= 20.x`**
* **MongoDB** (local container via `docker run -d -p 27017:27017 mongo:7`, or MongoDB Atlas URI)

### 1. Start MongoDB, API & Web Application

```bash
# 1. Start local MongoDB container
docker run -d --name mark85-mongo -p 27017:27017 mongo:7

# 2. Configure and start Mark85 API (port 3333)
cp app/mark85/api/.env.example app/mark85/api/.env
npm --prefix app/mark85/api ci
(cd app/mark85/api && npm start)

# 3. Start Mark85 Web frontend (port 3000) in a second terminal
npm --prefix app/mark85/web ci
npm --prefix app/mark85/web start
```

### 2. Install Robot Framework & Run Tests

In a third terminal:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
rfbrowser init --with-deps chromium

# Run Robocop static linter
robocop check tests/ resources/

# Run all 18 E2E tests and store reports in results/
export MONGO_URI="mongodb://127.0.0.1:27017/"
robot -d results tests/
```

Generated reports (`results/report.html`, `results/log.html`, `results/output.xml`) provide step-by-step execution traces and teardown screenshots.

---

## 5. CI/CD Pipeline (GitHub Actions)

Workflow [`ci.yml`](.github/workflows/ci.yml) runs on every `push` and `pull_request` to `main`:
1. Starts a `mongo:7` container, Mark85 API (`:3333`), and Mark85 Web (`:3000`).
2. Installs Python dependencies and initializes Chromium via `rfbrowser init --with-deps chromium`.
3. Validates Postman JSON files and runs `robocop check tests/ resources/`.
4. Executes `robot -d results tests/` (`18` E2E scenarios) and archives `results/` for 14 days.

---

## 6. Author

**Luis Fernando Brandão**  
QA Automation Engineer  
* [LinkedIn](https://linkedin.com/in/lfernandobra)  
* [GitHub](https://github.com/lfernandobra)  
* lfernandobra@gmail.com
