BEGIN;
INSERT INTO clientes(id,nome,documento,email,telefone)
SELECT (c->>'id')::uuid,c->>'nome',c->>'documento',c->>'email',c->>'telefone'
FROM jsonb_array_elements('{
  "clientes": [
    {
      "id": "11111111-1111-1111-1111-111111111111",
      "nome": "Maria Silva",
      "documento": "123.456.789-00",
      "email": "maria.silva@email.com",
      "telefone": "(19) 99999-1111",
      "enderecos": [
        {
          "id": "a1111111-0000-0000-0000-000000000001",
          "logradouro": "Rua das Flores",
          "numero": "120",
          "complemento": "Apto 31",
          "bairro": "Centro",
          "cidade": "Campinas",
          "uf": "SP",
          "cep": "13010-000"
        }
      ]
    },
    {
      "id": "22222222-2222-2222-2222-222222222222",
      "nome": "João Souza",
      "documento": "987.654.321-00",
      "email": "joao.souza@email.com",
      "telefone": "(19) 98888-2222",
      "enderecos": [
        {
          "id": "a2222222-0000-0000-0000-000000000001",
          "logradouro": "Avenida Brasil",
          "numero": "450",
          "complemento": "",
          "bairro": "Jardim Paulista",
          "cidade": "Campinas",
          "uf": "SP",
          "cep": "13020-100"
        }
      ]
    },
    {
      "id": "33333333-3333-3333-3333-333333333333",
      "nome": "Padaria Pão Quente LTDA",
      "documento": "12.345.678/0001-90",
      "email": "contato@paoquente.com.br",
      "telefone": "(19) 3222-3333",
      "enderecos": [
        {
          "id": "a3333333-0000-0000-0000-000000000001",
          "logradouro": "Rua XV de Novembro",
          "numero": "88",
          "complemento": "Loja 2",
          "bairro": "Centro",
          "cidade": "Valinhos",
          "uf": "SP",
          "cep": "13270-000"
        }
      ]
    },
    {
      "id": "44444444-4444-4444-4444-444444444444",
      "nome": "Ana Beatriz Lima",
      "documento": "456.789.123-00",
      "email": "ana.lima@email.com",
      "telefone": "(11) 97777-4444",
      "enderecos": [
        {
          "id": "a4444444-0000-0000-0000-000000000001",
          "logradouro": "Rua Augusta",
          "numero": "1500",
          "complemento": "Bloco B",
          "bairro": "Consolação",
          "cidade": "São Paulo",
          "uf": "SP",
          "cep": "01304-001"
        }
      ]
    }
  ]
}'::jsonb->'clientes') c ON CONFLICT (id) DO NOTHING;
INSERT INTO enderecos(id,cliente_id,logradouro,numero,complemento,bairro,cidade,uf,cep)
SELECT (e->>'id')::uuid,(c->>'id')::uuid,e->>'logradouro',e->>'numero',e->>'complemento',e->>'bairro',e->>'cidade',e->>'uf',e->>'cep'
FROM jsonb_array_elements('{
  "clientes": [
    {
      "id": "11111111-1111-1111-1111-111111111111",
      "nome": "Maria Silva",
      "documento": "123.456.789-00",
      "email": "maria.silva@email.com",
      "telefone": "(19) 99999-1111",
      "enderecos": [
        {
          "id": "a1111111-0000-0000-0000-000000000001",
          "logradouro": "Rua das Flores",
          "numero": "120",
          "complemento": "Apto 31",
          "bairro": "Centro",
          "cidade": "Campinas",
          "uf": "SP",
          "cep": "13010-000"
        }
      ]
    },
    {
      "id": "22222222-2222-2222-2222-222222222222",
      "nome": "João Souza",
      "documento": "987.654.321-00",
      "email": "joao.souza@email.com",
      "telefone": "(19) 98888-2222",
      "enderecos": [
        {
          "id": "a2222222-0000-0000-0000-000000000001",
          "logradouro": "Avenida Brasil",
          "numero": "450",
          "complemento": "",
          "bairro": "Jardim Paulista",
          "cidade": "Campinas",
          "uf": "SP",
          "cep": "13020-100"
        }
      ]
    },
    {
      "id": "33333333-3333-3333-3333-333333333333",
      "nome": "Padaria Pão Quente LTDA",
      "documento": "12.345.678/0001-90",
      "email": "contato@paoquente.com.br",
      "telefone": "(19) 3222-3333",
      "enderecos": [
        {
          "id": "a3333333-0000-0000-0000-000000000001",
          "logradouro": "Rua XV de Novembro",
          "numero": "88",
          "complemento": "Loja 2",
          "bairro": "Centro",
          "cidade": "Valinhos",
          "uf": "SP",
          "cep": "13270-000"
        }
      ]
    },
    {
      "id": "44444444-4444-4444-4444-444444444444",
      "nome": "Ana Beatriz Lima",
      "documento": "456.789.123-00",
      "email": "ana.lima@email.com",
      "telefone": "(11) 97777-4444",
      "enderecos": [
        {
          "id": "a4444444-0000-0000-0000-000000000001",
          "logradouro": "Rua Augusta",
          "numero": "1500",
          "complemento": "Bloco B",
          "bairro": "Consolação",
          "cidade": "São Paulo",
          "uf": "SP",
          "cep": "01304-001"
        }
      ]
    }
  ]
}'::jsonb->'clientes') c CROSS JOIN LATERAL jsonb_array_elements(c->'enderecos') e
ON CONFLICT (id) DO NOTHING;
COMMIT;
