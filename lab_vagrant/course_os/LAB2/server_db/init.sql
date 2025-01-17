CREATE TABLE IF NOT EXISTS employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    position VARCHAR(50) NOT NULL
);

INSERT INTO employees (name, position) VALUES
('Alice', 'Manager'),
('Bob', 'Developer'),
('Charlie', 'Designer');
