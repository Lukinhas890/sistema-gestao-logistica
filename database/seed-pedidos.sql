BEGIN;
INSERT INTO pedidos(id,cliente_id,status,criado_em,endereco_entrega)
SELECT (p->>'id')::uuid,(p->>'clienteId')::uuid,p->>'status',(p->>'criadoEm')::timestamp,p->'enderecoEntrega'
FROM jsonb_array_elements('{
  "pedidos": [
    {
      "id": "b1111111-1111-1111-1111-111111111111",
      "clienteId": "11111111-1111-1111-1111-111111111111",
      "status": "CONFIRMADO",
      "criadoEm": "2026-10-10T09:30:00",
      "enderecoEntrega": {
        "logradouro": "Rua das Flores",
        "numero": "120",
        "complemento": "Apto 31",
        "bairro": "Centro",
        "cidade": "Campinas",
        "uf": "SP",
        "cep": "13010-000"
      },
      "itens": [
        { "produtoId": "c1111111-0000-0000-0000-000000000001", "nome": "Caixa de Parafusos", "quantidade": 2, "precoUnitario": 35.90 },
        { "produtoId": "c1111111-0000-0000-0000-000000000002", "nome": "Furadeira 500W", "quantidade": 1, "precoUnitario": 249.00 }
      ]
    },
    {
      "id": "b2222222-2222-2222-2222-222222222222",
      "clienteId": "33333333-3333-3333-3333-333333333333",
      "status": "ENTREGUE",
      "criadoEm": "2026-10-11T14:15:00",
      "enderecoEntrega": {
        "logradouro": "Rua XV de Novembro",
        "numero": "88",
        "complemento": "Loja 2",
        "bairro": "Centro",
        "cidade": "Valinhos",
        "uf": "SP",
        "cep": "13270-000"
      },
      "itens": [
        { "produtoId": "c1111111-0000-0000-0000-000000000003", "nome": "Saco de Farinha 25kg", "quantidade": 10, "precoUnitario": 89.90 }
      ]
    },
    {
      "id": "b3333333-3333-3333-3333-333333333333",
      "clienteId": "22222222-2222-2222-2222-222222222222",
      "status": "CONFIRMADO",
      "criadoEm": "2026-10-12T16:40:00",
      "enderecoEntrega": {
        "logradouro": "Avenida Brasil",
        "numero": "450",
        "complemento": "",
        "bairro": "Jardim Paulista",
        "cidade": "Campinas",
        "uf": "SP",
        "cep": "13020-100"
      },
      "itens": [
        { "produtoId": "c1111111-0000-0000-0000-000000000002", "nome": "Furadeira 500W", "quantidade": 1, "precoUnitario": 249.00 }
      ]
    }
  ]
}'::jsonb->'pedidos') p ON CONFLICT (id) DO NOTHING;
INSERT INTO itens_pedido(pedido_id,sequencia,produto_id,nome,quantidade,preco_unitario)
SELECT (p->>'id')::uuid,i.n::int,(i.item->>'produtoId')::uuid,i.item->>'nome',(i.item->>'quantidade')::int,(i.item->>'precoUnitario')::numeric
FROM jsonb_array_elements('{
  "pedidos": [
    {
      "id": "b1111111-1111-1111-1111-111111111111",
      "clienteId": "11111111-1111-1111-1111-111111111111",
      "status": "CONFIRMADO",
      "criadoEm": "2026-10-10T09:30:00",
      "enderecoEntrega": {
        "logradouro": "Rua das Flores",
        "numero": "120",
        "complemento": "Apto 31",
        "bairro": "Centro",
        "cidade": "Campinas",
        "uf": "SP",
        "cep": "13010-000"
      },
      "itens": [
        { "produtoId": "c1111111-0000-0000-0000-000000000001", "nome": "Caixa de Parafusos", "quantidade": 2, "precoUnitario": 35.90 },
        { "produtoId": "c1111111-0000-0000-0000-000000000002", "nome": "Furadeira 500W", "quantidade": 1, "precoUnitario": 249.00 }
      ]
    },
    {
      "id": "b2222222-2222-2222-2222-222222222222",
      "clienteId": "33333333-3333-3333-3333-333333333333",
      "status": "ENTREGUE",
      "criadoEm": "2026-10-11T14:15:00",
      "enderecoEntrega": {
        "logradouro": "Rua XV de Novembro",
        "numero": "88",
        "complemento": "Loja 2",
        "bairro": "Centro",
        "cidade": "Valinhos",
        "uf": "SP",
        "cep": "13270-000"
      },
      "itens": [
        { "produtoId": "c1111111-0000-0000-0000-000000000003", "nome": "Saco de Farinha 25kg", "quantidade": 10, "precoUnitario": 89.90 }
      ]
    },
    {
      "id": "b3333333-3333-3333-3333-333333333333",
      "clienteId": "22222222-2222-2222-2222-222222222222",
      "status": "CONFIRMADO",
      "criadoEm": "2026-10-12T16:40:00",
      "enderecoEntrega": {
        "logradouro": "Avenida Brasil",
        "numero": "450",
        "complemento": "",
        "bairro": "Jardim Paulista",
        "cidade": "Campinas",
        "uf": "SP",
        "cep": "13020-100"
      },
      "itens": [
        { "produtoId": "c1111111-0000-0000-0000-000000000002", "nome": "Furadeira 500W", "quantidade": 1, "precoUnitario": 249.00 }
      ]
    }
  ]
}'::jsonb->'pedidos') p CROSS JOIN LATERAL jsonb_array_elements(p->'itens') WITH ORDINALITY i(item,n)
ON CONFLICT (pedido_id,sequencia) DO NOTHING;
COMMIT;
