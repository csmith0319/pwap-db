--liquibase formatted sql

--changeset csmith0319:1
--comment: just testing liquibase
create table test (
    id int primary key auto_increment not null,
    name varchar(50) not null
)
--rollback DROP TABLE test;