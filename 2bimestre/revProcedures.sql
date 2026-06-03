--procedures
--1
CREATE OR REPLACE PROCEDURE prc_servico(p_cdservico INTEGER) IS
    CURSOR c_servico IS
        SELECT nmservico, vlservico FROM SERVICO WHERE cdservico = p_cdservico;
BEGIN
    FOR reg IN c_servico LOOP
        DBMS_OUTPUT.PUT_LINE(reg.nmservico||'-'||reg.vlservico);
    END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_PUTPUT.PUT_LINE('Erro: '||SQLERRM);
END; --como faz sem cursor?

--2
EXECUTE prc_servico(101);

--3
CREATE OR REPLACE PROCEDURE prc_historico_cliente(p_cdcliente INTEGER) IS
    CURSOR c_cliente IS
        SELECT nmcliente, cdplacaveiculo, dtsolicitação
        FROM CLIENTE c
        JOIN VEICULO v ON c.cdcliente = v.cdcliente
        JOIN HISTORICO h ON v.cdplacaveiculo = h.cdplacaveiculo
        WHERE cdcliente = p_cdcliente;
BEGIN
    FOR reg IN c_cliente LOOP
        DBMS_PUTPUT.PUT_LINE(reg.nmcliente||'-'||reg.cdplacaveiculo||'-'||reg.dtsolicitacao);
    END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_PUTPUT.PUT_LINE('Erro: '||SQLERRM);
END;

--4
SELECT * FROM USER_SOURCE WHERE NAME = prc_servico;

--5
SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE = 'PROCEDURE';

--6
DROP PROCEDURE prc_servico;
