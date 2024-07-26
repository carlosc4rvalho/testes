-- Verifica se o banco de dados já existe e cria-o se não existir
CREATE DATABASE IF NOT EXISTS ecommerce_genérico;
-- Seleciona o banco de dados para uso
USE ecommerce_genérico;

-- Tabela de usuários
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    is_store BOOLEAN DEFAULT FALSE, -- Indica se o usuário é uma loja (true) ou um usuário comum (false)
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de lojas
CREATE TABLE IF NOT EXISTS stores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT, -- Referência ao usuário proprietário da loja
    name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    cnpj VARCHAR(18) UNIQUE, -- CNPJ da loja (opcional)
    logo_url VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Tabela para categorias gerais (e.g., Vestuário, Alimentação)
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT
);

-- Tabela para subcategorias (gerenciadas pelo usuário)
CREATE TABLE IF NOT EXISTS subcategories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

-- Tabela para atributos personalizáveis dos produtos
CREATE TABLE IF NOT EXISTS attributes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type ENUM('text', 'number', 'date', 'boolean', 'select') NOT NULL
);

-- Tabela para valores dos atributos dos produtos
CREATE TABLE IF NOT EXISTS attribute_values (
    id INT AUTO_INCREMENT PRIMARY KEY,
    attribute_id INT,
    value VARCHAR(255) NOT NULL,
    FOREIGN KEY (attribute_id) REFERENCES attributes(id) ON DELETE CASCADE
);

-- Tabela para associar atributos aos produtos
CREATE TABLE IF NOT EXISTS product_attributes (
    product_id INT,
    attribute_id INT,
    value_id INT,
    PRIMARY KEY (product_id, attribute_id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (attribute_id) REFERENCES attributes(id) ON DELETE CASCADE,
    FOREIGN KEY (value_id) REFERENCES attribute_values(id) ON DELETE SET NULL
);

-- Tabela para armazenar informações dos produtos
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    store_id INT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    promotional_price DECIMAL(10, 2),
    is_active BOOLEAN DEFAULT TRUE,
    deleted_at DATETIME NULL, -- Coluna para soft delete
    FOREIGN KEY (store_id) REFERENCES stores(id) ON DELETE CASCADE
);

-- Tabela para armazenar imagens dos produtos
CREATE TABLE IF NOT EXISTS product_images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    image_url VARCHAR(255) NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    deleted_at DATETIME NULL, -- Coluna para soft delete
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Tabela para associar produtos com categorias e subcategorias
CREATE TABLE IF NOT EXISTS product_categories (
    product_id INT,
    category_id INT,
    subcategory_id INT,
    PRIMARY KEY (product_id, category_id, subcategory_id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE,
    FOREIGN KEY (subcategory_id) REFERENCES subcategories(id) ON DELETE CASCADE
);

-- Tabela para avaliações de produtos
CREATE TABLE IF NOT EXISTS product_reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    user_id INT,
    rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Tabela para tags de produtos
CREATE TABLE IF NOT EXISTS product_tags (
    product_id INT,
    tag VARCHAR(255) NOT NULL,
    PRIMARY KEY (product_id, tag),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Inserindo alguns usuários e lojas de exemplo
INSERT INTO users (name, email, password_hash, is_store)
VALUES ('Nadir Maziero', 'atendimento@mazieroemporio.com.br', 'hashed_password', TRUE),
       ('João Silva', 'joao@example.com', 'hashed_password', FALSE);

-- Inserindo lojas associadas aos usuários
INSERT INTO stores (user_id, name, cnpj, logo_url, description)
VALUES (1, 'Maziero Empório', '12345678000195', 'url_logo', 'Loja de exemplo');

-- Inserindo categorias gerais
INSERT INTO categories (name)
VALUES ('Vestuário'),
       ('Alimentação'),
       ('Eletrônicos');

-- Inserindo subcategorias para uma loja específica
INSERT INTO subcategories (category_id, name)
VALUES (1, 'Roupas Femininas'),
       (1, 'Roupas Masculinas'),
       (2, 'Snacks'),
       (2, 'Bebidas'),
       (3, 'Celulares'),
       (3, 'Computadores');

-- Inserindo atributos padrão
INSERT INTO attributes (name, type)
VALUES ('Tamanho', 'select'),
       ('Cor', 'text'),
       ('Preço', 'number');

-- Inserindo valores de atributos
INSERT INTO attribute_values (attribute_id, value)
VALUES (1, 'Pequeno'),
       (1, 'Médio'),
       (1, 'Grande'),
       (2, 'Vermelho'),
       (2, 'Azul'),
       (2, 'Preto');