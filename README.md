# Udemy Robot Framework + Playwright (RobotExpress)

*Read this in [Portuguese](#português)*

This repository contains a study project on automated testing using Robot Framework, Playwright (Browser Library), and API testing with Requests. The project under test is "Mark85", a task manager composed of an API (Node.js) and a Web Frontend.

## 🛠️ Technologies and Libraries

- **Python 3**
- **Robot Framework**: Keyword-driven testing framework.
- **Robot Framework Browser**: Playwright integration with Robot Framework for End-to-End testing.
- **Robot Framework Requests**: Library for REST API testing.
- **Node.js**: Platform used to run the backend and frontend of the target application.
- **MongoDB**: NoSQL database (this project used MongoDB Atlas Cloud).

## 🚀 How to Setup the Environment

To run this project and develop tests, you need to prepare both the testing environment and start the "Mark85" application locally.

### 1. Preparing the Application (Mark85)

The Mark85 application is divided into two parts: **API** and **Web**. You need to have Node.js installed on your machine.

#### Starting the API
1. Access the API directory:
   ```bash
   cd app/mark85/api
   ```
2. Install Node dependencies:
   ```bash
   npm install
   ```
3. The database (MongoDB Atlas) is already configured in the `.env` file inside `app/mark85/api`.
4. Start the API server (in development mode):
   ```bash
   npm run dev
   ```
The API will be running locally (usually on port 3333). Keep this terminal open.

#### Starting the Web Interface
Open a **new terminal tab** and execute:
1. Access the Web directory:
   ```bash
   cd app/mark85/web
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Start the Web interface server:
   ```bash
   npm run dev
   ```
The frontend will be accessible (usually at http://localhost:3000). Keep this terminal open.

---

### 2. Preparing the Testing Environment (Robot Framework)

1. Make sure you have Python installed. It's recommended to use a virtual environment (venv).
   ```bash
   # (Optional, but recommended) Create and activate the virtual environment:
   python -m venv .venv
   source .venv/bin/activate  # On Windows: .venv\Scripts\activate
   ```
2. Install the dependencies listed in `requirements.txt` at the root of the project:
   ```bash
   pip install -r requirements.txt
   ```
3. **Playwright / Browser Library Initialization**:
   Since the project uses the Robot Framework `Browser` library, you need to download the browser binaries by running:
   ```bash
   rfbrowser init
   ```

---

## 🧪 How to Run the Tests

With the application running (API and Web) and the Robot Framework dependencies installed, return to the repository root (`udemy-robotexpress`) and run the tests from the terminal.

To run all tests in the `tests` folder and generate reports in the `results` folder:
```bash
robot -d results tests/
```

### Directory Structure Explanation

- **`app/`**: Contains the source code for the Mark85 application, which is our system under test (SUT). It was developed in Node.js (separated into `api/` and `web/`).
- **`tests/`**: Contains the test cases written in Robot Framework (`.robot` files, like `login.robot`, `signup.robot`).
- **`resources/`**: Where support files for the tests are kept, such as Page Objects, custom Keywords, configurations, or test data.
- **`mongoDB/`**: Contains useful information about the database used by the application. The `mongoDBcredentials.txt` file has authentication data.
- **`requirements.txt`**: List of all Python dependencies (Robot Framework libraries and others, like pymongo and Faker) required to run the project.

### 📝 Tips and Useful Links
- **Page to test XPath**: https://devhints.io/xpath (according to the repository's original notes).
- **Logs and Reports**: The Robot Framework execution command generates the `log.html`, `report.html`, and `output.xml` files. They are essential for viewing the success or failure of test executions.

---

<div id="português"></div>

# Udemy Robot Framework + Playwright (RobotExpress) - Português

Este repositório contém um projeto de estudos sobre testes automatizados utilizando Robot Framework, Playwright (Browser Library) e testes de API com Requests. O projeto em teste é o "Mark85", um gerenciador de tarefas composto por uma API (Node.js) e um Frontend Web.

## 🛠️ Tecnologias e Bibliotecas

- **Python 3**
- **Robot Framework**: Framework de testes orientado a palavras-chave (Keywords).
- **Robot Framework Browser**: Integração do Playwright com o Robot Framework para testes End-to-End.
- **Robot Framework Requests**: Biblioteca para testes de API REST.
- **Node.js**: Plataforma utilizada para rodar o backend e o frontend da aplicação alvo.
- **MongoDB**: Banco de dados NoSQL (neste projeto foi usado o MongoDB Atlas Cloud).

## 🚀 Como Preparar o Ambiente

Para rodar este projeto e desenvolver os testes, você precisa preparar tanto o ambiente de desenvolvimento (testes) quanto colocar a aplicação "Mark85" no ar localmente.

### 1. Preparando a Aplicação (Mark85)

A aplicação Mark85 é dividida em duas partes: **API** e **Web**. É necessário ter o Node.js instalado na máquina.

#### Iniciando a API
1. Acesse o diretório da API:
   ```bash
   cd app/mark85/api
   ```
2. Instale as dependências do Node:
   ```bash
   npm install
   ```
3. O banco de dados (MongoDB Atlas) já está configurado no arquivo `.env` dentro de `app/mark85/api`.
4. Inicie o servidor da API (em modo desenvolvimento):
   ```bash
   npm run dev
   ```
A API estará rodando localmente (normalmente na porta 3333). Mantenha este terminal aberto.

#### Iniciando a Interface Web
Abra uma **nova aba de terminal** e execute:
1. Acesse o diretório Web:
   ```bash
   cd app/mark85/web
   ```
2. Instale as dependências:
   ```bash
   npm install
   ```
3. Inicie o servidor da interface Web:
   ```bash
   npm run dev
   ```
O frontend estará acessível (normalmente em http://localhost:3000). Mantenha este terminal aberto.

---

### 2. Preparando o Ambiente de Testes (Robot Framework)

1. Certifique-se de ter o Python instalado. É recomendado o uso de um ambiente virtual (venv).
   ```bash
   # (Opcional, mas recomendado) Criar e ativar o ambiente virtual:
   python -m venv .venv
   source .venv/bin/activate  # No Windows: .venv\Scripts\activate
   ```
2. Instale as dependências listadas no `requirements.txt` na raiz do projeto:
   ```bash
   pip install -r requirements.txt
   ```
3. **Inicialização do Playwright / Browser Library**:
   Como o projeto utiliza a biblioteca `Browser` do Robot Framework, você precisa baixar os binários dos navegadores executando o comando:
   ```bash
   rfbrowser init
   ```

---

## 🧪 Como Executar os Testes

Com a aplicação rodando (API e Web) e as dependências do Robot Framework instaladas, volte para a raiz do repositório (`udemy-robotexpress`) e execute os testes pelo terminal.

Para rodar todos os testes na pasta `tests` e gerar os relatórios na pasta `results`:
```bash
robot -d results tests/
```

### Explicação sobre a Estrutura de Diretórios

- **`app/`**: Contém o código fonte da aplicação Mark85, que é o nosso sistema sob teste (SUT). Ela foi desenvolvida em Node.js (separada em `api/` e `web/`).
- **`tests/`**: Contém os casos de testes escritos em Robot Framework (arquivos `.robot`, como `login.robot`, `signup.robot`).
- **`resources/`**: Onde ficam guardados arquivos de suporte para os testes, como Page Objects, Keywords customizadas, configurações ou massa de dados.
- **`mongoDB/`**: Contém informações úteis sobre o banco de dados utilizado pela aplicação. O arquivo `mongoDBcredentials.txt` possui dados de autenticação.
- **`requirements.txt`**: Lista com todas as dependências Python (bibliotecas do Robot Framework e outras, como pymongo e Faker) necessárias para rodar o projeto.

### 📝 Dicas e Links Úteis
- **Página para testar XPath**: https://devhints.io/xpath (de acordo com as anotações originais do repositório).
- **Logs e Relatórios**: O comando de execução do Robot Framework gera os arquivos `log.html`, `report.html` e `output.xml`. Eles são fundamentais para visualização de sucesso ou falha das execuções dos testes.
