BEGIN;
SELECT 'clientes',count(*) FROM clientes UNION ALL SELECT 'enderecos',count(*) FROM enderecos;
DO $$ BEGIN
 BEGIN INSERT INTO clientes SELECT * FROM clientes LIMIT 1; RAISE EXCEPTION 'Duplicata aceita'; EXCEPTION WHEN unique_violation THEN NULL; END;
END $$;
ROLLBACK;