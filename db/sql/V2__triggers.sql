CREATE OR REPLACE FUNCTION chk_capacidade() RETURNS trigger AS $$
BEGIN
  IF (SELECT COUNT(*) FROM matricula 
      WHERE oferta_id = NEW.oferta_id AND status = 'ATIVA')
     >= (SELECT capacidade_max FROM oferta_disciplina WHERE id = NEW.oferta_id) THEN
    RAISE EXCEPTION 'Capacidade máxima atingida para esta oferta (%).', NEW.oferta_id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_capacidade ON matricula;
CREATE TRIGGER trg_capacidade
BEFORE INSERT ON matricula
FOR EACH ROW EXECUTE FUNCTION chk_capacidade();
