-- 1. CREACIÓN DE BASE DE DATOS
\c db_exercises

-- 2. CREACIÓN DE TABLAS

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE user_addresses (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    address_line VARCHAR(255) NOT NULL,
    city VARCHAR(50),
    country VARCHAR(50),
    postal_code VARCHAR(20)
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10,2) NOT NULL,
    category_id INT REFERENCES categories(id)
);

CREATE TABLE carts (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE cart_items (
    id SERIAL PRIMARY KEY,
    cart_id INT REFERENCES carts(id),
    product_id INT REFERENCES products(id),
    quantity INT DEFAULT 1
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    cart_id INT REFERENCES carts(id),
    created_at TIMESTAMP DEFAULT NOW(),
    address_id INT REFERENCES user_addresses(id),
    total NUMERIC(10,2),
    status VARCHAR(20) NOT NULL DEFAULT 'pending' -- pending | paid | shipped | delivered | cancelled
);

-- 3. DATOS DE EJEMPLO

-- USERS
INSERT INTO users (username, email) VALUES
('juanp', 'juan@gmail.com'),
('martina', 'martina@mail.com'),
('carlosm', 'carlos@mail.com'),
('sofiaa', 'sofia.a@gmail.com'),
('lucast', 'lucas.t@mail.com'),
('mariar', 'maria.rosa@mail.com'),
('pedrob', 'pedro.brito@mail.com'),
('anab', 'ana.b@mail.com'),
('diegoz', 'diego.z@mail.com'),
('milenag', 'milena.gomez@mail.com'),
('alejandror', 'alejandro.r@mail.com'),
('veronicas', 'vero.smith@mail.com');

-- USER_ADDRESSES
INSERT INTO user_addresses (user_id, address_line, city, country, postal_code) VALUES
(1, 'Calle Falsa 123', 'Madrid', 'España', '28001'),
(2, 'Av. Siempre Viva 742', 'Buenos Aires', 'Argentina', '1001'),
(3, 'Rua Principal 500', 'Lisboa', 'Portugal', '1100'),
(4, 'C/ Mayor 10', 'Barcelona', 'España', '08001'),
(5, 'Rua Nova 44', 'Porto', 'Portugal', '4050-099'),
(6, 'Rua da Alegria 15', 'Coimbra', 'Portugal', '3000-099'),
(7, 'Calle 8 Nro 15', 'Rosario', 'Argentina', '2000'),
(8, 'Av. del Libertador 999', 'CABA', 'Argentina', '1426'),
(9, 'Blvd. Los Andes 221', 'Córdoba', 'Argentina', '5000'),
(10, 'Rua das Flores 8', 'Oporto', 'Portugal', '4100-021'),
(11, 'Calle Larga 101', 'Sevilla', 'España', '41001'),
(12, 'Avenida Marítima 25', 'Santa Cruz', 'España', '38001');


-- CATEGORIES
INSERT INTO categories (name) VALUES
('Electrónica'),
('Libros'),
('Ropa'),
('Hogar'),
('Juguetes'),
('Deportes'),
('Oficina');

-- PRODUCTS
INSERT INTO products (name, price, category_id) VALUES
('Auriculares Bluetooth', 49.99, 1),
('Libro SQL Fácil', 19.95, 2),
('Camiseta Negra', 15.50, 3),
('Laptop 14"', 799.00, 1),
('Pantalón Jeans', 39.90, 3),
('Taza de café', 7.80, 4),
('Robot de juguete', 32.50, 5),
('Lámpara de escritorio', 25.00, 4),
('Libro Python Intermedio', 23.99, 2),
('Vestido Azul', 29.00, 3),
('Cargador USB-C', 12.75, 1),
('Juego de cubiertos', 14.50, 4),
('Muñeca clásica', 21.00, 5),
('Pelota fútbol', 34.99, 6),
('Mouse inalámbrico', 24.90, 1),
('Libro Data Science', 28.99, 2),
('Teclado mecánico', 61.00, 1),
('Zapatillas running', 65.00, 6),
('Silla de oficina', 135.00, 7),
('Impresora', 120.00, 7);

-- CARTS
INSERT INTO carts (user_id, created_at) VALUES
(1, NOW() - INTERVAL '10 days'),
(2, NOW() - INTERVAL '9 days'),
(3, NOW() - INTERVAL '8 days'),
(4, NOW() - INTERVAL '7 days'),
(5, NOW() - INTERVAL '6 days'),
(6, NOW() - INTERVAL '5 days'),
(7, NOW() - INTERVAL '4 days'),
(8, NOW() - INTERVAL '3 days'),
(9, NOW() - INTERVAL '2 days'),
(10, NOW() - INTERVAL '1 days'),
(11, NOW()),
(12, NOW());

-- CART_ITEMS
INSERT INTO cart_items (cart_id, product_id, quantity) VALUES
-- Juanp (cart 1)
(1, 1, 2), (1, 2, 1), (1, 3, 1),
-- Martina (cart 2)
(2, 3, 3), (2, 7, 2),
-- Carlos (cart 3)
(3, 4, 1), (3, 5, 2), (3, 8, 1),
-- Sofia (cart 4)
(4, 11, 1), (4, 1, 1), (4, 6, 2),
-- Lucas (cart 5)
(5, 9, 1), (5, 10, 1), (5, 16, 2),
-- Maria (cart 6)
(6, 12, 3), (6, 15, 1),
-- Pedro (cart 7)
(7, 8, 2), (7, 13, 1),
-- Ana (cart 8)
(8, 2, 2), (8, 5, 1), (8, 20, 1),
-- Diego (cart 9)
(9, 17, 1), (9, 18, 1),
-- Milena (cart 10)
(10, 6, 4), (10, 14, 1), (10, 19, 1),
-- Alejandro (cart 11)
(11, 1, 1), (11, 4, 1), (11, 11, 1),
-- Veronica (cart 12)
(12, 15, 2), (12, 12, 1);

-- ORDERS
INSERT INTO orders (user_id, cart_id, created_at, address_id, total, status) VALUES
(1, 1, NOW() - INTERVAL '9 days', 1, 135.43, 'delivered'),
(2, 2, NOW() - INTERVAL '8 days', 2, 97.90, 'cancelled'),
(3, 3, NOW() - INTERVAL '7 days', 3, 878.80, 'paid'),
(4, 4, NOW() - INTERVAL '6 days', 4, 69.59, 'delivered'),
(5, 5, NOW() - INTERVAL '5 days', 5, 154.98, 'pending'),
(6, 6, NOW() - INTERVAL '4 days', 6, 58.40, 'pending'),
(7, 7, NOW() - INTERVAL '3 days', 7, 71.00, 'cancelled'),
(8, 8, NOW() - INTERVAL '2 days', 8, 81.85, 'pending'),
(9, 9, NOW() - INTERVAL '1 days', 9, 126.00, 'pending'),
(10, 10, NOW(), 10, 210.29, 'pending');
-- Alejandro y Veronica (cart 11 y 12) aún no han realizado orders

