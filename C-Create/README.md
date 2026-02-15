# C-Create Operations

## Overview
This folder contains Java classes demonstrating JDBC **CREATE** operations for database management.

## What's Inside

### Subfolders:

1. **connectionWithDb/** - Database Connection Management
   - Establishing JDBC connections
   - Connection configuration and setup
   - Connection pooling concepts
   - Resource management patterns

2. **CreationOfTable/** - Table Creation Operations
   - CREATE TABLE statements
   - Table schema definition
   - Column constraints and data types
   - Primary keys and indexes

3. **Insertion/** - Data Insertion Operations
   - INSERT INTO statements
   - Single and batch inserts
   - Using PreparedStatement for safe queries
   - Exception handling for inserts

## File Structure
```
C-Create/
├── connectionWithDb/     # Database connection classes
├── CreationOfTable/      # Table creation classes  
├── Insertion/           # Data insertion classes
└── README.md            # This file
```

## Quick Start

### Step 1: Establish Database Connection
```bash
cd connectionWithDb
# Review and run connection setup classes
```

### Step 2: Create Tables
```bash
cd ../CreationOfTable
# Run table creation classes
```

### Step 3: Insert Data
```bash
cd ../Insertion
# Run insertion classes with sample data
```

## Key JDBC Concepts

### Connection Management
- DriverManager.getConnection()
- Connection interface
- Try-with-resources pattern

### Creating Tables
- Statement vs PreparedStatement
- Schema design
- Constraints and validation

### Inserting Data
- executeUpdate() method
- Batch operations
- Transaction management
- Error handling

## Code Examples

### Basic Connection
```java
String url = "jdbc:mysql://localhost:3306/jdbc_db";
String user = "root";
String password = "password";

try (Connection conn = DriverManager.getConnection(url, user, password)) {
    System.out.println("Connected to database!");
} catch (SQLException e) {
    e.printStackTrace();
}
```

### Creating a Table
```java
String sql = "CREATE TABLE employees (" +
    "id INT PRIMARY KEY AUTO_INCREMENT," +
    "name VARCHAR(100) NOT NULL," +
    "email VARCHAR(100) UNIQUE," +
    "salary DECIMAL(10, 2))";

try (Statement stmt = conn.createStatement()) {
    stmt.executeUpdate(sql);
    System.out.println("Table created successfully!");
} catch (SQLException e) {
    e.printStackTrace();
}
```

### Inserting Data
```java
String sql = "INSERT INTO employees (name, email, salary) VALUES (?, ?, ?)";

try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
    pstmt.setString(1, "John Doe");
    pstmt.setString(2, "john@example.com");
    pstmt.setDouble(3, 75000.00);
    
    int rows = pstmt.executeUpdate();
    System.out.println(rows + " row(s) inserted!");
} catch (SQLException e) {
    e.printStackTrace();
}
```

## Best Practices

✅ Use PreparedStatement to prevent SQL injection  
✅ Always close connections and resources  
✅ Use try-with-resources for automatic resource management  
✅ Handle exceptions properly  
✅ Use batch operations for multiple inserts  
✅ Validate data before insertion  
✅ Use transactions for multiple related operations  

## How to Upload Your Files

### Option 1: Upload via GitHub UI
1. Click **"Add file"** button in this folder
2. Select **"Upload files"**
3. Drag and drop your `.java` files
4. Add a commit message
5. Click **"Commit changes"**

### Option 2: Using Command Line
```bash
# Clone the repository
git clone https://github.com/SiliveruSumanth/JDBC_Programs.git
cd JDBC_Programs/C-Create

# Copy your Java files to respective subfolders
cp YourConnectionClass.java connectionWithDb/
cp YourTableClass.java CreationOfTable/
cp YourInsertClass.java Insertion/

# Add, commit, and push
git add .
git commit -m "Add JDBC create operation classes"
git push origin main
```

## Testing Your Code

1. Ensure MySQL is running
2. Update database credentials in your connection classes
3. Compile: `javac *.java`
4. Run: `java ClassName`
5. Check MySQL for created tables and inserted data

## Troubleshooting

**No database selected error**
- Ensure the database name in connection URL is correct
- Run database/setup.sql first to create the database

**Table already exists**
- Drop the table before creating: `DROP TABLE table_name;`
- Or use: `CREATE TABLE IF NOT EXISTS`

**SQL Syntax Error**
- Check for missing quotes and commas
- Verify data types are correct
- Use MySQL Workbench to test queries first

## Related Files

- See `R-Read/DESC/` folder for READ operations
- See `database/setup.sql` for complete schema
- See root `README.md` for project overview

---

**Last Updated:** February 15, 2026  
**Status:** Ready for file uploads
