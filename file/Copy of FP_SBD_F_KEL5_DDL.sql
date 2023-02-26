DROP DATABASE IF EXISTS FP_SBD_KEL_5;
CREATE DATABASE FP_SBD_KEL_5;
USE FP_SBD_KEL_5;

CREATE TABLE ACCOUNT_TYPE (
    AT_ID CHAR(5) NOT NULL,
    AT_LIMIT DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (AT_ID)
);

CREATE TABLE ACCOUNT (
    ACC_KTP_NUM CHAR(16) NOT NULL,
    ACC_AT_ID CHAR(5) NOT NULL,
    ACC_NAME VARCHAR(60) NOT NULL,
    ACC_EMAIL VARCHAR(256) NOT NULL,
    ACC_PHONE_NUM VARCHAR(15) NOT NULL,
    ACC_ADDRESS VARCHAR(256) NOT NULL,
    ACC_GENDER CHAR(1) NOT NULL,
    ACC_DATE_OF_BIRTH DATE NOT NULL,
    ACC_BANK_NUM VARCHAR(16) NOT NULL,
    ACC_JOB VARCHAR(50) NOT NULL,
    ACC_SALARY DECIMAL(10,2) NOT NULL,
    ACC_REG_DATE DATE NOT NULL,
    ACC_EMERGENCY_PHONE_NUM VARCHAR(15) NOT NULL,
    ACC_EMERGENCY_CONTACT_RELATIONSHIP VARCHAR(10) NOT NULL,
    ACC_KTP_SCAN MEDIUMBLOB NOT NULL,
    ACC_NPWP_SCAN MEDIUMBLOB,
    ACC_SELFIE MEDIUMBLOB NOT NULL,
    ACC_BANK_NUM_SCAN MEDIUMBLOB NOT NULL,
    ACC_RATING DECIMAL(2,1) NOT NULL,
    PRIMARY KEY (ACC_KTP_NUM),
    FOREIGN KEY (ACC_AT_ID) REFERENCES ACCOUNT_TYPE (AT_ID)
);

CREATE TABLE EMPLOYEE (
    E_KTP_NUM VARCHAR(16) NOT NULL,
    E_NAME VARCHAR(60) NOT NULL,
    E_EMAIL VARCHAR(256) NOT NULL,
    E_PHONE_NUM VARCHAR(15) NOT NULL,
    E_ADDRESS VARCHAR(256) NOT NULL,
    E_GENDER CHAR(1) NOT NULL,
    PRIMARY KEY (E_KTP_NUM)
);

CREATE TABLE LOAN_TYPE (
    LT_ID CHAR(5) NOT NULL,
    LT_NAME VARCHAR(16) NOT NULL,
    LT_INTEREST DECIMAL(5,4) NOT NULL,
    LT_PERIOD INT NOT NULL,
    LT_PENALTY DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (LT_ID)
);

CREATE TABLE TRANSACTION (
    T_ID CHAR(5) NOT NULL,
    T_ACC_KTP_NUM CHAR(16) NOT NULL,
    T_E_KTP_NUM VARCHAR(16) NOT NULL,
    T_LT_ID CHAR(5) NOT NULL,
    T_DATE DATE NOT NULL,
    T_DUE_DATE DATE NOT NULL,
    T_STATUS VARCHAR(11) NOT NULL,
    T_LOAN DECIMAL(10,2) NOT NULL,
    T_MONTHLY_PAYMENT DECIMAL(10,2) NOT NULL,
    T_PENALTY_COUNT INT NULL,
    PRIMARY KEY (T_ID),
    FOREIGN KEY (T_ACC_KTP_NUM) REFERENCES ACCOUNT (ACC_KTP_NUM),
    FOREIGN KEY (T_E_KTP_NUM) REFERENCES EMPLOYEE (E_KTP_NUM),
    FOREIGN KEY (T_LT_ID) REFERENCES LOAN_TYPE (LT_ID)
);

CREATE TABLE LOAN_PAYMENT (
    LP_ID CHAR(6) NOT NULL,
    LP_T_ID CHAR(5) NOT NULL,
    LP_DATE DATE NOT NULL,
    LP_PAYMENT DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (LP_ID),
    FOREIGN KEY (LP_T_ID) REFERENCES TRANSACTION (T_ID)
);