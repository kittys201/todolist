@echo off

REM Crear la estructura de carpetas
mkdir src\main\java\com\example\todolist
mkdir src\main\resources\META-INF
mkdir src\main\webapp\WEB-INF
mkdir src\main\webapp\css
mkdir src\test\java\com\example\todolist

REM Crear archivos Java
(
echo package com.example.todolist;
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
) > src\main\java\com\example\todolist\Main.java

(
echo package com.example.todolist;
echo.
echo import javax.servlet.ServletException;
echo import javax.servlet.http.HttpServlet;
echo import javax.servlet.http.HttpServletRequest;
echo import javax.servlet.http.HttpServletResponse;
echo import java.io.IOException;
echo import java.util.ArrayList;
echo import java.util.List;
echo.
echo public class TodoServlet extends HttpServlet {
echo     private List<String> todos = new ArrayList<>();
echo.
echo     @Override
echo     protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
echo         resp.setContentType("application/json");
echo         resp.getWriter().write(new Gson().toJson(todos));
echo     }
echo.
echo     @Override
echo     protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
echo         String todo = req.getParameter("todo");
echo         todos.add(todo);
echo         resp.setStatus(HttpServletResponse.SC_OK);
echo     }
echo }
) > src\main\java\com\example\todolist\TodoServlet.java

REM Crear archivo MANIFEST.MF
(
echo Manifest-Version: 1.0
) > src\main\resources\META-INF\MANIFEST.MF

REM Crear archivo web.xml
(
echo ^<!DOCTYPE web-app PUBLIC
echo  "-//Sun Microsystems, Inc.//DTD Web Application 2.3//EN"
echo  "http://java.sun.com/dtd/web-app_2_3.dtd" ^>
echo.
echo ^<web-app^>
echo     ^<display-name^>To-Do List^</display-name^>
echo     ^<description^>A simple to-do list application^</description^>
echo ^</web-app^>
) > src\main\webapp\WEB-INF\web.xml

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
echo             const todo = document.getElementById('todo-input').value;
echo             fetch('/api/todos', {
echo                 method: 'POST',
echo                 headers: {
echo                     'Content-Type': 'application/x-www-form-urlencoded',
echo                 },
echo                 body: `todo=${encodeURIComponent(todo)}`
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
echo                         li.textContent = todo;
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

REM Crear archivo de prueba unitaria
(
echo package com.example.todolist;
echo.
echo import org.junit.Test;
echo import static org.junit.Assert.*;
echo.
echo public class TodoServletTest {
echo     @Test
echo     public void testDoGet() {
echo         // Implement your test here
echo     }
echo.
echo     @Test
echo     public void testDoPost() {
echo         // Implement your test here
echo     }
echo }
) > src\test\java\com\example\todolist\TodoServletTest.java

REM Crear archivos de configuración de Tailwind CSS
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

(
echo module.exports = {
echo   plugins: {
echo     tailwindcss: {},
echo     autoprefixer: {},
echo   },
echo }
) > postcss.config.js

REM Crear archivo package.json
(
echo {
echo   "name": "todo-list",
echo   "version": "1.0.0",
echo   "description": "A simple to-do list application",
echo   "main": "index.js",
echo   "scripts": {
echo     "build:css": "npx tailwindcss -i ./src/main/webapp/css/tailwind.css -o ./src/main/webapp/css/output.css --watch"
echo   },
echo   "dependencies": {
echo     "tailwindcss": "^2.2.19",
echo     "postcss": "^8.3.6",
echo     "autoprefixer": "^10.3.1"
echo   }
echo }
) > package.json

REM Crear archivo pom.xml
(
echo ^<project xmlns="http://maven.apache.org/POM/4.0.0"
echo          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
echo          xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd"^>
echo     ^<modelVersion^>4.0.0^</modelVersion^>
echo     ^<groupId^>com.example^</groupId^>
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
echo                     ^<mainClass^>com.example.todolist.Main^</mainClass^>
echo                 ^</configuration^>
echo             ^</plugin^>
echo         ^</plugins^>
echo     ^</build^>
echo ^</project^>
) > pom.xml

REM Crear archivo README.md
(
echo # To-Do List Application
echo.
echo This is a simple to-do list application built with Java and Tailwind CSS.
echo.
echo ## Setup
echo.
echo 1. **Install dependencies**:
echo    ```sh
echo    npm install
echo    ```
echo.
echo 2. **Build Tailwind CSS**:
echo    ```sh
echo    npm run build:css
echo    ```
echo.
echo 3. **Build and run the Java application**:
echo    ```sh
echo    mvn clean package
echo    mvn exec:java -Dexec.mainClass="com.example.todolist.Main"
echo    ```
echo.
echo 4. **Access the application**:
echo    Open your browser and go to `http://localhost:8080`.
) > README.md

echo Project structure created successfully!