BEGIN;
CREATE TABLE IF NOT EXISTS pedidos (
 id UUID PRIMARY KEY, cliente_id UUID NOT NULL,
 status TEXT NOT NULL CHECK (status IN ('CRIADO','CONFIRMADO','ENTREGUE','CANCELADO')),
 criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 endereco_entrega JSONB NOT NULL CHECK (jsonb_typeof(endereco_entrega) = 'object')
);
CREATE TABLE IF NOT EXISTS itens_pedido (
 pedido_id UUID NOT NULL REFERENCES pedidos(id), sequencia INTEGER NOT NULL CHECK (sequencia > 0),
 produto_id UUID NOT NULL, nome TEXT NOT NULL, quantidade INTEGER NOT NULL CHECK (quantidade > 0),
 preco_unitario NUMERIC(14,2) NOT NULL CHECK (preco_unitario >= 0), PRIMARY KEY(pedido_id, sequencia)
);
CREATE INDEX IF NOT EXISTS pedidos_cliente_idx ON pedidos(cliente_id);
COMMIT;
