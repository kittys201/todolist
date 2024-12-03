package com.todoapp.model;

import java.time.LocalDateTime;
import java.util.UUID;

public class Todo {
    private String id;
    private String task;
    private boolean completed;
    private LocalDateTime createdAt;

    public Todo(String task) {
        this.id = UUID.randomUUID().toString();
        this.task = task;
        this.completed = false;
        this.createdAt = LocalDateTime.now();
    }

    // Getters and setters
    public String getId() { return id; }
    public String getTask() { return task; }
    public void setTask(String task) { this.task = task; }
    public boolean isCompleted() { return completed; }
    public void setCompleted(boolean completed) { this.completed = completed; }
    public LocalDateTime getCreatedAt() { return createdAt; }
}
