@echo off

REM Crear la estructura de carpetas
mkdir todo-list
cd todo-list
mkdir src\main\java\com\todoapp
mkdir src\main\java\com\todoapp\model
mkdir src\main\java\com\todoapp\repository
mkdir src\main\java\com\todoapp\servlet
mkdir src\main\resources
mkdir src\main\webapp
mkdir src\main\webapp\css
mkdir src\test\java\com\todoapp

REM Crear archivos Java
(
echo package com.todoapp;
echo.
echo import org.eclipse.jetty.server.Server;
echo import org.eclipse.jetty.servlet.ServletContextHandler;
echo import org.eclipse.jetty.servlet.ServletHolder;
echo.
echo public class Main {
echo     public static void main(String[] args) {
echo         Server server = new Server(8080);
echo         ServletContextHandler context = new ServletContextHandler(ServletContextHandler.SESSIONS);
echo         context.setContextPath("/");
echo         server.setHandler(context);
echo.
echo         context.addServlet(new ServletHolder(new TodoServlet()), "/api/todos");
echo.
echo         try {
echo             server.start();
echo             server.join();
echo         } catch (Exception e) {
echo             e.printStackTrace();
echo         } finally {
echo             server.destroy();
echo         }
echo     }
echo }
) > src\main\java\com\todoapp\Main.java

(
echo package com.todoapp.model;
echo.
echo public class Todo {
echo     private String task;
echo.
echo     public Todo(String task) {
echo         this.task = task;
echo     }
echo.
echo     public String getTask() {
echo         return task;
echo     }
echo.
echo     public void setTask(String task) {
echo         this.task = task;
echo     }
echo }
) > src\main\java\com\todoapp\model\Todo.java

(
echo package com.todoapp.repository;
echo.
echo import java.util.ArrayList;
echo import java.util.List;
echo import com.todoapp.model.Todo;
echo.
echo public class TodoRepository {
echo     private List<Todo> todos = new ArrayList<>();
echo.
echo     public List<Todo> getAllTodos() {
echo         return todos;
echo     }
echo.
echo     public void addTodo(Todo todo) {
echo         todos.add(todo);
echo     }
echo }
) > src\main\java\com\todoapp\repository\TodoRepository.java

(
echo package com.todoapp.servlet;
echo.
echo import javax.servlet.ServletException;
echo import javax.servlet.http.HttpServlet;
echo import javax.servlet.http.HttpServletRequest;
echo import javax.servlet.http.HttpServletResponse;
echo import java.io.IOException;
echo import com.google.gson.Gson;
echo import com.todoapp.model.Todo;
echo import com.todoapp.repository.TodoRepository;
echo.
echo public class TodoServlet extends HttpServlet {
echo     private TodoRepository todoRepository = new TodoRepository();
echo.
echo     @Override
echo     protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
echo         resp.setContentType("application/json");
echo         resp.getWriter().write(new Gson().toJson(todoRepository.getAllTodos()));
echo     }
echo.
echo     @Override
echo     protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
echo         String task = req.getParameter("task");
echo         Todo todo = new Todo(task);
echo         todoRepository.addTodo(todo);
echo         resp.setStatus(HttpServletResponse.SC_OK);
echo     }
echo }
) > src\main\java\com\todoapp\servlet\TodoServlet.java

REM Crear archivo de prueba unitaria
(
echo package com.todoapp;
echo.
echo import org.junit.Test;
echo import static org.junit.Assert.*;
echo import com.todoapp.model.Todo;
echo import com.todoapp.repository.TodoRepository;
echo.
echo public class TodoTest {
echo     @Test
echo     public void testAddTodo() {
echo         TodoRepository repository = new TodoRepository();
echo         Todo todo = new Todo("Test Task");
echo         repository.addTodo(todo);
echo         assertEquals(1, repository.getAllTodos().size());
echo     }
echo }
) > src\test\java\com\todoapp\TodoTest.java

REM Crear archivo index.html
(
echo ^<!DOCTYPE html^>
echo ^<html lang="en"^>
echo ^<head^>
echo     ^<meta charset="UTF-8"^>
echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
echo     ^<title^>To-Do List^</title^>
echo     ^<link href="css/output.css" rel="stylesheet"^>
echo ^</head^>
echo ^<body class="bg-gray-100 p-10"^>
echo     ^<div class="max-w-md mx-auto bg-white p-6 rounded-lg shadow-md"^>
echo         ^<h1 class="text-2xl font-bold mb-4"^>To-Do List^</h1^>
echo         ^<form id="todo-form" class="mb-4"^>
echo             ^<input type="text" id="todo-input" class="border p-2 w-full mb-2" placeholder="Add a new task"^>
echo             ^<button type="submit" class="bg-blue-500 text-white p-2 w-full"^>Add^</button^>
echo         ^</form^>
echo         ^<ul id="todo-list" class="list-disc list-inside"^>
echo             ^<!-- Todos will be injected here --^>
echo         ^</ul^>
echo     ^</div^>
echo     ^<script^>
echo         document.getElementById('todo-form').addEventListener('submit', function(event) {
echo             event.preventDefault();
echo             const task = document.getElementById('todo-input').value;
echo             fetch('/api/todos', {
echo                 method: 'POST',
echo                 headers: {
echo                     'Content-Type': 'application/x-www-form-urlencoded',
echo                 },
echo                 body: `task=${encodeURIComponent(task)}`
echo             }).then(response => response.json())
echo               .then(data => {
echo                   loadTodos();
echo               });
echo         });
echo.
echo         function loadTodos() {
echo             fetch('/api/todos')
echo                 .then(response => response.json())
echo                 .then(data => {
echo                     const todoList = document.getElementById('todo-list');
echo                     todoList.innerHTML = '';
echo                     data.forEach(todo => {
echo                         const li = document.createElement('li');
echo                         li.textContent = todo.task;
echo                         todoList.appendChild(li);
echo                     });
echo                 });
echo         }
echo.
echo         loadTodos();
echo     ^</script^>
echo ^</body^>
echo ^</html^>
) > src\main\webapp\index.html

REM Crear archivo tailwind.css
(
echo @tailwind base;
echo @tailwind components;
echo @tailwind utilities;
) > src\main\webapp\css\tailwind.css

REM Crear archivo tailwind.config.js
(
echo module.exports = {
echo   content: [
echo     "./src/main/webapp/**/*.{html,js}",
echo   ],
echo   theme: {
echo     extend: {},
echo   },
echo   plugins: [],
echo }
) > tailwind.config.js

REM Crear archivo pom.xml
(
echo ^<project xmlns="http://maven.apache.org/POM/4.0.0"
echo          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
echo          xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd"^>
echo     ^<modelVersion^>4.0.0^</modelVersion^>
echo     ^<groupId^>com.todoapp^</groupId^>
echo     ^<artifactId^>todo-list^</artifactId^>
echo     ^<version^>1.0-SNAPSHOT^</version^>
echo     ^<packaging^>war^</packaging^>
echo.
echo     ^<dependencies^>
echo         ^<dependency^>
echo             ^<groupId^>org.eclipse.jetty^</groupId^>
echo             ^<artifactId^>jetty-server^</artifactId^>
echo             ^<version^>9.4.43.v20210629^</version^>
echo         ^</dependency^>
echo         ^<dependency^>
echo             ^<groupId^>org.eclipse.jetty^</groupId^>
echo             ^<artifactId^>jetty-servlet^</artifactId^>
echo             ^<version^>9.4.43.v20210629^</version^>
echo         ^</dependency^>
echo         ^<dependency^>
echo             ^<groupId^>com.google.code.gson^</groupId^>
echo             ^<artifactId^>gson^</artifactId^>
echo             ^<version^>2.8.8^</version^>
echo         ^</dependency^>
echo         ^<dependency^>
echo             ^<groupId^>junit^</groupId^>
echo             ^<artifactId^>junit^</artifactId^>
echo             ^<version^>4.13.2^</version^>
echo             ^<scope^>test^</scope^>
echo         ^</dependency^>
echo     ^</dependencies^>
echo.
echo     ^<build^>
echo         ^<plugins^>
echo             ^<plugin^>
echo                 ^<groupId^>org.apache.maven.plugins^</groupId^>
echo                 ^<artifactId^>maven-compiler-plugin^</artifactId^>
echo                 ^<version^>3.8.1^</version^>
echo                 ^<configuration^>
echo                     ^<source^>1.8^</source^>
echo                     ^<target^>1.8^</target^>
echo                 ^</configuration^>
echo             ^</plugin^>
echo             ^<plugin^>
echo                 ^<groupId^>org.codehaus.mojo^</groupId^>
echo                 ^<artifactId^>exec-maven-plugin^</artifactId^>
echo                 ^<version^>3.0.0^</version^>
echo                 ^<configuration^>
echo                     ^<mainClass^>com.todoapp.Main^</mainClass^>
echo                 ^</configuration^>
echo             ^</plugin^>
echo         ^</plugins^>
echo     ^</build^>
echo ^</project^>
) > pom.xml

echo Project structure created successfully!
