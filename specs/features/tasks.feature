@tasks @web @hybrid @mark85
Feature: Mark85 Task Lifecycle Management
  As an authenticated Mark85 user
  I want to create, validate, complete, and remove tasks
  So that I can track my work items in real time

  Background:
    Given the user is reset in MongoDB and logged into Mark85

  @positive @create @critical
  Scenario: Create a new task with tags via UI
    When I open the task creation form and submit "Criar uma nova versão do Ipod" with tags "ios, music, ipod"
    Then the task "Criar uma nova versão do Ipod" should appear in the active task list

  @negative @create @duplicate
  Scenario: Reject duplicate task creation
    Given the task "Recrutar novos humanos" is pre-created via API ("POST /tasks")
    When I submit a new task with the same name via UI
    Then the notice should read "Oops! Tarefa duplicada."

  @negative @create @tags
  Scenario: Enforce maximum tag limit when creating a task
    When I submit "Estudar Python" with 4 tags ("qax, python, programação, pip")
    Then the notice should read "Oops! Limite de tags atingido."

  @positive @update
  Scenario: Mark an existing task as completed
    Given the task "Criar uma nova IA" is pre-created via API
    When I click the ".item-toggle" button for "Criar uma nova IA"
    Then the task moves to ".task-done" with CSS "text-decoration-line" equal to "line-through"

  @positive @delete
  Scenario: Remove an unwanted task
    Given the task "Criar a IA do Ultron" is pre-created via API
    When I click the ".task-remove" button for "Criar a IA do Ultron"
    Then the task "Criar a IA do Ultron" should be detached from ".task-todo"
