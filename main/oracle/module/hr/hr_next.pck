create or replace package Hr_Next is
  ----------------------------------------------------------------------------------------------------
  Function Job_Id return number;
end Hr_Next;
/
create or replace package body Hr_Next is
  ----------------------------------------------------------------------------------------------------
  Function Job_Id return number is
  begin
    return Hr_Jobs_Sq.Nextval;
  end;

end Hr_Next;
/
