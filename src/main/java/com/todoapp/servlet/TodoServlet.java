package com.todoapp.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.todoapp.model.Todo;
import com.todoapp.repository.TodoRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/todos/*")
public class TodoServlet extends HttpServlet {
    private TodoRepository repository;
    private ObjectMapper objectMapper;

    @Override
    public void init() {
        repository = TodoRepository.getInstance();
        objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule()); // Register the JavaTimeModule
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.getWriter().write(objectMapper.writeValueAsString(repository.getAllTodos()));
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String task = req.getParameter("task");
        if (task != null && !task.trim().isEmpty()) {
            Todo newTodo = new Todo(task);
            repository.addTodo(newTodo);
            resp.setContentType("application/json");
            resp.getWriter().write(objectMapper.writeValueAsString(newTodo));
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Task cannot be empty");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo != null) {
            String todoId = pathInfo.substring(1);
            repository.removeTodo(todoId);
            resp.setStatus(HttpServletResponse.SC_NO_CONTENT);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Todo ID is required");
        }
    }
}