# Bancos de dados da logística

Instância PostgreSQL 18 exclusiva em 127.0.0.1:5433. Dados em C:\Users\FamiliaPinto\PostgreSQL-Logistica\data. Não altera o servidor anterior na porta 5432. A instância foi iniciada diretamente; não há serviço Windows registrado nem inicialização automática.

## Organização

- logistica_clientes: clientes e enderecos.
- logistica_pedidos: pedidos e itens_pedido.
- logistica_entregas: entregas.
- logistica_estoque: produtos e estoque.
- logistica_frota: motoristas e veiculos.

Execute cada arquivo de schema no banco correspondente. Os scripts usam transações e criação condicional; não são um sistema de migrações para evoluir estruturas existentes. seed-*.sql contém um snapshot dos mocks de demonstração e preserva os UUIDs. Reexecutar o seed não sobrescreve registros existentes. Os scripts verify-*.sql verificam restrições em transações revertidas.

Importados: 4 clientes, 4 endereços, 3 pedidos, 4 itens, 3 entregas. Produtos, estoque, motoristas e veículos estão vazios: faltam dados aprovados. As referências externas das entregas aos motoristas/veículos reproduzem os mocks e ainda não têm registros correspondentes em Frota.

## Decisões de armazenamento

IDs UUID e referências entre serviços sem chaves estrangeiras entre bancos. Chaves estrangeiras apenas dentro do mesmo banco. Endereço do pedido é uma cópia JSONB; preços usam NUMERIC e itens têm quantidade positiva. Estoque guarda total e reservado e calcula disponível como total menos reservado. Unidade da capacidade do veículo deve ser definida pelo responsável antes de cadastrar dados reais. Campos opcionais sem obrigatoriedade adicional não receberam NOT NULL.

O usuário logistica_admin é administrador local de desenvolvimento. A credencial protegida está fora do repositório em C:\Users\FamiliaPinto\PostgreSQL-Logistica\credencial.xml. Criar usuários restritos por serviço antes de uso compartilhado/deploy.

## O que ainda precisa ser implementado

A aplicação continua consumindo os mocks. Cada serviço real precisa implementar os endpoints e acessar exclusivamente seu banco. O BFF não acessa PostgreSQL diretamente.

Regras entre serviços dependem das APIs: existência de cliente/produto/pedido/motorista/veículo, pedido com pelo menos um item, confirmação mediante reserva atômica de todos os itens, cancelamento e liberação, validação de ativos, avanço de status e sincronização de pedido entregue. Os índices impedem motorista/veículo repetidos em entregas EM_TRANSPORTE, mas não validam disponibilidade por API. A tabela de estoque impede saldo negativo, mas não implementa sozinha as operações transacionais de reserva/liberação/entrada. Documento é único como texto; normalização de CPF/CNPJ deve ocorrer no serviço.

## Verificação executada

Criação e importação concluídas na instância 5433. Verificações passaram para duplicata de chave, quantidade positiva, status permitido, transporte com atribuição, cálculo de disponível, reserva não superior ao total e capacidade positiva. Dados de teste das verificações são revertidos.