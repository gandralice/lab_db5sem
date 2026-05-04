-- Gerado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   em:        2026-03-10 15:53:30 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE CIDADAO 
    ( 
     id_cidadao     NUMBER (10)  NOT NULL , 
     cd_cpf_cidadao NUMBER (11)  NOT NULL , 
     nm_cidadao     VARCHAR2 (100 CHAR)  NOT NULL , 
     dt_nascimento  DATE  NOT NULL 
    ) 
;

ALTER TABLE CIDADAO 
    ADD CONSTRAINT CIDADAO_PK PRIMARY KEY ( id_cidadao ) ;

CREATE TABLE OCORRENCIA 
    ( 
     id_ocorrencia              NUMBER (10)  NOT NULL , 
     dt_ocorrencia              DATE  NOT NULL , 
     ds_ocorrencia              VARCHAR2 (120 CHAR)  NOT NULL , 
     nm_status_ocorrencia       VARCHAR2 (50 CHAR)  NOT NULL , 
     CIDADAO_id_cidadao         NUMBER (10)  NOT NULL , 
     SERVICO_PUBLICO_id_servico NUMBER (10)  NOT NULL 
    ) 
;

ALTER TABLE OCORRENCIA 
    ADD CONSTRAINT OCORRENCIA_PK PRIMARY KEY ( id_ocorrencia ) ;

CREATE TABLE PAGAMENTO 
    ( 
     id_pagamento             NUMBER (10)  NOT NULL , 
     vl_pagamento             NUMBER (10,2)  NOT NULL , 
     dt_pagamento             DATE  NOT NULL , 
     OCORRENCIA_id_ocorrencia NUMBER (10)  NOT NULL 
    ) 
;

ALTER TABLE PAGAMENTO 
    ADD CONSTRAINT PAGAMENTO_PK PRIMARY KEY ( id_pagamento ) ;

CREATE TABLE SERVICO_PUBLICO 
    ( 
     id_servico      NUMBER (10)  NOT NULL , 
     nm_servico      VARCHAR2 (100 CHAR)  NOT NULL , 
     nm_tipo_servico VARCHAR2 (100 CHAR)  NOT NULL 
    ) 
;

ALTER TABLE SERVICO_PUBLICO 
    ADD CONSTRAINT SERVICO_PUBLICO_PK PRIMARY KEY ( id_servico ) ;

ALTER TABLE OCORRENCIA 
    ADD CONSTRAINT OCORRENCIA_CIDADAO_FK FOREIGN KEY 
    ( 
     CIDADAO_id_cidadao
    ) 
    REFERENCES CIDADAO 
    ( 
     id_cidadao
    ) 
;

ALTER TABLE OCORRENCIA 
    ADD CONSTRAINT OCORRENCIA_SERVICO_PUBLICO_FK FOREIGN KEY 
    ( 
     SERVICO_PUBLICO_id_servico
    ) 
    REFERENCES SERVICO_PUBLICO 
    ( 
     id_servico
    ) 
;

ALTER TABLE PAGAMENTO 
    ADD CONSTRAINT PAGAMENTO_OCORRENCIA_FK FOREIGN KEY 
    ( 
     OCORRENCIA_id_ocorrencia
    ) 
    REFERENCES OCORRENCIA 
    ( 
     id_ocorrencia
    ) 
;



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             0
-- ALTER TABLE                              7
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
