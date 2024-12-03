package com.todoapp;

import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.servlet.ServletContextHandler;
import org.eclipse.jetty.servlet.ServletHolder;
import com.todoapp.servlet.TodoServlet;

public class Main {
    public static void main(String[] args) throws Exception {
        Server server = new Server(8080);
        ServletContextHandler context = new ServletContextHandler(ServletContextHandler.SESSIONS);
        context.setContextPath("/");
        server.setHandler(context);

        context.addServlet(new ServletHolder(new TodoServlet()), "/todos/*");
        context.addServlet(new ServletHolder(new org.eclipse.jetty.servlet.DefaultServlet()), "/");
        context.setResourceBase("src/main/webapp");
        context.setWelcomeFiles(new String[]{"index.html"});

        try {
            server.start();
            server.join();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            server.destroy();
        }
    }
}