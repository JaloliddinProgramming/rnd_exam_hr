create or replace package Ui_Exam5 is
  ----------------------------------------------------------------------------------------------------
  Function Query_Workers return Fazo_Query;
  ----------------------------------------------------------------------------------------------------
  Procedure Del(p Hashmap);
  ----------------------------------------------------------------------------------------------------
  Function Add_Score(p Hashmap) return Hashmap;
end Ui_Exam5;
/
create or replace package body Ui_Exam5 is
  ----------------------------------------------------------------------------------------------------
  Function Query_Workers return Fazo_Query is
    q Fazo_Query;
  begin
    q := Fazo_Query('select w.Company_Id,
                            w.Worker_Id,
                            w.Job_Id,
                            w.Gender,
                            w.Birth_Date,
                            p.Name,
                            p.Photo_Sha,
                            j.Job_Name
                       from Hr_Workers w
                       join Md_Persons p
                         on w.Worker_Id = p.Person_Id
                       join Hr_Jobs j
                         on w.Job_Id = j.Job_Id',
                    Fazo.Zip_Map('company_id', Ui.Company_Id));
  
    q.Number_Field('worker_id', 'job_id');
    q.Varchar2_Field('name', 'gender', 'job_name', 'photo_sha');
    q.Date_Field('birth_date');
  
    q.Option_Field('state_name',
                   'state',
                   Array_Varchar2('A', 'P'),
                   Array_Varchar2(Ui.t_Active, Ui.t_Passive));
  
    q.Option_Field('gender_name',
                   'state',
                   Array_Varchar2('M', 'F'),
                   Array_Varchar2('Male', 'Female'));
  
    q.Refer_Field(i_Name             => 'job_name',
                  i_For              => 'job_id',
                  i_Table_Name       => 'hr_jobs',
                  i_Code_Field       => 'job_id',
                  i_Name_Field       => 'job_name',
                  i_Table_For_Select => 'select * from hr_jobs j
                                          where j.company_id = :company_id
                                          order by job_name',
                  i_Manual_Sort      => false);
  
    return q;
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Del(p Hashmap) is
    v_Workers_Ids Array_Number := p.r_Array_Number('worker_id');
  begin
    for i in 1 .. v_Workers_Ids.Count
    loop
      Hr_Api.Worker_Delete(i_Company_Id => Ui.Company_Id, i_Worker_Id => v_Workers_Ids(i));
    end loop;
  end;

  ----------------------------------------------------------------------------------------------------
  Function Add_Score(p Hashmap) return Hashmap is
  begin
    Hr_Api.Worker_Score_Save(i_Company_Id => Ui.Company_Id,
                             i_Worker_Id  => p.r_Number('worker_id'),
                             i_Score      => p.r_Number('score'),
                             i_Note       => p.o_Varchar2('note'));
    return Fazo.Zip_Map('worker_id', p.r_Number('worker_id'), 'score', p.r_Number('score'));
  end;

end Ui_Exam5;
/
