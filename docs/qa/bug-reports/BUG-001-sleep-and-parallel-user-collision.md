# BUG-001: Fixed `Sleep 1` in Tag Entry & Static User Collision Risk Under Parallel Execution

| Field | Value |
| :--- | :--- |
| **ID** | `BUG-001` |
| **Severity** | Medium |
| **Priority** | P2 |
| **Status** | Open — Tracked for Parallelization Refactor (`pabot`) |
| **Component** | `resources/pages/TaskCreatePage.resource` (line 17) & `tests/signup.robot` |
| **Environment** | Robot Framework 7.4.2 + `robotframework-browser` 20.4.0 |

---

## Summary

Two testability anti-patterns limit suite execution speed and block safe parallelization with `pabot`:
1. `Submit Task Form` in `TaskCreatePage.resource` injects a hardcoded `Sleep 1` after every tag entered, adding deterministic latency (`3–4s` per test) and risking race conditions if the React tag chip renders slower than 1s under CI CPU contention.
2. Multiple test cases in `tests/signup.robot` reuse the exact same static email (`lfernandobra@gmail.com`) and call `Remove User From Database` against it, which causes race-condition failures if tests run concurrently across parallel workers.

---

## Evidence in Test Code

1. In [`resources/pages/TaskCreatePage.resource`](../../../resources/pages/TaskCreatePage.resource) (lines 15–19):
   ```robotframework
   FOR    ${tag}    IN    @{TASK}[tags]
       Fill Text    ${tags_element}    ${tag}
       Sleep    1
       Press Keys    ${tags_element}    Enter
   END
   ```
2. In [`tests/signup.robot`](../../../tests/signup.robot) (lines 15–35, 73–80, and `base.resource` lines 27–30):
   `Deve poder cadastrar um novo usuário`, `Não deve permitir o cadastro com email duplicado`, and `Short Password` all share `email=lfernandobra@gmail.com`.

---

## Impact

* **Sequential execution (`robot tests/`):** Passes reliably, as observed in CI, because cases run one at a time.
* **Parallel execution (`pabot --processes 4 tests/`):** High probability of intermittent failures when one worker deletes `lfernandobra@gmail.com` while another asserts duplicate-email notice for the same address.

---

## Recommended Fix

1. Replace `Sleep    1` in `TaskCreatePage.resource` with an explicit element assertion waiting for the tag chip to appear after pressing `Enter` (e.g., `Wait For Elements State    css=.tag-item >> text=${tag}    visible    5`).
2. Generate unique per-test emails via `FakerLibrary` (already listed in `requirements.txt`) or timestamp/UUID suffix inside `signup.robot` so each test owns an isolated MongoDB user document.
