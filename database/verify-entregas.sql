BEGIN;
SELECT 'entregas',count(*) FROM entregas;
DO $$ BEGIN
 BEGIN UPDATE entregas SET status='EM_TRANSPORTE',motorista_id=NULL; RAISE EXCEPTION 'Transporte sem motorista aceito'; EXCEPTION WHEN check_violation THEN NULL; END;
END $$;
ROLLBACK;