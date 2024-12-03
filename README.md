
# Todo List Application

## Overview
A simple and efficient Todo List application built with Java, Jetty, and styled with Tailwind CSS. This application allows users to add, view, and delete tasks, providing a clean and intuitive interface for managing daily tasks.

[Live Demo](#)  
[GitHub Repository](https://github.com/kittys201/todolist)  
[Video Demo](#)

The application provides essential features including:
- Adding new tasks
- Viewing all tasks
- Deleting tasks

---

## Features
- **Task Management**: Simple and intuitive interface for adding, viewing, and deleting tasks.
- **Real-time Updates**: Instant updates to the task list.
- **Responsive Design**: Seamless experience across all devices.
- **Error Handling**: Clear feedback for invalid inputs or server issues.
- **Modern UI**: Clean and intuitive interface using Tailwind CSS.

---

## Development Environment
### Technologies Used
- **Backend**:
  - Java 11
  - Jetty Server
  - Servlet API
  - Gson for JSON serialization
  - Maven for build management

- **Frontend**:
  - HTML5
  - JavaScript (ES6+)
  - Tailwind CSS for styling

---

### Version Information
```xml
<dependencies>
    <dependency>
        <groupId>javax.servlet</groupId>
        <artifactId>javax.servlet-api</artifactId>
        <version>4.0.1</version>
        <scope>provided</scope>
    </dependency>
    <dependency>
        <groupId>org.eclipse.jetty</groupId>
        <artifactId>jetty-server</artifactId>
        <version>9.4.44.v20210927</version>
    </dependency>
    <dependency>
        <groupId>org.eclipse.jetty</groupId>
        <artifactId>jetty-servlet</artifactId>
        <version>9.4.44.v20210927</version>
    </dependency>
    <dependency>
        <groupId>com.google.code.gson</groupId>
        <artifactId>gson</artifactId>
        <version>2.8.9</version>
    </dependency>
    <dependency>
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <version>4.13.2</version>
        <scope>test</scope>
    </dependency>
</dependencies>
```

---

## Getting Started
### Clone the repository:
```bash
git clone https://github.com/yourusername/todo-list.git
```

### Install dependencies:
```bash
mvn clean install
```

### Start the Jetty server:
```bash
mvn jetty:run
```

### Access the application:
Visit [http://localhost:8080](http://localhost:8080)

---

## Usage
1. Visit the Todo List application.
2. Enter a new task in the input field.
3. View the list of tasks.
4. Use the responsive interface on any device.

---

## Key Components
- **Main.java**: Entry point for the Jetty server.
- **TodoServlet.java**: Handles HTTP requests for managing tasks.
- **TodoRepository.java**: Manages the storage and retrieval of tasks.
- **Todo.java**: Model class for tasks.
- **index.html**: Provides the application structure.
- **tailwind.config.js**: Configures custom styling.

---

## Features in Detail
### Task Management
- Add new tasks with a simple input field.
- View all tasks in a list format.
- Delete tasks with a delete button.

### UI/UX
- Clean and modern interface.
- Responsive design for all screen sizes.
- Interactive task cards.
- Smooth transitions and animations.
- Error handling with user feedback.

---

## Useful Resources
- [Jetty Documentation](https://www.eclipse.org/jetty/documentation/)
- [Servlet API Documentation](https://javaee.github.io/servlet-spec/)
- [Gson Documentation](https://github.com/google/gson)
- [Tailwind CSS Documentation](https://tailwindcss.com/)
- [Maven Documentation](https://maven.apache.org/)

---

## Contributing
Contributions are welcome! Feel free to fork this project and submit pull requests for any improvements you'd like to add.

### Steps to Contribute:
1. Fork the project.
2. Create your feature branch:
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. Commit your changes:
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```
4. Push to the branch:
   ```bash
   git push origin feature/AmazingFeature
   ```
5. Open a Pull Request.

---

## License
This project is licensed under the ISC License.

---

**Created with ❤️ using Java and Tailwind CSS**
