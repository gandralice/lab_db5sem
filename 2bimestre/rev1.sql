--bloco anonimo - variaveis e tipos
DECLARE
    v_produto VARCHAR2(50);
    v_preco DECIMAL(10,2);
    v_quantidade INTEGER;
BEGIN
    v_produto := 'Caneta';
    v_preco := 2.5;
    v_quantidade := 10;
    DBMS_OUTPUT.PUT_LINE('Produto: '||v_produto||' | Preço: '||v_preco||' | Quantidade: '||v_quantidade);
END;

--select into
DECLARE
    v_nome EMPLOYEES.FIRST_NAME%TYPE;
    v_email EMPLOYEES.EMAIL%TYPE;
BEGIN     
    SELECT first_name, email INTO v_nome, v_email
    FROM EMPLOYEES
    WHERE employee_id = 100;
    DBMS_OUTPUT.PUT_LINE('Nome: '||v_nome||' | Email: '||v_email);
END; 

DECLARE
    v_id INTEGER := :id_produto;
    v_nome VARCHAR2(50);
    v_preco NUMBER(10,2);
BEGIN
    SELECT nome, preco
    INTO v_nome, v_preco
    FROM PRODUTO
    WHERE id_produto = v_id;
    DBMS_OUTPUT.PUT_LINE('Produto encontrado: '||v_nome||' - '||v_preco);
END;

-- if elsif else
DECLARE
    v_id INTEGER := :id_produto;
    v_preco NUMBER(10,2);
BEGIN
    SELECT preco
    INTO v_preco
    FROM PRODUTO
    WHERE id_produto = v_id;
    IF v_preco < 10 THEN
        DBMS_OUTPUT.PUT_LINE('Produto barato');
    ELSIF v_preco BETWEEN 10 AND 50 THEN
        DBMS_OUTPUT.PUT_LINE('Produto médio');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Produto caro');
    END IF;
END;

--Loops
BEGIN
    FOR v_num In 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(v_num);
    END LOOP;
END;

DECLARE
    v_num INTEGER :=1;
BEGIN
    WHILE v_num <= 10 LOOP
        IF MOD(v_num, 2) = 0 THEN
            DBMS_OUTPUT.PUT_LINE(v_num);
        END IF;
    v_num := v_num+1;
    END LOOP;
END;

DECLARE
    v_sum INTEGER :=0;
BEGIN
    FOR v_num IN 1..5 LOOP
        v_sum := v_sum + v_num;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_sum);
END;


--exceptions
DECLARE
    v_id INTEGER := :id_produto;
    v_preco NUMBER(10,2);
BEGIN
    SELECT preco
    INTO v_preco
    FROM PRODUTO
    WHERE id_produto = v_id;
    IF v_preco < 10 THEN
        DBMS_OUTPUT.PUT_LINE('Produto barato');
    ELSIF v_preco BETWEEN 10 AND 50 THEN
        DBMS_OUTPUT.PUT_LINE('Produto médio');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Produto caro');
    END IF;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Produto não encontrado');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado'||SQLERRM);
END;