# Udemy Robot Framework + Playwright (RobotExpress)

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
