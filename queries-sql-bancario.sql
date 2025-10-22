-- ========================================
-- QUERIES SQL - CONTEXTO BANCÁRIO
-- Conceitos Básicos para Consultas em Bancos de Dados Relacionais
-- Compatível com SQLite (testado em SQLiteOnline.com)
-- ========================================

-- ========================================
-- 1. CRIAÇÃO DE TABELAS (DDL)
-- ========================================

-- Tabela: clientes
CREATE TABLE clientes (
    cliente_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome_completo TEXT NOT NULL,
    cpf TEXT UNIQUE NOT NULL,
    data_nascimento TEXT,
    email TEXT,
    telefone TEXT,
    data_cadastro TEXT DEFAULT (datetime('now'))
);

-- Tabela: contas
CREATE TABLE contas (
    conta_id INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id INTEGER,
    tipo_conta TEXT NOT NULL, -- 'Corrente', 'Poupança', 'Salário'
    saldo REAL DEFAULT 0.00,
    data_abertura TEXT NOT NULL,
    status_conta TEXT DEFAULT 'Ativa', -- 'Ativa', 'Bloqueada', 'Encerrada'
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

-- Tabela: cartoes
CREATE TABLE cartoes (
    cartao_id INTEGER PRIMARY KEY AUTOINCREMENT,
    conta_id INTEGER,
    numero_cartao TEXT UNIQUE NOT NULL,
    tipo_cartao TEXT NOT NULL, -- 'Débito', 'Crédito', 'Múltiplo'
    limite_credito REAL,
    data_vencimento TEXT,
    status_cartao TEXT DEFAULT 'Ativo', -- 'Ativo', 'Bloqueado', 'Cancelado'
    FOREIGN KEY (conta_id) REFERENCES contas(conta_id)
);

-- Tabela: transacoes
CREATE TABLE transacoes (
    transacao_id INTEGER PRIMARY KEY AUTOINCREMENT,
    conta_id INTEGER,
    tipo_transacao TEXT NOT NULL, -- 'Depósito', 'Saque', 'Transferência', 'Pagamento'
    valor REAL NOT NULL,
    data_transacao TEXT DEFAULT (datetime('now')),
    descricao TEXT,
    FOREIGN KEY (conta_id) REFERENCES contas(conta_id)
);

-- Tabela: emprestimos
CREATE TABLE emprestimos (
    emprestimo_id INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id INTEGER,
    valor_emprestimo REAL NOT NULL,
    taxa_juros REAL NOT NULL,
    prazo_meses INTEGER NOT NULL,
    data_contratacao TEXT NOT NULL,
    status_emprestimo TEXT DEFAULT 'Em andamento', -- 'Em andamento', 'Quitado', 'Inadimplente'
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

-- Tabela: seguros
CREATE TABLE seguros (
    seguro_id INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id INTEGER,
    tipo_seguro TEXT NOT NULL, -- 'Vida', 'Residencial', 'Automóvel', 'Saúde'
    valor_cobertura REAL NOT NULL,
    premio_mensal REAL NOT NULL,
    data_contratacao TEXT NOT NULL,
    status_seguro TEXT DEFAULT 'Ativo', -- 'Ativo', 'Cancelado', 'Suspenso'
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

-- Tabela: uso_app
CREATE TABLE uso_app (
    registro_id INTEGER PRIMARY KEY AUTOINCREMENT,
    cliente_id INTEGER,
    data_acesso TEXT DEFAULT (datetime('now')),
    tipo_operacao TEXT, -- 'Consulta Saldo', 'Transferência', 'Pagamento', 'Investimento'
    duracao_sessao INTEGER, -- em segundos
    dispositivo TEXT, -- 'Android', 'iOS', 'Web'
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);


-- ========================================
-- 2. INSERÇÃO DE DADOS (DML - INSERT)
-- ========================================

-- Inserir clientes
INSERT INTO clientes (nome_completo, cpf, data_nascimento, email, telefone)
VALUES 
    ('Ana Paula Silva', '12345678901', '1985-03-15', 'ana.silva@email.com', '11987654321'),
    ('Carlos Eduardo Santos', '23456789012', '1990-07-22', 'carlos.santos@email.com', '11976543210'),
    ('Marina Costa Oliveira', '34567890123', '1988-11-30', 'marina.oliveira@email.com', '11965432109'),
    ('Pedro Henrique Almeida', '45678901234', '1995-01-10', 'pedro.almeida@email.com', '11954321098'),
    ('Juliana Ferreira Lima', '56789012345', '1992-05-18', 'juliana.lima@email.com', '11943210987');

-- Inserir contas
INSERT INTO contas (cliente_id, tipo_conta, saldo, data_abertura, status_conta)
VALUES 
    (1, 'Corrente', 5500.00, '2020-01-15', 'Ativa'),
    (2, 'Poupança', 12000.00, '2019-05-20', 'Ativa'),
    (3, 'Corrente', 8750.50, '2021-03-10', 'Ativa'),
    (4, 'Salário', 3200.00, '2022-07-01', 'Ativa'),
    (5, 'Corrente', 15000.00, '2018-11-25', 'Ativa');

-- Inserir cartões
INSERT INTO cartoes (conta_id, numero_cartao, tipo_cartao, limite_credito, data_vencimento, status_cartao)
VALUES 
    (1, '4532123456789012', 'Crédito', 8000.00, '2026-12-31', 'Ativo'),
    (2, '5412987654321098', 'Débito', NULL, '2027-06-30', 'Ativo'),
    (3, '4716543210987654', 'Múltiplo', 15000.00, '2026-09-30', 'Ativo'),
    (4, '5512876543219876', 'Débito', NULL, '2028-03-31', 'Ativo'),
    (5, '4929765432108765', 'Crédito', 20000.00, '2027-11-30', 'Ativo');

-- Inserir transações
INSERT INTO transacoes (conta_id, tipo_transacao, valor, data_transacao, descricao)
VALUES 
    (1, 'Depósito', 2000.00, '2024-10-01 09:30:00', 'Depósito via transferência'),
    (1, 'Saque', 500.00, '2024-10-05 14:20:00', 'Saque em caixa eletrônico'),
    (2, 'Transferência', 1500.00, '2024-10-07 11:45:00', 'Transferência para conta 3'),
    (3, 'Pagamento', 350.00, '2024-10-10 16:10:00', 'Pagamento de conta de luz'),
    (4, 'Depósito', 3200.00, '2024-10-12 08:00:00', 'Salário mensal'),
    (5, 'Transferência', 5000.00, '2024-10-14 10:30:00', 'Transferência externa');

-- Inserir empréstimos
INSERT INTO emprestimos (cliente_id, valor_emprestimo, taxa_juros, prazo_meses, data_contratacao, status_emprestimo)
VALUES 
    (1, 25000.00, 1.99, 24, '2023-06-15', 'Em andamento'),
    (2, 50000.00, 2.50, 36, '2022-08-20', 'Em andamento'),
    (3, 15000.00, 1.75, 12, '2024-01-10', 'Em andamento'),
    (4, 10000.00, 2.20, 18, '2024-05-05', 'Em andamento'),
    (5, 80000.00, 1.50, 48, '2021-11-30', 'Quitado');

-- Inserir seguros
INSERT INTO seguros (cliente_id, tipo_seguro, valor_cobertura, premio_mensal, data_contratacao, status_seguro)
VALUES 
    (1, 'Vida', 200000.00, 150.00, '2020-03-01', 'Ativo'),
    (2, 'Residencial', 500000.00, 280.00, '2019-07-15', 'Ativo'),
    (3, 'Automóvel', 80000.00, 320.00, '2021-05-20', 'Ativo'),
    (4, 'Saúde', 150000.00, 450.00, '2022-09-10', 'Ativo'),
    (5, 'Vida', 300000.00, 200.00, '2018-12-05', 'Ativo');

-- Inserir registros de uso do app
INSERT INTO uso_app (cliente_id, data_acesso, tipo_operacao, duracao_sessao, dispositivo)
VALUES 
    (1, '2024-10-15 08:30:00', 'Consulta Saldo', 45, 'Android'),
    (2, '2024-10-15 09:15:00', 'Transferência', 120, 'iOS'),
    (3, '2024-10-15 10:00:00', 'Pagamento', 90, 'Web'),
    (4, '2024-10-15 11:30:00', 'Investimento', 180, 'Android'),
    (5, '2024-10-15 14:20:00', 'Consulta Saldo', 30, 'iOS');


-- ========================================
-- 3. CONSULTAS BÁSICAS (SELECT)
-- ========================================

-- 3.1. Selecionar todos os registros de uma tabela
SELECT * FROM clientes;

-- 3.2. Selecionar colunas específicas
SELECT nome_completo, email, telefone FROM clientes;

-- 3.3. Selecionar dados com alias (apelidos para colunas)
SELECT 
    nome_completo AS 'Nome do Cliente',
    email AS 'E-mail',
    telefone AS 'Telefone'
FROM clientes;


-- ========================================
-- 4. FILTROS COM WHERE
-- ========================================

-- 4.1. Filtrar por valor exato
SELECT * FROM contas WHERE tipo_conta = 'Corrente';

-- 4.2. Filtrar por valor numérico (maior que)
SELECT * FROM contas WHERE saldo > 10000.00;

-- 4.3. Filtrar por intervalo de valores (BETWEEN)
SELECT * FROM emprestimos 
WHERE valor_emprestimo BETWEEN 20000.00 AND 60000.00;

-- 4.4. Filtrar por lista de valores (IN)
SELECT * FROM seguros 
WHERE tipo_seguro IN ('Vida', 'Saúde');

-- 4.5. Filtrar por padrão de texto (LIKE)
SELECT * FROM clientes 
WHERE nome_completo LIKE '%Silva%';

-- 4.6. Filtrar registros nulos
SELECT * FROM cartoes WHERE limite_credito IS NULL;

-- 4.7. Filtrar registros não nulos
SELECT * FROM cartoes WHERE limite_credito IS NOT NULL;

-- 4.8. Combinar múltiplas condições com AND
SELECT * FROM contas 
WHERE tipo_conta = 'Corrente' AND saldo > 5000.00;

-- 4.9. Combinar múltiplas condições com OR
SELECT * FROM contas 
WHERE tipo_conta = 'Corrente' OR tipo_conta = 'Poupança';

-- 4.10. Filtrar por data
SELECT * FROM transacoes 
WHERE data_transacao >= '2024-10-01';


-- ========================================
-- 5. ORDENAÇÃO DE RESULTADOS (ORDER BY)
-- ========================================

-- 5.1. Ordenar em ordem crescente (ASC)
SELECT * FROM clientes ORDER BY nome_completo ASC;

-- 5.2. Ordenar em ordem decrescente (DESC)
SELECT * FROM contas ORDER BY saldo DESC;

-- 5.3. Ordenar por múltiplas colunas
SELECT * FROM emprestimos 
ORDER BY status_emprestimo ASC, valor_emprestimo DESC;


-- ========================================
-- 6. LIMITAÇÃO DE RESULTADOS (LIMIT)
-- ========================================

-- 6.1. Limitar número de registros retornados
SELECT * FROM clientes LIMIT 3;

-- 6.2. Limitar com deslocamento (OFFSET)
SELECT * FROM clientes LIMIT 3 OFFSET 2;


-- ========================================
-- 7. FUNÇÕES DE AGREGAÇÃO
-- ========================================

-- 7.1. Contar registros (COUNT)
SELECT COUNT(*) AS 'Total de Clientes' FROM clientes;

-- 7.2. Somar valores (SUM)
SELECT SUM(saldo) AS 'Saldo Total de Todas as Contas' FROM contas;

-- 7.3. Calcular média (AVG)
SELECT AVG(saldo) AS 'Saldo Médio das Contas' FROM contas;

-- 7.4. Encontrar valor mínimo (MIN)
SELECT MIN(valor_emprestimo) AS 'Menor Empréstimo' FROM emprestimos;

-- 7.5. Encontrar valor máximo (MAX)
SELECT MAX(limite_credito) AS 'Maior Limite de Crédito' FROM cartoes;


-- ========================================
-- 8. AGRUPAMENTO DE DADOS (GROUP BY)
-- ========================================

-- 8.1. Agrupar por tipo de conta e contar
SELECT 
    tipo_conta,
    COUNT(*) AS 'Quantidade de Contas'
FROM contas
GROUP BY tipo_conta;

-- 8.2. Agrupar e calcular soma
SELECT 
    tipo_conta,
    SUM(saldo) AS 'Saldo Total por Tipo'
FROM contas
GROUP BY tipo_conta;

-- 8.3. Agrupar por tipo de transação e calcular total
SELECT 
    tipo_transacao,
    COUNT(*) AS 'Quantidade',
    SUM(valor) AS 'Valor Total'
FROM transacoes
GROUP BY tipo_transacao;

-- 8.4. Agrupar com filtro HAVING (filtra grupos)
SELECT 
    tipo_conta,
    AVG(saldo) AS 'Saldo Médio'
FROM contas
GROUP BY tipo_conta
HAVING AVG(saldo) > 5000.00;


-- ========================================
-- 9. JUNÇÕES DE TABELAS (JOIN)
-- ========================================

-- 9.1. INNER JOIN - Clientes com suas contas
SELECT 
    c.nome_completo,
    c.cpf,
    co.tipo_conta,
    co.saldo
FROM clientes c
INNER JOIN contas co ON c.cliente_id = co.cliente_id;

-- 9.2. INNER JOIN - Contas com cartões
SELECT 
    co.conta_id,
    co.tipo_conta,
    ca.tipo_cartao,
    ca.limite_credito
FROM contas co
INNER JOIN cartoes ca ON co.conta_id = ca.conta_id;

-- 9.3. INNER JOIN com múltiplas tabelas - Clientes, contas e transações
SELECT 
    c.nome_completo,
    co.tipo_conta,
    t.tipo_transacao,
    t.valor,
    t.data_transacao
FROM clientes c
INNER JOIN contas co ON c.cliente_id = co.cliente_id
INNER JOIN transacoes t ON co.conta_id = t.conta_id;

-- 9.4. LEFT JOIN - Todos os clientes e seus empréstimos (se houver)
SELECT 
    c.nome_completo,
    e.valor_emprestimo,
    e.status_emprestimo
FROM clientes c
LEFT JOIN emprestimos e ON c.cliente_id = e.cliente_id;

-- 9.5. INNER JOIN - Clientes com seguros ativos
SELECT 
    c.nome_completo,
    s.tipo_seguro,
    s.valor_cobertura,
    s.premio_mensal
FROM clientes c
INNER JOIN seguros s ON c.cliente_id = s.cliente_id
WHERE s.status_seguro = 'Ativo';


-- ========================================
-- 10. SUBCONSULTAS (SUBQUERIES)
-- ========================================

-- 10.1. Subconsulta no WHERE - Contas com saldo acima da média
SELECT * FROM contas
WHERE saldo > (SELECT AVG(saldo) FROM contas);

-- 10.2. Subconsulta no FROM - Clientes com empréstimos ativos
SELECT 
    c.nome_completo,
    c.email
FROM clientes c
WHERE c.cliente_id IN (
    SELECT cliente_id 
    FROM emprestimos 
    WHERE status_emprestimo = 'Em andamento'
);

-- 10.3. Subconsulta correlacionada - Clientes com mais de uma conta
SELECT 
    c.nome_completo,
    (SELECT COUNT(*) FROM contas WHERE cliente_id = c.cliente_id) AS 'Quantidade de Contas'
FROM clientes c;


-- ========================================
-- 11. ATUALIZAÇÃO DE DADOS (UPDATE)
-- ========================================

-- 11.1. Atualizar um registro específico
UPDATE contas 
SET saldo = 6000.00 
WHERE conta_id = 1;

-- 11.2. Atualizar múltiplos campos
UPDATE cartoes 
SET status_cartao = 'Bloqueado', limite_credito = 0 
WHERE cartao_id = 2;

-- 11.3. Atualizar com base em condição
UPDATE emprestimos 
SET status_emprestimo = 'Quitado' 
WHERE emprestimo_id = 3 AND valor_emprestimo < 20000.00;

-- 11.4. Atualizar com cálculo
UPDATE contas 
SET saldo = saldo + 1000.00 
WHERE tipo_conta = 'Poupança';


-- ========================================
-- 12. EXCLUSÃO DE DADOS (DELETE)
-- ========================================

-- 12.1. Deletar um registro específico
DELETE FROM transacoes WHERE transacao_id = 1;

-- 12.2. Deletar com base em condição
DELETE FROM uso_app WHERE data_acesso < '2024-01-01';

-- 12.3. Deletar múltiplos registros
DELETE FROM transacoes 
WHERE tipo_transacao = 'Saque' AND valor < 100.00;


-- ========================================
-- 13. CONSULTAS AVANÇADAS
-- ========================================

-- 13.1. CASE - Classificar clientes por faixa de saldo
SELECT 
    c.nome_completo,
    co.saldo,
    CASE 
        WHEN co.saldo < 5000 THEN 'Saldo Baixo'
        WHEN co.saldo BETWEEN 5000 AND 10000 THEN 'Saldo Médio'
        ELSE 'Saldo Alto'
    END AS 'Classificação'
FROM clientes c
INNER JOIN contas co ON c.cliente_id = co.cliente_id;

-- 13.2. DISTINCT - Tipos únicos de transações
SELECT DISTINCT tipo_transacao FROM transacoes;

-- 13.3. UNION - Combinar resultados de múltiplas consultas
SELECT nome_completo AS 'Nome', 'Cliente' AS 'Tipo' FROM clientes
UNION
SELECT tipo_seguro AS 'Nome', 'Seguro' AS 'Tipo' FROM seguros;

-- 13.4. Funções de data (SQLite)
SELECT 
    cliente_id,
    data_acesso,
    date(data_acesso) AS 'Data',
    time(data_acesso) AS 'Hora',
    strftime('%Y', data_acesso) AS 'Ano',
    strftime('%m', data_acesso) AS 'Mês',
    strftime('%d', data_acesso) AS 'Dia'
FROM uso_app;

-- 13.5. Concatenação de strings (SQLite usa ||)
SELECT 
    nome_completo || ' - CPF: ' || cpf AS 'Cliente Completo'
FROM clientes;

-- 13.6. Conversão de tipos de dados (CAST)
SELECT 
    valor_emprestimo,
    CAST(taxa_juros AS TEXT) AS 'Taxa como Texto'
FROM emprestimos;


-- ========================================
-- 14. ÍNDICES E PERFORMANCE
-- ========================================

-- 14.1. Criar índice em coluna frequentemente consultada
CREATE INDEX idx_cpf ON clientes(cpf);

-- 14.2. Criar índice composto
CREATE INDEX idx_conta_data ON transacoes(conta_id, data_transacao);

-- 14.3. Listar índices (SQLite)
SELECT name FROM sqlite_master WHERE type = 'index';

-- 14.4. Remover índice
DROP INDEX IF EXISTS idx_cpf;


-- ========================================
-- 15. VIEWS (VISÕES)
-- ========================================

-- 15.1. Criar view - Resumo de contas por cliente
CREATE VIEW vw_resumo_contas AS
SELECT 
    c.cliente_id,
    c.nome_completo,
    COUNT(co.conta_id) AS 'Total de Contas',
    SUM(co.saldo) AS 'Saldo Total'
FROM clientes c
LEFT JOIN contas co ON c.cliente_id = co.cliente_id
GROUP BY c.cliente_id, c.nome_completo;

-- 15.2. Consultar view criada
SELECT * FROM vw_resumo_contas;

-- 15.3. Criar view - Cartões por tipo
CREATE VIEW vw_cartoes_tipo AS
SELECT 
    tipo_cartao,
    COUNT(*) AS 'Quantidade',
    AVG(limite_credito) AS 'Limite Médio'
FROM cartoes
WHERE limite_credito IS NOT NULL
GROUP BY tipo_cartao;

-- 15.4. Consultar view de cartões
SELECT * FROM vw_cartoes_tipo;

-- 15.5. Remover view
DROP VIEW IF EXISTS vw_resumo_contas;


-- ========================================
-- 16. CONSULTAS ESTATÍSTICAS E ANALÍTICAS
-- ========================================

-- 16.1. Total de clientes por faixa etária (usando strftime para calcular idade)
SELECT 
    CASE 
        WHEN CAST((julianday('now') - julianday(data_nascimento)) / 365.25 AS INTEGER) < 30 THEN 'Menor de 30'
        WHEN CAST((julianday('now') - julianday(data_nascimento)) / 365.25 AS INTEGER) BETWEEN 30 AND 45 THEN '30-45 anos'
        ELSE 'Acima de 45'
    END AS 'Faixa Etária',
    COUNT(*) AS 'Total'
FROM clientes
GROUP BY 
    CASE 
        WHEN CAST((julianday('now') - julianday(data_nascimento)) / 365.25 AS INTEGER) < 30 THEN 'Menor de 30'
        WHEN CAST((julianday('now') - julianday(data_nascimento)) / 365.25 AS INTEGER) BETWEEN 30 AND 45 THEN '30-45 anos'
        ELSE 'Acima de 45'
    END;

-- 16.2. Ranking de contas por saldo (usando LIMIT)
SELECT 
    c.nome_completo,
    co.tipo_conta,
    co.saldo
FROM clientes c
INNER JOIN contas co ON c.cliente_id = co.cliente_id
ORDER BY co.saldo DESC
LIMIT 5;

-- 16.3. Análise de uso do app por dispositivo
SELECT 
    dispositivo,
    COUNT(*) AS 'Total de Acessos',
    AVG(duracao_sessao) AS 'Duração Média (seg)',
    SUM(duracao_sessao) AS 'Tempo Total (seg)'
FROM uso_app
GROUP BY dispositivo
ORDER BY COUNT(*) DESC;

-- 16.4. Clientes com produtos múltiplos (conta + cartão + seguro)
SELECT 
    c.nome_completo,
    COUNT(DISTINCT co.conta_id) AS 'Contas',
    COUNT(DISTINCT ca.cartao_id) AS 'Cartões',
    COUNT(DISTINCT s.seguro_id) AS 'Seguros'
FROM clientes c
LEFT JOIN contas co ON c.cliente_id = co.cliente_id
LEFT JOIN cartoes ca ON co.conta_id = ca.conta_id
LEFT JOIN seguros s ON c.cliente_id = s.cliente_id
GROUP BY c.cliente_id, c.nome_completo;


-- ========================================
-- 17. LIMPEZA E MANUTENÇÃO
-- ========================================

-- 17.1. Visualizar estrutura de uma tabela
PRAGMA table_info(clientes);

-- 17.2. Listar todas as tabelas do banco
SELECT name FROM sqlite_master WHERE type='table';

-- 17.3. Verificar tamanho do banco (retorna número de páginas)
PRAGMA page_count;

-- 17.4. Otimizar banco de dados
VACUUM;


-- ========================================
-- FIM DO ARQUIVO
-- ========================================

-- OBSERVAÇÕES IMPORTANTES SOBRE SQLITE:
-- 1. SQLite usa INTEGER PRIMARY KEY AUTOINCREMENT (não AUTO_INCREMENT)
-- 2. Tipos de dados são flexíveis: TEXT, INTEGER, REAL, BLOB, NULL
-- 3. Datas são armazenadas como TEXT (formato: 'YYYY-MM-DD' ou 'YYYY-MM-DD HH:MM:SS')
-- 4. Para concatenar strings use || (não CONCAT)
-- 5. Funções de data: date(), time(), datetime(), strftime()
-- 6. SQLite é case-insensitive para SQL, mas case-sensitive para dados
-- 7. Foreign keys precisam ser habilitadas: PRAGMA foreign_keys = ON;
