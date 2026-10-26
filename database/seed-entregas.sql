BEGIN;
INSERT INTO entregas(id,pedido_id,motorista_id,veiculo_id,status,criado_em,atualizado_em)
SELECT (e->>'id')::uuid,(e->>'pedidoId')::uuid,(e->>'motoristaId')::uuid,(e->>'veiculoId')::uuid,e->>'status',(e->>'criadoEm')::timestamp,(e->>'atualizadoEm')::timestamp
FROM jsonb_array_elements('{
  "entregas": [
    {
      "id": "d1111111-1111-1111-1111-111111111111",
      "pedidoId": "b1111111-1111-1111-1111-111111111111",
      "motoristaId": "e1111111-1111-1111-1111-111111111111",
      "veiculoId": "f1111111-1111-1111-1111-111111111111",
      "status": "EM_TRANSPORTE",
      "criadoEm": "2026-10-10T10:00:00",
      "atualizadoEm": "2026-10-11T08:20:00"
    },
    {
      "id": "d2222222-2222-2222-2222-222222222222",
      "pedidoId": "b2222222-2222-2222-2222-222222222222",
      "motoristaId": "e2222222-2222-2222-2222-222222222222",
      "veiculoId": "f2222222-2222-2222-2222-222222222222",
      "status": "ENTREGUE",
      "criadoEm": "2026-10-11T14:30:00",
      "atualizadoEm": "2026-10-12T11:05:00"
    },
    {
      "id": "d3333333-3333-3333-3333-333333333333",
      "pedidoId": "b3333333-3333-3333-3333-333333333333",
      "motoristaId": null,
      "veiculoId": null,
      "status": "PENDENTE",
      "criadoEm": "2026-10-12T17:00:00",
      "atualizadoEm": "2026-10-12T17:00:00"
    }
  ]
}'::jsonb->'entregas') e ON CONFLICT (id) DO NOTHING;
COMMIT;
