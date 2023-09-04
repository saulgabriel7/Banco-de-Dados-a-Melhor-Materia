USE aula_db_exemplos;

INSERT INTO autores (nome, nascimento) VALUES 
('J.K. Rowling', '1965-07-31'),
('George Orwell', '1903-06-25'),
('J.R.R. Tolkien', '1892-01-03'),
('Jane Austen', '1775-12-16'),
('Agatha Christie', '1890-09-15'),
('F. Scott Fitzgerald', '1896-09-24');


INSERT INTO livros (titulo, autor_id) VALUES
('Harry Potter e a Pedra Filosofal', 1),
('Harry Potter e a Câmara Secreta', 1),
('1984', 2),
('O Senhor dos Anéis', 3),
('Orgulho e Preconceito', 4),
('Morte no Nilo', 5),
('O Grande Gatsby', 6),
('O Misterioso Caso de Styles', 5),
('Razão e Sensibilidade', 4);


INSERT INTO alunos (nome) VALUES 
('João'),
('Maria'),
('Pedro'),
('Ana'),
('Beatriz'),
('Lucas'),
('Fernanda'),
('Eduardo'),
('Luisa'),
('Roberto');

INSERT INTO matriculas (aluno_id, curso) VALUES
(1, 'Engenharia de Software'),
(2, 'Medicina'),
(3, 'Engenharia de Software'),
(3, 'Arquitetura'),
(5, 'Física'),
(6, 'História'),
(7, 'Psicologia'),
(8, 'Engenharia Civil'),
(9, 'Artes'),
(10, 'Engenharia de Software'),
(10, 'Economia');

INSERT INTO vendas (produto, receita) VALUES 
('Produto A', 5000.00),
('Produto B', 15000.00),
('Produto C', 8000.00),
('Produto A', 6000.00),
('Produto B', 17000.00),
('Produto C', 3000.00),
('Produto D', 10000.00),
('Produto E', 6500.00),
('Produto F', 8500.00),
('Produto A', 7000.00),
('Produto B', 12000.00),
('Produto E', 4000.00),
('Produto C', 11000.00),
('Produto D', 5000.00);

CREATE DATABASE aula_db_exemplos;
USE aula_db_exemplos;

CREATE TABLE vendas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    produto VARCHAR(255) NOT NULL,
    receita DECIMAL(10, 2) NOT NULL
);

CREATE TABLE autores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    nascimento DATE
);

CREATE TABLE livros (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    autor_id INT,
    FOREIGN KEY (autor_id) REFERENCES autores(id)
);

CREATE TABLE alunos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE matriculas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_id INT,
    curso VARCHAR(255) NOT NULL,
    FOREIGN KEY (aluno_id) REFERENCES alunos(id)
);


/*1-Selecione todos os títulos de livros na tabela livros.  */     

SELECT livros.titulo, autores.nome AS autor 
FROM livros
JOIN autores ON livros.autor_id = autores.id;

/* 2-Selecione todos os nomes de autores nascidos antes de 1900. */

SELECT nome
FROM autores
WHERE YEAR(nascimento) < 1900;

/* 3-Liste todos os livros escritos por 'J.K. Rowling'. */     

SELECT livros.titulo
FROM livros
INNER JOIN autores ON livros.autor_id = autores.id
WHERE autores.nome = 'J.K. Rowling';

/* 4-Encontre todos os alunos matriculados em 'Engenharia de Software'. */

SELECT alunos.nome
FROM aula_db_exemplos.alunos
INNER JOIN aula_db_exemplos.matriculas ON alunos.id = matriculas.aluno_id
WHERE matriculas.curso = 'Engenharia de Software';

/*5-Calcule a receita total gerada por cada produto. */

SELECT produto, SUM(receita) AS receita_total
FROM vendas
GROUP BY produto
ORDER BY receita_total DESC;

/* 6-Determine o número total de livros por autor. */

SELECT autores.nome AS autor, COUNT(livros.id) AS total_de_livros
FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id
GROUP BY autores.nome
ORDER BY autor;
