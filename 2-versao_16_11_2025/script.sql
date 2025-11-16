SET search_path TO clientes;

ALTER TABLE cliente
ADD COLUMN id_usuario_keycloak TEXT NOT NULL;