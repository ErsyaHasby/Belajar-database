/*==============================================================*/
/* DBMS name:      PostgreSQL 9.x                               */
/* Created on:     18/09/2025 08:57:39                          */
/*==============================================================*/


-- drop index REGIONS_COUNTRIES_FK;

-- drop index COUNTRIES_PK;

-- drop table COUNTRIES;

-- drop index LOCATIONS_DEPARTMENT_FK;

-- drop index DEPARTMENTS_PK;

-- drop table DEPARTMENTS;

-- drop index EMPLOYEES_EMPLOYEES_FK;

-- drop index JOBS_EMPLOYEES_FK;

-- drop index DEPARTMENTS_EMPLOYEES_FK;

-- drop index EMPLOYEES_PK;

-- drop table EMPLOYEES;

-- drop index JOBS_PK;

-- drop table JOBS;

-- drop index EMPLOYEES_JOBHISTORY_FK;

-- drop index JOBS_JOBHISTORY_FK;

-- drop index DEPARTMENT_JOBHISTORY_FK;

-- drop table JOB_HISTORY;

-- drop index COUNTRIES_LOCATIONS_FK;

-- drop index LOCATIONS_PK;

-- drop table LOCATIONS;

-- drop index REGIONS_PK;

-- drop table REGIONS;

/*==============================================================*/
/* Table: COUNTRIES                                             */
/*==============================================================*/
create table COUNTRIES (
   COUNTRY_ID           CHAR(2)              not null,
   COUNTRY_NAME         VARCHAR(40)          null,
   REGION_ID            NUMERIC(1)           null,
   constraint PK_COUNTRIES primary key (COUNTRY_ID)
);

/*==============================================================*/
/* Index: COUNTRIES_PK                                          */
/*==============================================================*/
create unique index COUNTRIES_PK on COUNTRIES (
COUNTRY_ID
);

/*==============================================================*/
/* Index: REGIONS_COUNTRIES_FK                                  */
/*==============================================================*/
create  index REGIONS_COUNTRIES_FK on COUNTRIES (
REGION_ID
);

/*==============================================================*/
/* Table: DEPARTMENTS                                           */
/*==============================================================*/
create table DEPARTMENTS (
   DEPARTMENT_ID        NUMERIC(4)           not null,
   DEPARTMENT_NAME      VARCHAR(30)          not null,
   MANAGER_ID           NUMERIC(6)           null,
   LOCATION_ID          NUMERIC(4)           null,
   constraint PK_DEPARTMENTS primary key (DEPARTMENT_ID)
);

/*==============================================================*/
/* Index: DEPARTMENTS_PK                                        */
/*==============================================================*/
create unique index DEPARTMENTS_PK on DEPARTMENTS (
DEPARTMENT_ID
);

/*==============================================================*/
/* Index: LOCATIONS_DEPARTMENT_FK                               */
/*==============================================================*/
create  index LOCATIONS_DEPARTMENT_FK on DEPARTMENTS (
LOCATION_ID
);

/*==============================================================*/
/* Table: EMPLOYEES                                             */
/*==============================================================*/
create table EMPLOYEES (
   EMPLOYEE_ID          NUMERIC(6)           not null,
   FIRST_NAME           VARCHAR(20)          null,
   LAST_NAME            VARCHAR(25)          not null,
   EMAIL                VARCHAR(20)          not null,
   PHONE_NUMBER         VARCHAR(20)          null,
   HIRE_DATE            DATE                 not null,
   JOB_ID               VARCHAR(10)          not null,
   EMP_EMPLOYEE_ID      NUMERIC(6)           null,
   SALARY               NUMERIC(8,2)         null,
   COMMISSION_PCT       NUMERIC(2,2)         null,
   MANAGER_ID           NUMERIC(6)           null,
   DEPARTMENT_ID        NUMERIC(4)           null,
   constraint PK_EMPLOYEES primary key (EMPLOYEE_ID)
);

/*==============================================================*/
/* Index: EMPLOYEES_PK                                          */
/*==============================================================*/
create unique index EMPLOYEES_PK on EMPLOYEES (
EMPLOYEE_ID
);

/*==============================================================*/
/* Index: DEPARTMENTS_EMPLOYEES_FK                              */
/*==============================================================*/
create  index DEPARTMENTS_EMPLOYEES_FK on EMPLOYEES (
DEPARTMENT_ID
);

/*==============================================================*/
/* Index: JOBS_EMPLOYEES_FK                                     */
/*==============================================================*/
create  index JOBS_EMPLOYEES_FK on EMPLOYEES (
JOB_ID
);

/*==============================================================*/
/* Index: EMPLOYEES_EMPLOYEES_FK                                */
/*==============================================================*/
create  index EMPLOYEES_EMPLOYEES_FK on EMPLOYEES (
EMP_EMPLOYEE_ID
);

/*==============================================================*/
/* Table: JOBS                                                  */
/*==============================================================*/
create table JOBS (
   JOB_ID               VARCHAR(10)          not null,
   JOB_TITLE            VARCHAR(35)          not null,
   MIN_SALARY           NUMERIC(6)           null,
   MAX_SALARY           NUMERIC(6)           null,
   constraint PK_JOBS primary key (JOB_ID)
);

/*==============================================================*/
/* Index: JOBS_PK                                               */
/*==============================================================*/
create unique index JOBS_PK on JOBS (
JOB_ID
);

/*==============================================================*/
/* Table: JOB_HISTORY                                           */
/*==============================================================*/
create table JOB_HISTORY (
   EMPLOYEE_ID          NUMERIC(6)           not null,
   START_DATE           DATE                 not null,
   END_DATE             DATE                 not null,
   JOB_ID               VARCHAR(10)          not null,
   DEPARTMENT_ID        NUMERIC(4)           null
);

/*==============================================================*/
/* Index: DEPARTMENT_JOBHISTORY_FK                              */
/*==============================================================*/
create  index DEPARTMENT_JOBHISTORY_FK on JOB_HISTORY (
DEPARTMENT_ID
);

/*==============================================================*/
/* Index: JOBS_JOBHISTORY_FK                                    */
/*==============================================================*/
create  index JOBS_JOBHISTORY_FK on JOB_HISTORY (
JOB_ID
);

/*==============================================================*/
/* Index: EMPLOYEES_JOBHISTORY_FK                               */
/*==============================================================*/
create  index EMPLOYEES_JOBHISTORY_FK on JOB_HISTORY (
EMPLOYEE_ID
);

/*==============================================================*/
/* Table: LOCATIONS                                             */
/*==============================================================*/
create table LOCATIONS (
   LOCATION_ID          NUMERIC(4)           not null,
   STREET_ADDRESS       VARCHAR(40)          null,
   POSTAL_CODE          VARCHAR(12)          null,
   CITY                 VARCHAR(30)          not null,
   STATE_PROVINCE       VARCHAR(25)          null,
   COUNTRY_ID           CHAR(2)              null,
   constraint PK_LOCATIONS primary key (LOCATION_ID)
);

/*==============================================================*/
/* Index: LOCATIONS_PK                                          */
/*==============================================================*/
create unique index LOCATIONS_PK on LOCATIONS (
LOCATION_ID
);

/*==============================================================*/
/* Index: COUNTRIES_LOCATIONS_FK                                */
/*==============================================================*/
create  index COUNTRIES_LOCATIONS_FK on LOCATIONS (
COUNTRY_ID
);

/*==============================================================*/
/* Table: REGIONS                                               */
/*==============================================================*/
create table REGIONS (
   REGION_ID            NUMERIC              not null,
   REGION_NAME          VARCHAR(25)          null,
   constraint PK_REGIONS primary key (REGION_ID)
);

/*==============================================================*/
/* Index: REGIONS_PK                                            */
/*==============================================================*/
create unique index REGIONS_PK on REGIONS (
REGION_ID
);

alter table COUNTRIES
   add constraint FK_COUNTRIE_REGIONS_C_REGIONS foreign key (REGION_ID)
      references REGIONS (REGION_ID)
      on delete restrict on update restrict;

alter table DEPARTMENTS
   add constraint FK_DEPARTME_LOCATIONS_LOCATION foreign key (LOCATION_ID)
      references LOCATIONS (LOCATION_ID)
      on delete set null on update restrict;

alter table EMPLOYEES
   add constraint FK_EMPLOYEE_DEPARTMEN_DEPARTME foreign key (DEPARTMENT_ID)
      references DEPARTMENTS (DEPARTMENT_ID)
      on delete set null on update restrict;

alter table EMPLOYEES
   add constraint FK_EMPLOYEE_EMPLOYEES_EMPLOYEE foreign key (EMP_EMPLOYEE_ID)
      references EMPLOYEES (EMPLOYEE_ID)
      on delete set null on update restrict;

alter table EMPLOYEES
   add constraint FK_EMPLOYEE_JOBS_EMPL_JOBS foreign key (JOB_ID)
      references JOBS (JOB_ID)
      on delete restrict on update restrict;

alter table JOB_HISTORY
   add constraint FK_JOB_HIST_DEPARTMEN_DEPARTME foreign key (DEPARTMENT_ID)
      references DEPARTMENTS (DEPARTMENT_ID)
      on delete set null on update restrict;

alter table JOB_HISTORY
   add constraint FK_JOB_HIST_EMPLOYEES_EMPLOYEE foreign key (EMPLOYEE_ID)
      references EMPLOYEES (EMPLOYEE_ID)
      on delete cascade on update restrict;

alter table JOB_HISTORY
   add constraint FK_JOB_HIST_JOBS_JOBH_JOBS foreign key (JOB_ID)
      references JOBS (JOB_ID)
      on delete restrict on update restrict;

alter table LOCATIONS
   add constraint FK_LOCATION_COUNTRIES_COUNTRIE foreign key (COUNTRY_ID)
      references COUNTRIES (COUNTRY_ID)
      on delete restrict on update restrict;

