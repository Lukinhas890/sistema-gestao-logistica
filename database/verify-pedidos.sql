BEGIN;
SELECT 'pedidos',count(*) FROM pedidos UNION ALL SELECT 'itens',count(*) FROM itens_pedido;
DO $$ BEGIN
 BEGIN UPDATE itens_pedido SET quantidade=0; RAISE EXCEPTION 'Quantidade zero aceita'; EXCEPTION WHEN check_violation THEN NULL; END;
 BEGIN UPDATE pedidos SET status='INVALIDO'; RAISE EXCEPTION 'Status invalido aceito'; EXCEPTION WHEN check_violation THEN NULL; END;
END $$;
ROLLBACK;