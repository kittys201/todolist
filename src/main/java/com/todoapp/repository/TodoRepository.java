package com.todoapp.repository;

import com.todoapp.model.Todo;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class TodoRepository {
    private static TodoRepository instance;
    private List<Todo> todos;

    private TodoRepository() {
        todos = new ArrayList<>();
    }

    public static synchronized TodoRepository getInstance() {
        if (instance == null) {
            instance = new TodoRepository();
        }
        return instance;
    }

    public void addTodo(Todo todo) {
        todos.add(todo);
    }

    public List<Todo> getAllTodos() {
        return new ArrayList<>(todos);
    }

    public void toggleTodoStatus(String id) {
        todos = todos.stream()
            .map(todo -> {
                if (todo.getId().equals(id)) {
                    todo.setCompleted(!todo.isCompleted());
                }
                return todo;
            })
            .collect(Collectors.toList());
    }

    public void removeTodo(String id) {
        todos.removeIf(todo -> todo.getId().equals(id));
    }
}
