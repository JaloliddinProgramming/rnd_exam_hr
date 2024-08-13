prompt ==== **start exam** =====
@@setup\exam.pck;

prompt ==== MR ====
@@module\hr\hr_next.pck;

exec fazo_z.Compile_Invalid_Objects;

prompt ==== INIT ====
@@setup\init\project.sql;

@@start_ui.sql;
@@start_uis.sql;
