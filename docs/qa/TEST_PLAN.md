# Test Plan — Mark85 (Robot Framework + Browser Library)

**Author:** Luis Fernando Brandão  
**Target System:** Mark85 Web (`app/mark85/web` on port `3000`) + Mark85 REST API (`app/mark85/api` on port `3333`) + MongoDB (`markdb`)  
**Framework:** Robot Framework 7.4 + Browser Library (`Playwright`) + `RequestsLibrary` + `pymongo`  

---

## 1. Objective & Scope

Validate user registration, authentication, and task management flows on **Mark85** using keyword-driven Robot Framework suites backed by Playwright (`robotframework-browser`) and direct MongoDB state management.

### In Scope
* **Application Availability (`tests/online.robot`):** Home page title check (`Mark85 by QAx`).
* **User Registration (`tests/signup.robot`):** Successful signup, duplicate email rejection, empty required fields, email syntax validation, and password length boundary (`1..5` characters).
* **Authentication (`tests/login.robot`):** Pre-seeded login verification (header greeting `"Olá, <first_name>"`) and wrong password rejection.
* **Task Lifecycle (`tests/tasks/`):** Task creation with tags, duplicate task blocking, tag limit enforcement (`> 3` tags), completion toggle (`text-decoration-line: line-through`), and removal.
* **Hybrid Precondition Seeding:** Direct MongoDB user injection (`bcrypt` hash rounds = 8 via `pymongo`) and REST task pre-creation via `RequestsLibrary`.

### Out of Scope
* High-concurrency load/spike benchmarking of the Node.js API.
* Cross-user authorization bypass penetration testing.

---

## 2. Architecture & Engineering Decisions

1. **Layered Keyword & Page Object Architecture (`resources/`):**  
   UI selectors and assertions live in page resource files (`LoginPage.resource`, `SignupPage.resource`, `TaskCreatePage.resource`, `TasksPage.resource`) and reusable UI components (`Alert.resource`, `Header.resource`, `Notice.resource`), keeping `.robot` test cases readable at business level.
2. **Direct MongoDB Seeding (`resources/libs/database.py`):**  
   Instead of running signup through the browser before every login or task scenario, `Insert User From Database` hashes passwords with `bcrypt` and writes directly to MongoDB `users`, while `Clean User From Database` cascades deletion across `tasks` and `users`. Connection strings are injected via `MONGO_URI` / `MONGO_DB` environment variables with lazy client initialization.
3. **API Precondition Chaining (`resources/services.resource`):**  
   `Create A New Task From API` authenticates via `POST /sessions`, stores the JWT token at suite scope (`VAR ... scope=SUITE`), and seeds tasks via `POST /tasks` prior to UI interactions.
4. **Data-Driven Fixtures & Templates:**  
   Task scenarios pull structured payloads from [`resources/fixtures/tasks.json`](../../resources/fixtures/tasks.json) via `Get Fixture`, while boundary validation for short passwords (`1..5` chars) uses both loop-based iteration and template-driven keywords (`Short Password`).
5. **Visual Evidence & Static Analysis:**  
   Every suite configures `Test Teardown    Take Screenshot` (embedded directly into Robot's `log.html`), and **Robocop** (`robocop check`) enforces Robot Framework coding standards in CI.

---

## 3. Traceability Matrix

| Domain | BDD Feature | Robot Test Suite | Support Layer |
| :--- | :--- | :--- | :--- |
| Availability | `specs/features/auth.feature` | `tests/online.robot` | `base.resource` |
| Signup | `specs/features/auth.feature` | `tests/signup.robot` | `SignupPage`, `Alert`, `Notice`, `database.py` |
| Login | `specs/features/auth.feature` | `tests/login.robot` | `LoginPage`, `Header`, `Notice`, `database.py` |
| Task Create | `specs/features/tasks.feature` | `tests/tasks/create.robot` | `TaskCreatePage`, `TasksPage`, `services.resource` |
| Task Update | `specs/features/tasks.feature` | `tests/tasks/update.robot` | `TasksPage`, `services.resource`, `tasks.json` |
| Task Delete | `specs/features/tasks.feature` | `tests/tasks/delete.robot` | `TasksPage`, `services.resource`, `tasks.json` |

---

## 4. Entry & Exit Criteria

### Entry Criteria
* MongoDB 7 (`markdb`) reachable on `MONGO_URI`.
* Mark85 API listening on port `3333` and Web frontend listening on port `3000`.
* Playwright Chromium binary initialized via `rfbrowser init --with-deps chromium`.

### Exit Criteria
* `robocop check tests/ resources/` completes with `0` issues.
* All `18` Robot Framework tests across `6` suites pass (`robot -d results tests/`) with `report.html` and `log.html` archived in GitHub Actions.
* Open testability improvement (`Sleep 1` and shared static email in `signup.robot`) documented in [`BUG-001`](./bug-reports/BUG-001-sleep-and-parallel-user-collision.md).
