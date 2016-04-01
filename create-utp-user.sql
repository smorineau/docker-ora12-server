
create user utp identified by utp
default tablespace system
temporary tablespace temp;

grant create session, create table, create procedure,
      create sequence, create view, create public synonym,
      drop public synonym, execute any procedure
   to utp;

alter user utp quota unlimited on system;

exit