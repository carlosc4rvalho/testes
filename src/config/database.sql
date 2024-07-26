-- Verifica se o banco de dados já existe e cria-o se não existir
CREATE DATABASE IF NOT EXISTS emporio_maziero;
-- Seleciona o banco de dados para uso
USE emporio_maziero;
-- Tabela de usuários com acesso ao sistema
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL
);
-- Tabelas principais para categorias, tipos, países, uvas, regiões e harmonizações
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT
);
CREATE TABLE IF NOT EXISTS types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS countries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS grapes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS regions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS pairings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);
-- Tabela para armazenar informações dos produtos
CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    promotional_price DECIMAL(10, 2),
    is_active BOOLEAN DEFAULT TRUE,
    deleted_at DATETIME NULL -- Coluna para soft delete
);
-- Tabela para armazenar imagens dos produtos
CREATE TABLE IF NOT EXISTS product_images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    image_url VARCHAR(255) NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    deleted_at DATETIME NULL,
    -- Coluna para soft delete
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
-- Tabelas de junção para associar produtos com categorias, tipos, países, uvas e regiões e harmonizações
CREATE TABLE IF NOT EXISTS product_categories (
    product_id INT,
    category_id INT,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS product_types (
    product_id INT,
    type_id INT,
    PRIMARY KEY (product_id, type_id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (type_id) REFERENCES types(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS product_countries (
    product_id INT,
    country_id INT,
    PRIMARY KEY (product_id, country_id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS product_grapes (
    product_id INT,
    grape_id INT,
    PRIMARY KEY (product_id, grape_id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (grape_id) REFERENCES grapes(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS product_regions (
    product_id INT,
    region_id INT,
    PRIMARY KEY (product_id, region_id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (region_id) REFERENCES regions(id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS product_pairings (
    product_id INT,
    pairing_id INT,
    PRIMARY KEY (product_id, pairing_id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (pairing_id) REFERENCES pairings(id) ON DELETE CASCADE
);
-- Inserindo categorias
INSERT INTO categories (name)
VALUES ('Vinhos'),
    ('Cervejas'),
    ('Kits'),
    ('Chocolates'),
    ('Queijos');
-- Inserindo tipos
INSERT INTO types (name)
VALUES ('Vinho tinto'),
    ('Vinho rosé'),
    ('Vinho branco'),
    ('Espumante Branco');
-- Inserindo países
INSERT INTO countries (name)
VALUES ('Argentina'),
    ('Chile'),
    ('Espanha'),
    ('Itália'),
    ('Portugal'),
    ('Europeu'),
    ('Brasil'),
    ('França'),
    ('China'),
    ('Uruguai');
-- Inserindo uvas
INSERT INTO grapes (name)
VALUES ('Tempranillo'),
    ('Grenache'),
    ('Merlot'),
    ('Sangiovese'),
    ('Carignan'),
    ('Pinot Noir'),
    ('Canaiolo'),
    ('Cabernet Sauvignon'),
    ('Petit Verdot'),
    ('Malbec'),
    ('Touriga Nacional'),
    ('Alicante Bouschet'),
    ('Primitivo'),
    ('Touriga Franca'),
    ('Tinta Roriz'),
    ('Carménère'),
    ('Syrah'),
    ('Chardonnay'),
    ('Bobal'),
    ('Monastrell'),
    ('Castelão'),
    ('Garnacha'),
    ('Aragonez'),
    ('Tannat'),
    ('Corvina'),
    ('Rondinella'),
    ('Cabernet Franc'),
    ('Trincadeira'),
    ('Barbera'),
    ('Dolcetto'),
    ('Freisa'),
    ('Ciliegiolo'),
    ('Montepulciano'),
    ('Bonarda'),
    ('Corvinone'),
    ('Albarossa'),
    ('Alfrocheiro'),
    ('Refosco'),
    ('Raboso Veronese'),
    ('Negrara'),
    ('Jaén'),
    ('Rossignola-Negrara'),
    ('Siria'),
    ('Fonte da Cal'),
    ('Blend');
-- Inserindo regiões
INSERT INTO regions (name)
VALUES ('Abruzzo'),
    ('Alentejo'),
    ('Alicante'),
    ('Argentina'),
    ('Atlantique'),
    ('Bordeaux'),
    ('Campanha Gaúcha'),
    ('Canelones'),
    ('Cariñena'),
    ('Castilha-La Mancha'),
    ('Castilla-La Mancha'),
    ('Dão'),
    ('Emilia-Romagna'),
    ('Extremadura'),
    ('Friuli-Venezia Giulia'),
    ('Lisboa'),
    ('Mendonza'),
    ('Mendoza'),
    ('Multirregional'),
    ('Piemonte'),
    ('Puglia'),
    ('Rioja'),
    ('Sicília'),
    ('Tejo'),
    ('Toro'),
    ('Toscana'),
    ('Utiel-Requena'),
    ('Valdepeñas'),
    ('Vale do Rhône'),
    ('Valencia'),
    ('Valle Central'),
    ('Valle de Curicó'),
    ('Valle de Maule'),
    ('Valle de Rapel'),
    ('Valle del Loncomilla'),
    ('Valle del Maipo'),
    ('Vêneto');
-- Inserindo harmonizações
INSERT INTO pairings (name)
VALUES ('Pizzas e massas'),
    ('Carnes vermelhas'),
    ('Queijos'),
    ('Saladas e aperitivos'),
    ('Carnes brancas'),
    ('Frutos do mar'),
    ('Carnes de caça'),
    ('Risoto e massas de molho'),
    ('Pratos apimentados'),
    ('Sobremesas');
-- Inserindo um usuário administrador
INSERT INTO users (name, email, password_hash)
VALUES (
        'Nadir Maziero',
        'atendimento@mazieroemporio.com.br',
        'hashed_password'
    );
-- NOTA: Tenho que criar uma regra de negocio para os cupons de desconto acho dá para aplicar a produtos específicos usando filtros ou em todos os produtos e tenho q colocar um tempo para isso tbm quando começar e quando terminar