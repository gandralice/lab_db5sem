--FUNCTIONS
--1) Crie uma function FNC_VALOR_SERVICO que receba um código de serviço e retorne o valor dele.
CREATE OR REPLACE FUNCTION FNC_VALOR_SERVICO(p_cdservico INTEGER)
RETURN NUMBER IS
    v_valor SERVICO.vlservico%TYPE;
BEGIN
    SELECT vlservico INTO v_valor FROM SERVICO WHERE cdservico = p_cdservico;
    RETURN v_valor;
END;

--2) Execute a function para o serviço 101.
SELECT FNC_VALOR_SERVICO(101) FROM DUAL;

--3) Crie uma function FNC_TOTAL_VEICULOS que receba um código de cliente e retorne
-- a quantidade de veículos dele. (usa COUNT!)
CREATE OR REPLACE FUNCTION FNC_TOTAL_VEICULOS(p_cdcliente INTEGER)
RETURN INTEGER IS
    v_quantidade INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_quantidade
    FROM VEICULO
    WHERE CLIENTE_cd_cliente = p_cdcliente;
    RETURN v_quantidade;
END;

--4) Execute a function para o cliente 1.
SELECT FNC_TOTAL_VEICULOS(1) FROM DUAL;

--5) Liste todas as functions do usuário.

SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE = 'FUNCTION';

--6) Exclua a FNC_VALOR_SERVICO.

DROP FUNCTION FNC_VALOR_SERVICO;