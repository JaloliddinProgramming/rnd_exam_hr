create or replace package Exam is
  ----------------------------------------------------------------------------------------------------
  Function Version return varchar2 deterministic;
  ----------------------------------------------------------------------------------------------------
  Function Project_Code return varchar2 deterministic;
end Exam;
/
create or replace package body Exam is
  ----------------------------------------------------------------------------------------------------
  Function Version return varchar2 deterministic is
  begin
    return '1.0.0';
  end;

  ----------------------------------------------------------------------------------------------------
  Function Project_Code return varchar2 deterministic is
  begin
    return 'exam';
  end;

end Exam;
/
