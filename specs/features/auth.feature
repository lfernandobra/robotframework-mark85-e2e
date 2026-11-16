@auth @web @mark85
Feature: Mark85 User Registration and Authentication
  As a Mark85 user
  I want to sign up and log into the task manager
  So that I can manage my personal tasks securely

  @smoke
  Scenario: Web application is online
    When I open the Mark85 home page
    Then the page title should equal "Mark85 by QAx"

  @positive @signup
  Scenario: Register a new user successfully
    Given the user email does not exist in MongoDB
    When I navigate to "/signup" and submit valid name, email, and password
    Then the notice should read "Boas vindas ao Mark85, o seu gerenciador de tarefas."

  @negative @signup @duplicate
  Scenario: Reject registration with an existing email
    Given the user already exists in MongoDB (pre-seeded via bcrypt + pymongo)
    When I submit the signup form with the same email
    Then the notice should read "Oops! Já existe uma conta com o e-mail informado."

  @negative @signup @validation
  Scenario: Enforce mandatory signup fields
    When I submit the signup form with empty name, email, and password
    Then alerts should display "Informe seu nome completo", "Informe seu e-email", and "Informe uma senha com pelo menos 6 digitos"

  @negative @signup @validation
  Scenario: Reject invalid email format on signup
    When I submit the signup form with email "xavier.com.br"
    Then the alert should display "Digite um e-mail válido"

  @negative @signup @validation
  Scenario Outline: Reject passwords shorter than 6 characters
    When I submit the signup form with short password "<short_pass>"
    Then the alert should display "Informe uma senha com pelo menos 6 digitos"

    Examples:
      | short_pass |
      | 1          |
      | 12         |
      | 123        |
      | 1234       |
      | 12345      |

  @positive @login
  Scenario: Authenticate with pre-seeded user credentials
    Given a user is pre-seeded in MongoDB with a bcrypt password hash
    When I submit the login form with valid credentials
    Then the header should greet the user with "Olá, <first_name>"

  @negative @login
  Scenario: Reject authentication with incorrect password
    Given a user is pre-seeded in MongoDB
    When I submit the login form with an incorrect password
    Then the notice should read "Ocorreu um erro ao fazer login, verifique suas credenciais."
