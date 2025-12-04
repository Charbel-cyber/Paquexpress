-- db/db_schema.sql
CREATE DATABASE IF NOT EXISTS paquexpress;
USE paquexpress;

CREATE TABLE IF NOT EXISTS agente (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(150) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  creado_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS paquete (
  id INT AUTO_INCREMENT PRIMARY KEY,
  descripcion TEXT,
  direccion_dest VARCHAR(300) NOT NULL,
  peso DECIMAL(6,2),
  estado ENUM('pendiente','en_ruta','entregado') DEFAULT 'pendiente'
);

CREATE TABLE IF NOT EXISTS entrega (
  id INT AUTO_INCREMENT PRIMARY KEY,
  paquete_id INT NOT NULL,
  direccion VARCHAR(300) NOT NULL,
  lat DECIMAL(10,7),
  lon DECIMAL(10,7),
  foto_url TEXT,
  estado ENUM('pendiente','entregado') DEFAULT 'entregado',
  entregado_por INT,
  entregado_en DATETIME,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (paquete_id) REFERENCES paquete(id),
  FOREIGN KEY (entregado_por) REFERENCES agente(id)
);

CREATE TABLE IF NOT EXISTS deliveries_evidence (
  id INT AUTO_INCREMENT PRIMARY KEY,
  package_id INT,
  latitude DOUBLE,
  longitude DOUBLE,
  image LONGTEXT,
  date DATETIME
);

-- Datos de ejemplo
INSERT INTO paquete (descripcion, direccion_dest, peso) VALUES ('Caja pequeña', 'Av. Reforma 123, Ciudad', 1.25);
INSERT INTO paquete (descripcion, direccion_dest, peso) VALUES ('Documento', 'Calle Juarez 45, Ciudad', 0.20);
