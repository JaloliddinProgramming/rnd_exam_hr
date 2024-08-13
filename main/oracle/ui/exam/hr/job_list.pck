create or replace package Ui_Exam3 is
  ----------------------------------------------------------------------------------------------------
  Function Query_Jobs return Fazo_Query;
  ----------------------------------------------------------------------------------------------------  
  Procedure Del(p Hashmap);
end Ui_Exam3;
/
create or replace package body Ui_Exam3 is
  ----------------------------------------------------------------------------------------------------
  Function Query_Jobs return Fazo_Query is
    q Fazo_Query;
  begin
    q := Fazo_Query('select t.job_id,
                            t.job_name,
                            t.state
                       from hr_jobs t
                      where t.company_id = :company_id',
                    Fazo.Zip_Map('company_id', Ui.Company_Id));
  
    q.Number_Field('job_id');
    q.Varchar2_Field('job_name', 'state');
  
    q.Option_Field('state_name',
                   'state',
                   Array_Varchar2('A', 'P'),
                   Array_Varchar2(Ui.t_Active, Ui.t_Passive));
  
    return q;
  end;
  ----------------------------------------------------------------------------------------------------  
  Procedure Del(p Hashmap) is
    v_Job_Ids Array_Number := p.r_Array_Number('job_id');
  begin
    for i in 1 .. v_Job_Ids.Count
    loop
      Hr_Api.Job_Delete(i_Company_Id => Ui.Company_Id, i_Job_Id => v_Job_Ids(i));
    end loop;
  end;
end Ui_Exam3;
/
