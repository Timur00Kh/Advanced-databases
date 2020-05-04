begin;
prepare my_ps (varchar) as insert into prepared_table (name)
                       values ($1);
execute my_ps('some name');
deallocate my_ps;
commit;




