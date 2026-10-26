BEGIN;
INSERT INTO produtos VALUES ('00000000-0000-0000-0000-000000000001','Teste transacional','TESTE-ROLLBACK',1,true);
INSERT INTO estoque(produto_id,quantidade_total,quantidade_reservada) VALUES ('00000000-0000-0000-0000-000000000001',10,3);
DO $$ BEGIN
 IF (SELECT quantidade_disponivel FROM estoque WHERE produto_id='00000000-0000-0000-0000-000000000001') <> 7 THEN RAISE EXCEPTION 'Saldo incorreto'; END IF;
 BEGIN UPDATE estoque SET quantidade_reservada=11; RAISE EXCEPTION 'Reserva excedente aceita'; EXCEPTION WHEN check_violation THEN NULL; END;
END $$;
ROLLBACK;