-- ============================================
-- JDBC_Programs Database Setup Script
-- MySQL Database Configuration
-- ============================================

-- Drop existing database if it exists
DROP DATABASE IF EXISTS jdbc_db;

-- Create new database
CREATE DATABASE jdbc_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Use the created database
USE jdbc_db;

-- ============================================
-- Table 1: Employees Table
-- ============================================
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    hire_date DATE NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    department_id INT,
    manager_id INT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_department (department_id),
    INDEX idx_hire_date (hire_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table 2: Departments Table
-- ============================================
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100),
    budget DECIMAL(12, 2),
    manager_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_name (department_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table 3: Projects Table
-- ============================================
CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(150) NOT NULL,
    description TEXT,
    start_date DATE NOT NULL,
    end_date DATE,
    budget DECIMAL(12, 2),
    status ENUM('Planning', 'In Progress', 'On Hold', 'Completed', 'Cancelled') DEFAULT 'Planning',
    department_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    INDEX idx_status (status),
    INDEX idx_start_date (start_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table 4: Employee Projects (Many-to-Many)
-- ============================================
CREATE TABLE employee_projects (
    emp_project_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    project_id INT NOT NULL,
    role VARCHAR(100),
    assigned_date DATE NOT NULL,
    status ENUM('Active', 'Completed', 'Inactive') DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE,
    UNIQUE KEY unique_emp_project (employee_id, project_id),
    INDEX idx_project (project_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Table 5: Salaries Table (History)
-- ============================================
CREATE TABLE salary_history (
    salary_history_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    old_salary DECIMAL(10, 2),
    new_salary DECIMAL(10, 2) NOT NULL,
    change_reason VARCHAR(255),
    effective_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE,
    INDEX idx_employee (employee_id),
    INDEX idx_date (effective_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- Sample Data Insertion
-- ============================================

-- Insert Departments
INSERT INTO departments (department_name, location, budget) VALUES
('Information Technology', 'Bangalore', 5000000.00),
('Human Resources', 'Hyderabad', 2000000.00),
('Finance', 'Mumbai', 3000000.00),
('Marketing', 'Pune', 1500000.00),
('Operations', 'Kolkata', 2500000.00);

-- Insert Employees
INSERT INTO employees (first_name, last_name, email, phone_number, hire_date, salary, department_id, is_active) VALUES
('John', 'Doe', 'john.doe@company.com', '9876543210', '2022-01-15', 75000.00, 1, TRUE),
('Jane', 'Smith', 'jane.smith@company.com', '9876543211', '2022-02-20', 82000.00, 1, TRUE),
('Rajesh', 'Kumar', 'rajesh.kumar@company.com', '9876543212', '2021-06-10', 65000.00, 1, TRUE),
('Priya', 'Sharma', 'priya.sharma@company.com', '9876543213', '2023-03-05', 60000.00, 2, TRUE),
('Amit', 'Singh', 'amit.singh@company.com', '9876543214', '2022-05-12', 78000.00, 3, TRUE),
('Divya', 'Patel', 'divya.patel@company.com', '9876543215', '2023-01-18', 55000.00, 4, TRUE),
('Suresh', 'Gupta', 'suresh.gupta@company.com', '9876543216', '2021-09-01', 70000.00, 5, TRUE),
('Neha', 'Verma', 'neha.verma@company.com', '9876543217', '2022-11-08', 68000.00, 1, TRUE);

-- Insert Projects
INSERT INTO projects (project_name, description, start_date, end_date, budget, status, department_id) VALUES
('Mobile App Development', 'Develop cross-platform mobile application', '2023-01-01', '2024-06-30', 500000.00, 'In Progress', 1),
('Cloud Migration', 'Migrate legacy systems to cloud infrastructure', '2023-03-15', '2024-03-14', 750000.00, 'In Progress', 1),
('HR Portal Redesign', 'Redesign internal HR management portal', '2023-06-01', '2024-02-28', 300000.00, 'Planning', 2),
('Financial Dashboard', 'Create real-time financial reporting dashboard', '2023-07-01', '2024-01-31', 400000.00, 'In Progress', 3),
('Marketing Automation', 'Implement marketing automation platform', '2023-08-15', NULL, 350000.00, 'Planning', 4);

-- Insert Employee-Project Assignments
INSERT INTO employee_projects (employee_id, project_id, role, assigned_date, status) VALUES
(1, 1, 'Project Lead', '2023-01-01', 'Active'),
(2, 1, 'Senior Developer', '2023-01-01', 'Active'),
(3, 2, 'Cloud Architect', '2023-03-15', 'Active'),
(4, 3, 'HR Analyst', '2023-06-01', 'Active'),
(5, 4, 'Finance Lead', '2023-07-01', 'Active'),
(6, 5, 'Marketing Manager', '2023-08-15', 'Active'),
(7, 2, 'DevOps Engineer', '2023-03-15', 'Active'),
(8, 1, 'QA Engineer', '2023-02-01', 'Active'),
(1, 4, 'Technical Consultant', '2023-09-01', 'Active');

-- Insert Salary History
INSERT INTO salary_history (employee_id, old_salary, new_salary, change_reason, effective_date) VALUES
(1, 70000.00, 75000.00, 'Annual Increment', '2023-06-01'),
(2, 78000.00, 82000.00, 'Promotion', '2023-07-15'),
(3, 62000.00, 65000.00, 'Annual Increment', '2023-08-01'),
(7, 68000.00, 70000.00, 'Annual Increment', '2023-09-01');

-- ============================================
-- Views (Optional but useful)
-- ============================================

-- View: Employee Details with Department
CREATE VIEW employee_details AS
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    e.email,
    e.phone_number,
    e.hire_date,
    e.salary,
    d.department_name,
    e.is_active
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
ORDER BY e.employee_id;

-- View: Active Projects with Employee Count
CREATE VIEW project_team_summary AS
SELECT 
    p.project_id,
    p.project_name,
    p.status,
    d.department_name,
    COUNT(ep.employee_id) AS team_size,
    p.budget
FROM projects p
LEFT JOIN departments d ON p.department_id = d.department_id
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id AND ep.status = 'Active'
GROUP BY p.project_id, p.project_name, p.status, d.department_name, p.budget
ORDER BY p.project_id;

-- ============================================
-- Stored Procedures (Optional)
-- ============================================

-- Procedure: Get Employee Count by Department
DELIMITER //
CREATE PROCEDURE get_employees_by_department(IN dept_id INT)
BEGIN
    SELECT 
        e.employee_id,
        CONCAT(e.first_name, ' ', e.last_name) AS full_name,
        e.email,
        e.salary,
        d.department_name
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    WHERE e.department_id = dept_id AND e.is_active = TRUE
    ORDER BY e.last_name;
END //
DELIMITER ;

-- ============================================
-- Database Statistics
-- ============================================
-- Total Records:
-- Employees: 8
-- Departments: 5
-- Projects: 5
-- Employee-Project Assignments: 9
-- Salary History Records: 4
-- ============================================
