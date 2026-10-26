BEGIN;
CREATE TABLE IF NOT EXISTS clientes (
 id UUID PRIMARY KEY, nome TEXT NOT NULL, documento TEXT NOT NULL UNIQUE,
 email TEXT, telefone TEXT, ativo BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE TABLE IF NOT EXISTS enderecos (
 id UUID PRIMARY KEY, cliente_id UUID NOT NULL REFERENCES clientes(id),
 logradouro TEXT NOT NULL, numero TEXT NOT NULL, complemento TEXT,
 bairro TEXT NOT NULL, cidade TEXT NOT NULL, uf CHAR(2) NOT NULL, cep TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS enderecos_cliente_idx ON enderecos(cliente_id);
COMMIT;
