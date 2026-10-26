BEGIN;
CREATE TABLE IF NOT EXISTS entregas (
 id UUID PRIMARY KEY, pedido_id UUID NOT NULL UNIQUE, motorista_id UUID, veiculo_id UUID,
 status TEXT NOT NULL CHECK (status IN ('PENDENTE','EM_TRANSPORTE','ENTREGUE')),
 criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 CHECK (status = 'PENDENTE' OR (motorista_id IS NOT NULL AND veiculo_id IS NOT NULL))
);
CREATE UNIQUE INDEX IF NOT EXISTS motorista_em_transporte_idx ON entregas(motorista_id) WHERE status = 'EM_TRANSPORTE';
CREATE UNIQUE INDEX IF NOT EXISTS veiculo_em_transporte_idx ON entregas(veiculo_id) WHERE status = 'EM_TRANSPORTE';
COMMIT;
