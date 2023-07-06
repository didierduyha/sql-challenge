--DROP TABLE IF EXISTS departments, 
--	dept_emp,
--	dept_manager,
--	employees,
--	salaries,
--	titles;

CREATE TABLE IF NOT EXISTS departments (
	dept_no CHAR(4) NOT NULL PRIMARY KEY,
	dept_name VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS dept_emp(
	emp_no CHAR(6) NOT NULL,
	dept_no CHAR(4) NOT NULL,
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE IF NOT EXISTS dept_manager(
	dept_no CHAR(4) NOT NULL,
	emp_no CHAR(6) NOT NULL,
	PRIMARY KEY (dept_no, emp_no)
);

CREATE TABLE IF NOT EXISTS employees(
	emp_no CHAR(6) PRIMARY KEY,
	emp_title CHAR(5) NOT NULL,
	birth_date VARCHAR(10),
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex CHAR,
	hire_date VARCHAR(10),
	FOREIGN KEY (emp_title) REFERENCES titles(title_id)
);

CREATE TABLE IF NOT EXISTS salaries(
	emp_no CHAR(6) PRIMARY KEY,
	salary INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE IF NOT EXISTS titles(
	title_id INT PRIMARY KEY,
	title VARCHAR(30)
);

--1. 
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary FROM employees 
INNER JOIN salaries
ON employees.emp_no = salaries.emp_no;

--2.
SELECT first_name, last_name, hire_date FROM employees
WHERE hire_date LIKE '%1986';

--3.
SELECT dept_manager.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name FROM dept_manager
INNER JOIN departments
ON dept_manager.dept_no = departments.dept_no
INNER JOIN employees
ON dept_manager.emp_no = employees.emp_no;

--4.
SELECT dept_emp.dept_no, employees.emp_no, employees.last_name, employees.first_name, departments.dept_name FROM dept_emp
INNER JOIN departments
ON dept_emp.dept_no = departments.dept_no
INNER JOIN employees
ON dept_emp.emp_no = employees.emp_no;

--5.
SElECT first_name, last_name, sex FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--6.
SELECT employees.emp_no, employees.last_name, employees.first_name FROM dept_emp
INNER JOIN departments
ON dept_emp.dept_no = departments.dept_no
INNER JOIN employees
ON dept_emp.emp_no = employees.emp_no
WHERE departments.dept_name = 'Sales';

--7.
SELECT employees.emp_no, employees.last_name, employees.first_name FROM dept_emp
INNER JOIN departments
ON dept_emp.dept_no = departments.dept_no
INNER JOIN employees
ON dept_emp.emp_no = employees.emp_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';

--8.
SELECT last_name, COUNT(last_name) FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;