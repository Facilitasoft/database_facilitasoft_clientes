ALTER TABLE clientes.assinatura
RENAME COLUMN id_aluno TO id_cliente;

alter table permissao 
drop column nome_role;

alter table permissao 
add column nome_role text not null;

alter table permissao
add column client_id_keycloak text not null

INSERT INTO clientes.permissao (id_permissao, id_plano, nome_role, client_id_keycloak)
VALUES
	('1', 'plano_academia_free',   'gestao_academia:free',   'web--gestao-academia'),
	('2', 'plano_academia_basico', 'gestao_academia:basico', 'web--gestao-academia'),
	('3', 'plano_academia_prata',  'gestao_academia:prata',  'web--gestao-academia'),
	('4', 'plano_academia_ouro',   'gestao_academia:ouro',   'web--gestao-academia');

ALTER TABLE clientes.fatura_assinatura
ADD COLUMN id_referencia_cobranca_gateway TEXT NOT NULL;

