--liquibase formatted sql

--changeset csmith0319:1
--comment: debugging github actions
alter table test (
    id int primary key auto_increment not null,
    name varchar(50) not null
)