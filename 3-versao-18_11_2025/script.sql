ALTER TABLE clientes.assinatura
RENAME COLUMN id_aluno TO id_cliente;

alter table permissao 
drop column nome_role;

alter table permissao 
add column nome_role text not null;

alter table permissao
add column client_id_keycloak text not null
