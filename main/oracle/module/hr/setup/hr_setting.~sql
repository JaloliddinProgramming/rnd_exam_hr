set define off
set serveroutput on
declare
  --------------------------------------------------
  Procedure Job
  (
    i_Company_Id number,
    i_Job_Id     number,
    i_Job_Name   varchar2
  ) is
  begin
    z_Hr_Jobs.Insert_One(i_Company_Id => i_Company_Id,
                         i_Job_Id     => i_Job_Id,
                         i_Job_Name   => i_Job_Name,
                         i_State      => 'A');
  end;
begin
  for r in (select *
              from Md_Companies t)
  loop
    Job(r.Company_Id, Hr_Next.Job_Id, 'Programmer');
    Job(r.Company_Id, Hr_Next.Job_Id, 'Teacher');
    Job(r.Company_Id, Hr_Next.Job_Id, 'Team Leader');
  end loop;

  commit;
end;
/
