INSERT INTO relacao_compatibilidade (tipo_doador, tipo_receptor) VALUES
('A+', 'AB+'), ('A+', 'A+'), ('A-', 'A+'), ('A-', 'A-'), 
('A-', 'AB+'), ('A-', 'AB-'), ('B+', 'B+'), ('B+', 'AB+'),
('B-', 'B+'), ('B-', 'B-'), ('B-', 'AB+'), ('B-', 'AB-'),
('AB+', 'AB+'), ('AB-', 'AB+'), ('AB-', 'AB-'), ('O+', 'A+'),
('O+', 'B+'), ('O+', 'AB+'), ('O+', 'O+'), ('O-', 'A+'),
('O-', 'B+'), ('O-', 'AB+'), ('O-', 'O+'), ('O-', 'A-'),
('O-', 'B-'), ('O-', 'AB-'), ('O-', 'O-')
ON DUPLICATE KEY UPDATE tipo_receptor = VALUES(tipo_receptor);
