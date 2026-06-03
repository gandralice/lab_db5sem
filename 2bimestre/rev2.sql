--1

DECLARE
    v_cdcliente INTEGER := :cd_cliente;
    v_nome CLIENTE.nmcliente%TYPE;
    v_telefone CLIENTE.cdtelefone%TYPE;
BEGIN
    SELECT nmcliente, cdtelefone INTO v_nome, v_telefone
    FROM CLIENTE WHERE cdcliente = v_cdcliente;
    DBMS_OUTPUT.PUT_LINE(v_nome||' - '||v_telefone);
END;

--2

DECLARE
    v_cdservico INTEGER := :cdservico;
    v_nome SERVICO.nmservico%TYPE;
    v_valor SERVICO.vlservico%TYPE;
BEGIN
    SELECT nmservico, vlservico INTO v_nome, v_valor
    FROM SERVICO WHERE cdservico = v_cdservico;
    DBMS_OUTPUT.PUT_LINE(v_nome||' - R$'||v_valor);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('não encontrado');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('erro inesperado'||SQLERRM);
END;

--3 Crie uma procedure chamada PRC_CLIENTE que receba um código de cliente e exiba o nome e telefone dele.

CREATE OR REPLACE PROCEDURE prc_cliente (p_cdcliente INTEGER) IS
  CURSOR c_cliente IS
    SELECT nmcliente, cdtelefone 
    FROM CLIENTE 
    WHERE cdcliente = p_cdcliente;
BEGIN
  FOR reg IN c_cliente LOOP
    DBMS_OUTPUT.PUT_LINE(reg.nmcliente || ' - ' || reg.cdtelefone);
    
  END LOOP;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('não encontrado');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('erro: ' || SQLERRM);
END;
/

--4 Depois de criar, execute a procedure para o cliente de código 1.
EXECUTE prc_cliente(1);

--5 Exiba o código fonte da procedure PRC_CLIENTE no dicionário.
SELECT * FROM USER_SOURCE WHERE NAME = 'prc_cliente';


--6 Exiba todas as procedures do user.
SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE = 'PROCEDURE';

--7 Exclua a procedure PRC_CLIENTE.

DROP PROCEURE prc_cliente

--8 Crie uma function chamada FNC_NOME_CLIENTE que receba um código de cliente e retorne o nome dele.
CREATE OU REPLACE FUNCTION fnc_nome_cliente(p_cdcliente INTEGER)
    RETURN VARCHAR2 IS
        v_nome CLIENTE.nmcliente%TYPE;
BEGIN
    SELECT nmcliente INTO v_nome
    FROM CLIENTE
    WHERE cdcliente = p_cdcliente;
  
    RETURN v_nome;  -- devolve o nome!
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RETURN 'Cliente não encontrado!';
    WHEN OTHERS THEN
    RETURN 'Erro: ' || SQLERRM;
END;