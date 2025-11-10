-- =========================================================
-- ENUMs
-- =========================================================

CREATE TYPE genero_enum AS ENUM ('MASCULINO', 'FEMININO');
CREATE TYPE situacao_assinatura_enum AS ENUM ('ATIVO', 'INATIVO');
CREATE TYPE situacao_fatura_enum AS ENUM ('PENDENTE', 'PAGA', 'CANCELADA', 'ATRASADA');

-- =========================================================
-- Tabela cliente
-- =========================================================

CREATE TABLE cliente (
    id_cliente TEXT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    genero genero_enum NOT NULL,
    data_nascimento DATE NOT NULL,
    id_referencia_gateway TEXT,
    cpf VARCHAR(14) UNIQUE NOT NULL
);

-- =========================================================
-- Tabela cliente_email
-- =========================================================

CREATE TABLE cliente_email (
    id_email TEXT PRIMARY KEY,
    id_cliente TEXT NOT NULL REFERENCES cliente(id_cliente) ON DELETE CASCADE,
    email VARCHAR(255) NOT NULL UNIQUE
);

-- =========================================================
-- Tabela cliente_telefone
-- =========================================================

CREATE TABLE cliente_telefone (
    id_telefone TEXT PRIMARY KEY,
    id_cliente TEXT NOT NULL REFERENCES cliente(id_cliente) ON DELETE CASCADE,
    numero VARCHAR(20) NOT NULL
);

-- =========================================================
-- Tabela servico
-- =========================================================

CREATE TABLE servico (
    id_servico TEXT PRIMARY KEY,
    nome_servico VARCHAR(100) NOT NULL
);

-- =========================================================
-- Tabela plano
-- =========================================================

CREATE TABLE plano (
    id_plano TEXT PRIMARY KEY,
    id_servico TEXT NOT NULL REFERENCES servico(id_servico),
    nome_plano VARCHAR(100) NOT NULL,
    descricao_plano TEXT,
    valor_plano NUMERIC(10,2) NOT NULL,
    data_hora_criacao TIMESTAMP NOT NULL DEFAULT NOW(),
    data_hora_atualizacao TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =========================================================
-- Tabela permissao
-- =========================================================

CREATE TABLE permissao (
    id_permissao TEXT PRIMARY KEY,
    id_plano TEXT NOT NULL REFERENCES plano(id_plano) ON DELETE CASCADE,
    nome_role VARCHAR(100) NOT NULL
);

-- =========================================================
-- Tabela aceite
-- =========================================================

CREATE TABLE aceite (
    id_aceite TEXT PRIMARY KEY,
    longitude TEXT,
    latitude TEXT,
    ip VARCHAR(50),
    data_hora_aceite TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =========================================================
-- Tabela assinatura
-- =========================================================

CREATE TABLE assinatura (
    id_assinatura TEXT PRIMARY KEY,
    id_aluno TEXT NOT NULL REFERENCES cliente(id_cliente),
    id_servico TEXT NOT NULL REFERENCES servico(id_servico),
    id_plano TEXT NOT NULL REFERENCES plano(id_plano),
    id_aceite TEXT REFERENCES aceite(id_aceite),
    id_referencia_assinatura_gateway TEXT,
    id_referencia_cliente_gateway TEXT,
    situacao_assinatura situacao_assinatura_enum NOT NULL DEFAULT 'ATIVO',
    data_hora_cancelamento TIMESTAMP,
    cancelado BOOLEAN DEFAULT FALSE,
    data_hora_criacao TIMESTAMP NOT NULL DEFAULT NOW(),
    ciclo_cobranca VARCHAR(50),
    data_primeira_cobranca DATE
);

-- =========================================================
-- Tabela fatura_assinatura
-- =========================================================

CREATE TABLE fatura_assinatura (
    id_fatura TEXT PRIMARY KEY,
    id_assinatura TEXT NOT NULL REFERENCES assinatura(id_assinatura) ON DELETE CASCADE,
    valor NUMERIC(10,2) NOT NULL,
    situacao_fatura situacao_fatura_enum NOT NULL DEFAULT 'PENDENTE',
    data_vencimento DATE NOT NULL,
    observacao TEXT
);



INSERT INTO servico (id_servico, nome_servico)
VALUES 
    ('srv_gestao_academia', 'Gestão de Academia'),
    ('srv_gestao_eventos', 'Gestão de Eventos');


INSERT INTO plano (
    id_plano,
    id_servico,
    nome_plano,
    descricao_plano,
    valor_plano,
    data_hora_criacao,
    data_hora_atualizacao
) VALUES
    (
        'plano_academia_free',
        'srv_gestao_academia',
        'Plano Gratuito',
        'Permite cadastrar até 5 alunos',
        0,
        NOW(),
        NOW()
    ),
    (
        'plano_academia_basico',
        'srv_gestao_academia',
        'Plano Básico',
        'Permite cadastrar até 50 alunos',
        35,
        NOW(),
        NOW()
    ),
    (
        'plano_academia_prata',
        'srv_gestao_academia',
        'Plano Prata',
        'Permite cadastrar até 200 alunos',
        75,
        NOW(),
        NOW()
    ),
    (
        'plano_academia_ouro',
        'srv_gestao_academia',
        'Plano Ouro',
        'Permite cadastrar até 1000 alunos',
        135,
        NOW(),
        NOW()
    );
