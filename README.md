# JDBC Programs

A comprehensive Java application demonstrating dynamic JDBC connectivity with MySQL database. This project showcases metadata-driven table inspection and runtime data retrieval without predefined schema definitions.

## Overview

This application connects to a MySQL database using JDBC and provides dynamic inspection of table structure and records. It demonstrates advanced JDBC features including:

- **Dynamic Schema Inspection**: Retrieves column names and data types at runtime via database metadata
- **Schema-Independent Data Retrieval**: Display unknown table data without predefined schema
- **Robust Exception Handling**: Comprehensive error handling with proper resource management
- **Resource Management**: Proper closing of connections, statements, and result sets

## Features

✅ Dynamic table structure inspection  
✅ Runtime column metadata extraction  
✅ Schema-agnostic data display  
✅ Exception handling and logging  
✅ Connection pooling ready  
✅ Resource cleanup with try-with-resources  

## Project Structure

```
JDBC_Programs/
├── C-Create/          # JDBC Create operations (INSERT)
├── R-Read/DESC/       # JDBC Read operations (SELECT, DESCRIBE)
└── README.md          # Project documentation
```

## Prerequisites

- **Java**: JDK 8 or higher
- **MySQL**: MySQL 5.7 or higher
- **JDBC Driver**: MySQL Connector/J (mysql-connector-java)
- **Build Tool**: Maven or Gradle (optional)

## Installation & Setup

### 1. Install MySQL

```bash
# On Linux/Mac
brew install mysql

# On Windows
# Download from https://dev.mysql.com/downloads/mysql/
```

### 2. Download JDBC Driver

Download MySQL Connector/J from:
https://dev.mysql.com/downloads/connector/j/

Or add via Maven:

```xml
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>8.0.33</version>
</dependency>
```

### 3. Configure Database Connection

Update your Java code with:

```java
private static final String URL = "jdbc:mysql://localhost:3306/your_database";
private static final String USER = "your_username";
private static final String PASSWORD = "your_password";
```

## Usage

### Creating Records

Run the Create operation class:

```bash
javac C-Create/*.java
java C-Create.YourCreateClass
```

### Reading Records

Run the Read operation class:

```bash
javac R-Read/DESC/*.java
java R-Read/DESC.YourReadClass
```

### Dynamic Table Inspection Example

```java
private static void inspectTable(String tableName) throws SQLException {
    String query = "SELECT * FROM " + tableName;
    try (Statement stmt = connection.createStatement();
         ResultSet rs = stmt.executeQuery(query)) {
        
        ResultSetMetaData metadata = rs.getMetaData();
        int columnCount = metadata.getColumnCount();
        
        // Print column names and types
        for (int i = 1; i <= columnCount; i++) {
            System.out.println(metadata.getColumnName(i) + " : " 
                + metadata.getColumnTypeName(i));
        }
        
        // Print data
        while (rs.next()) {
            for (int i = 1; i <= columnCount; i++) {
                System.out.print(rs.getObject(i) + "\t");
            }
            System.out.println();
        }
    } catch (SQLException e) {
        System.err.println("Database error: " + e.getMessage());
        throw e;
    }
}
```

## Key JDBC Concepts Covered

### 1. **Connection Management**
```java
Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
```

### 2. **ResultSet Metadata**
```java
ResultSetMetaData metadata = resultSet.getMetaData();
metadata.getColumnCount();        // Get number of columns
metadata.getColumnName(index);    // Get column name
metadata.getColumnTypeName(index); // Get data type
```

### 3. **Try-with-Resources for Resource Management**
```java
try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
     Statement stmt = conn.createStatement();
     ResultSet rs = stmt.executeQuery(query)) {
    // Use resources
} catch (SQLException e) {
    e.printStackTrace();
}
```

### 4. **Exception Handling**
- SQLExceptions caught and handled properly
- Resource cleanup ensured
- Error messages logged

## Database Schema Example

Create a sample table to test:

```sql
CREATE DATABASE test_db;

USE test_db;

CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    salary DECIMAL(10, 2),
    department VARCHAR(50),
    joining_date DATE
);

INSERT INTO employees VALUES 
(1, 'John Doe', 'john@example.com', 50000, 'IT', '2023-01-15'),
(2, 'Jane Smith', 'jane@example.com', 55000, 'HR', '2023-02-20');
```

## Common JDBC Operations

### INSERT (Create)
```java
String sql = "INSERT INTO table_name (col1, col2) VALUES (?, ?)";
PreparedStatement pstmt = conn.prepareStatement(sql);
pstmt.setString(1, "value1");
pstmt.setString(2, "value2");
pstmt.executeUpdate();
```

### SELECT (Read)
```java
String sql = "SELECT * FROM table_name";
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);
```

### UPDATE
```java
String sql = "UPDATE table_name SET col1 = ? WHERE id = ?";
PreparedStatement pstmt = conn.prepareStatement(sql);
pstmt.setString(1, "new_value");
pstmt.setInt(2, id);
pstmt.executeUpdate();
```

### DELETE
```java
String sql = "DELETE FROM table_name WHERE id = ?";
PreparedStatement pstmt = conn.prepareStatement(sql);
pstmt.setInt(1, id);
pstmt.executeUpdate();
```

## Best Practices Implemented

✅ Use **PreparedStatements** to prevent SQL injection  
✅ Use **Try-with-resources** for automatic resource management  
✅ **Close connections** properly to avoid connection leaks  
✅ Handle **SQLExceptions** appropriately  
✅ Use **Connection pooling** for production applications  
✅ Parameterize queries to prevent SQL injection  
✅ Log errors for debugging  

## Troubleshooting

### Connection Refused
```
Exception: Connection refused: connect
```
**Solution**: Ensure MySQL is running and credentials are correct

### No suitable driver found
```
Exception: No suitable driver found for jdbc:mysql://localhost:3306/db
```
**Solution**: Add MySQL Connector/J JAR to classpath

### Access Denied
```
Exception: Access denied for user 'username'@'localhost'
```
**Solution**: Verify username and password in connection string

## Performance Tips

1. Use batch operations for multiple inserts
2. Implement connection pooling (HikariCP, C3P0)
3. Use PreparedStatements (cached by driver)
4. Set appropriate fetch sizes
5. Index frequently queried columns

## Future Enhancements

- [ ] Implement connection pooling (HikariCP)
- [ ] Add transaction management
- [ ] Create utility classes for common operations
- [ ] Add logging framework (SLF4J)
- [ ] Implement DAO pattern
- [ ] Add unit tests with JUnit

## Learning Resources

- [JDBC Official Documentation](https://docs.oracle.com/javase/8/docs/technotes/guides/jdbc/)
- [MySQL Connector/J Documentation](https://dev.mysql.com/doc/connector-j/en/)
- [PreparedStatements vs Statements](https://stackoverflow.com/questions/4365020/prepared-statement-vs-statement)

## Contributing

Feel free to fork this repository and submit pull requests for:
- Bug fixes
- New features
- Documentation improvements
- Code optimization

## License

This project is open source and available under the MIT License.

## Author

**SiliveruSumanth**  
Java Developer | JDBC Enthusiast  
Hyderabad, India

---

**Last Updated**: February 15, 2026  
**Status**: Active Development
