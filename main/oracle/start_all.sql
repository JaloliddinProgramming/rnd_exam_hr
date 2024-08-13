set define off;
prompt ==== **start table** =====
prompt ==== CR =====
@@module\hr\setup\hr_table.sql
@@module\hr\setup\hr_sequence.sql

exec fazo_z.run;
@@start.sql;

prompt === **setting** ===
prompt ==== CR =====
@@module\hr\setup\hr_setting.sql;
