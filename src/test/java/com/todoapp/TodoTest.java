package com.todoapp;

import com.todoapp.model.Todo;
import com.todoapp.repository.TodoRepository;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

public class TodoTest {
    private TodoRepository repository;

    @Before
    public void setUp() {
        repository = TodoRepository.getInstance();
    }

    @Test
    public void testAddTodo() {
        Todo todo = new Todo("Test Task");
        repository.addTodo(todo);
        assertTrue(repository.getAllTodos().contains(todo));
    }

    @Test
    public void testRemoveTodo() {
        Todo todo = new Todo("Test Task");
        repository.addTodo(todo);
        repository.removeTodo(todo.getId());
        assertFalse(repository.getAllTodos().contains(todo));
    }
}