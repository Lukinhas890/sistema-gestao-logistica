BEGIN;
CREATE TABLE IF NOT EXISTS produtos (
 id UUID PRIMARY KEY, nome TEXT NOT NULL, sku TEXT NOT NULL UNIQUE,
 preco NUMERIC(14,2) NOT NULL CHECK (preco >= 0), ativo BOOLEAN NOT NULL DEFAULT TRUE
);
CREATE TABLE IF NOT EXISTS estoque (
 produto_id UUID PRIMARY KEY REFERENCES produtos(id),
 quantidade_total INTEGER NOT NULL DEFAULT 0 CHECK (quantidade_total >= 0),
 quantidade_reservada INTEGER NOT NULL DEFAULT 0 CHECK (quantidade_reservada >= 0),
 quantidade_disponivel INTEGER GENERATED ALWAYS AS (quantidade_total - quantidade_reservada) STORED,
 CHECK (quantidade_reservada <= quantidade_total)
);
COMMIT;
