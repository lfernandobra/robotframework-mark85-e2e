# Test Case Inventory — Mark85 (Robot Framework)

Total automated Robot Framework test cases: **`18`** across `6` `.robot` files.

---

## 1. Availability & Authentication (`tests/`)

| ID | Suite File | Test Case | Precondition / Data | Expected Assertion |
| :--- | :--- | :--- | :--- | :--- |
| `TC-ONL-01` | `online.robot` | WebApp Deve Estar Online | Mark85 Web running on `:3000` | `Get Title equal Mark85 by QAx` |
| `TC-SIGN-01` | `signup.robot` | Deve poder cadastrar um novo usuário | User removed from MongoDB | Notice: `"Boas vindas ao Mark85, o seu gerenciador de tarefas."` |
| `TC-SIGN-02` | `signup.robot` | Não deve permitir o cadastro com email duplicado | User pre-inserted in MongoDB | Notice: `"Oops! Já existe uma conta com o e-mail informado."` |
| `TC-SIGN-03` | `signup.robot` | Campos obrigatórios | Empty `name`, `email`, `password` | Alerts for full name, email, and 6-char password |
| `TC-SIGN-04` | `signup.robot` | Não deve cadastrar com email incorreto | `email=xavier.com.br` | Alert: `"Digite um e-mail válido"` |
| `TC-SIGN-05` | `signup.robot` | Não deve cadastrar com senha muito curta | Loop `1, 12, 123, 1234, 12345` | Alert: `"Informe uma senha com pelo menos 6 digitos"` |
| `TC-SIGN-06..10` | `signup.robot` | Não deve cadastrar com senha de 1..5 dígitos (`5` cases) | `Short Password` keyword (`1..5`) | Alert: `"Informe uma senha com pelo menos 6 digitos"` |
| `TC-LOG-01` | `login.robot` | Deve poder logar com um usuário pré-cadastrado | Pre-seeded user (`lfernandobra@yahoo.com`) | Header greets `"Olá, Luis"` |
| `TC-LOG-02` | `login.robot` | Não Deve poder logar com senha inválida | Pre-seeded user (`woz@apple.com`) + wrong pass `abc123` | Notice: `"Ocorreu um erro ao fazer login, verifique suas credenciais."` |

---

## 2. Task Management (`tests/tasks/`)

| ID | Suite File | Test Case | Precondition / Fixture | Expected Assertion |
| :--- | :--- | :--- | :--- | :--- |
| `TC-TASK-01` | `create.robot` | Deve poder cadastrar uma nova tarefa | `tasks.json` (`create`), clean user in MongoDB | Task `"Criar uma nova versão do Ipod"` visible in `.task-todo` |
| `TC-TASK-02` | `create.robot` | Não deve cadastrar tarefa com nome duplicado | `tasks.json` (`duplicate`), pre-created via `POST /tasks` | Notice: `"Oops! Tarefa duplicada."` |
| `TC-TASK-03` | `create.robot` | Não deve cadastrar uma nova tarefa quando atinge o limite de tags | `tasks.json` (`tags_limit`, `4` tags) | Notice: `"Oops! Limite de tags atingido."` |
| `TC-TASK-04` | `update.robot` | Deve poder marcar uma tarefa como concluída | `tasks.json` (`done`), pre-created via API | Click `.item-toggle`; task in `.task-done` has `line-through` style |
| `TC-TASK-05` | `delete.robot` | Deve poder apagar uma tarefa indesejada | `tasks.json` (`delete`), pre-created via API | Click `.task-remove`; task detached from `.task-todo` |
