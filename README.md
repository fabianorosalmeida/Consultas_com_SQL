# 📊 SQL - Conceitos Básicos para Consultas em Bancos de Dados Relacionais

## 🎯 Sobre este Repositório

Este repositório contém conceitos iniciais de **SQL (Structured Query Language)** focados em **consultas em bancos de dados relacionais**. O objetivo é apresentar os comandos fundamentais para manipulação e recuperação de dados utilizando exemplos práticos do **setor bancário**.

> **⚠️ Importante**: Este repositório utiliza **SQLite** como banco de dados de referência. As queries foram testadas no [SQLiteOnline.com](https://sqliteonline.com/) e são 100% compatíveis com SQLite.

## 🏦 Contexto do Projeto

Os exemplos apresentados neste repositório utilizam um cenário bancário com as seguintes entidades:

- **Clientes** - Informações cadastrais dos clientes do banco
- **Contas** - Contas bancárias (corrente, poupança, etc.)
- **Cartões** - Cartões de crédito e débito
- **Transações** - Movimentações financeiras
- **Empréstimos** - Contratos de empréstimos pessoais
- **Seguros** - Produtos de seguro contratados
- **Uso do App** - Registro de acessos ao aplicativo mobile

## 📚 O que você encontrará aqui

Este repositório foca nos **comandos DQL (Data Query Language)** e **DML (Data Manipulation Language)**, essenciais para:

- ✅ Consultar dados (SELECT)
- ✅ Filtrar informações (WHERE)
- ✅ Ordenar resultados (ORDER BY)
- ✅ Agrupar dados (GROUP BY)
- ✅ Combinar tabelas (JOIN)
- ✅ Agregar valores (COUNT, SUM, AVG, MIN, MAX)
- ✅ Inserir registros (INSERT)
- ✅ Atualizar dados (UPDATE)
- ✅ Remover registros (DELETE)

## 🗂️ Estrutura do Repositório

```
├── README.md                 # Este arquivo
└── queries-sql-bancario.sql  # Arquivo com todas as queries organizadas
```

## 🚀 Como Utilizar

### Opção 1: SQLite Online (Recomendado para iniciantes)

1. Acesse [https://sqliteonline.com/](https://sqliteonline.com/)
2. Copie o conteúdo do arquivo `queries-sql-bancario.sql`
3. Cole no editor e execute as queries sequencialmente

### Opção 2: SQLite Local

1. Clone este repositório:
```bash
git clone https://github.com/seu-usuario/sql-conceitos-basicos.git
```

2. Instale o SQLite em seu sistema
3. Execute as queries usando o SQLite CLI ou uma ferramenta como DB Browser for SQLite

### Opção 3: Outras ferramentas

Abra o arquivo `queries-sql-bancario.sql` em ferramentas como:
- DBeaver
- DataGrip
- VSCode com extensão SQLite

## 🔄 SQLite vs MySQL - Principais Diferenças

Este repositório utiliza **SQLite**, que possui algumas diferenças importantes em relação ao **MySQL**:

| Característica | SQLite | MySQL |
|---------------|--------|-------|
| **AUTOINCREMENT** | `INTEGER PRIMARY KEY AUTOINCREMENT` | `INT PRIMARY KEY AUTO_INCREMENT` |
| **Tipos de Dados** | Dinâmicos (5 classes de armazenamento) | Estáticos (ampla variedade) |
| **Servidor** | Serverless (arquivo único) | Cliente-servidor |
| **Tamanho** | ~250 KB | ~600 MB |
| **Concorrência** | Um escritor por vez | Múltiplos usuários simultâneos |
| **Autenticação** | Baseada em permissões de arquivo | Sistema de usuários e privilégios |
| **Uso ideal** | Aplicações móveis, desktop, protótipos | Aplicações web, grandes volumes |

### ⚡ Diferenças Específicas nas Queries

**1. Auto Incremento:**
```sql
-- SQLite
CREATE TABLE exemplo (
    id INTEGER PRIMARY KEY AUTOINCREMENT
);

-- MySQL
CREATE TABLE exemplo (
    id INT PRIMARY KEY AUTO_INCREMENT
);
```

**2. Tipos de Dados:**
```sql
-- SQLite (tipos flexíveis)
CREATE TABLE teste (
    texto TEXT,
    numero INTEGER,
    decimal REAL,
    data TEXT  -- SQLite não tem tipo DATE nativo
);

-- MySQL (tipos específicos)
CREATE TABLE teste (
    texto VARCHAR(100),
    numero INT,
    decimal DECIMAL(10,2),
    data DATE
);
```

**3. Comandos de Data/Hora:**
```sql
-- SQLite
SELECT datetime('now');
SELECT date('now');

-- MySQL
SELECT NOW();
SELECT CURDATE();
```

**4. Limit com Offset:**
```sql
-- SQLite e MySQL (sintaxe idêntica)
SELECT * FROM tabela LIMIT 10 OFFSET 5;

-- MySQL também aceita:
SELECT * FROM tabela LIMIT 5, 10;
```

## 📖 Pré-requisitos

Para executar as queries deste repositório, você precisa ter:

- Conhecimento básico sobre bancos de dados relacionais
- SQLite instalado OU acesso ao SQLite Online
- Editor de código ou ferramenta de gerenciamento de banco de dados (opcional)

**Não é necessário nenhuma configuração de servidor!** SQLite funciona diretamente com arquivos.

## 🎓 Público-Alvo

Este material é ideal para:

- Iniciantes em SQL que desejam aprender os comandos básicos
- Profissionais que trabalham com análise de dados bancários
- Estudantes de Ciência de Dados, Análise de Dados ou áreas relacionadas
- Desenvolvedores que precisam consultar bancos de dados relacionais
- Quem quer testar queries SQL rapidamente sem configurar um servidor

## ⚠️ Importante

As queries apresentadas utilizam **dados fictícios** para fins didáticos. Nenhuma informação real de clientes ou instituições financeiras é utilizada neste repositório.

## 💡 Dicas de Uso

1. **Execute as queries em ordem**: As seções foram organizadas do básico ao avançado
2. **Experimente modificar os valores**: Altere as queries para testar diferentes cenários
3. **Leia os comentários**: Cada query possui explicações detalhadas
4. **Teste no SQLite Online**: Não requer instalação e funciona direto no navegador

## 🔧 Solução de Problemas

**Erro com AUTOINCREMENT:**
- Certifique-se de usar `INTEGER PRIMARY KEY AUTOINCREMENT` (não `INT AUTO_INCREMENT`)

**Erro com tipos de dados:**
- SQLite é flexível com tipos, mas prefira usar: TEXT, INTEGER, REAL, BLOB

**Erro com datas:**
- SQLite armazena datas como TEXT, use funções como `date()`, `datetime()`

## 📝 Licença

Este projeto está sob a licença MIT. Sinta-se livre para utilizá-lo para estudos e aprendizado.

## 🤝 Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests com melhorias.

## 🔗 Links Úteis

- [SQLite Online](https://sqliteonline.com/) - Execute SQL diretamente no navegador
- [Documentação SQLite](https://www.sqlite.org/docs.html) - Documentação oficial
- [DB Browser for SQLite](https://sqlitebrowser.org/) - Interface gráfica para SQLite
- [SQLite Tutorial](https://www.sqlitetutorial.net/) - Tutorial completo de SQLite

---

**Bons estudos!** 📚✨
