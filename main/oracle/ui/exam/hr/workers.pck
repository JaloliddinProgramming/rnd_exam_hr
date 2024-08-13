create or replace package Ui_Exam4 is
  ----------------------------------------------------------------------------------------------------
  Function Jobs_Query return Fazo_Query;
  ----------------------------------------------------------------------------------------------------
  Function Add_Model return Hashmap;
  ----------------------------------------------------------------------------------------------------
  Function Edit_Model(p Hashmap) return Hashmap;
  ----------------------------------------------------------------------------------------------------
  Function Add(p Hashmap) return Hashmap;
  ----------------------------------------------------------------------------------------------------
  Function Edit(p Hashmap) return Hashmap;
end Ui_Exam4;
/
create or replace package body Ui_Exam4 is
  ----------------------------------------------------------------------------------------------------
  Function Jobs_Query return Fazo_Query is
    q Fazo_Query;
  begin
    q := Fazo_Query('hr_jobs', Fazo.Zip_Map('company_id', Ui.Company_Id, 'state', 'A'));
  
    q.Number_Field('job_id');
    q.Varchar2_Field('job_name', 'state');
    return q;
  end;

  ----------------------------------------------------------------------------------------------------
  Function References return Hashmap is
    v_Matrix Matrix_Varchar2;
    result   Hashmap;
  begin
    select Array_Varchar2(j.Job_Id, j.Job_Name)
      bulk collect
      into v_Matrix
      from Hr_Jobs j
     where j.Company_Id = Ui.Company_Id
       and j.State = 'A'
     order by j.Job_Name;
  
    result := Hashmap();
  
    Result.Put('jobs', Fazo.Zip_Matrix(v_Matrix));
  
    return result;
  end;

  ----------------------------------------------------------------------------------------------------
  Function Add_Model return Hashmap is
    result Hashmap;
  begin
    result := Fazo.Zip_Map('state', 'A');
  
    Result.Put('references', References);
  
    return result;
  end;

  ----------------------------------------------------------------------------------------------------
  Function Edit_Model(p Hashmap) return Hashmap is
    r_Person Md_Persons%rowtype;
    r_Worker Hr_Workers%rowtype;
    result   Hashmap;
  begin
    r_Person := z_Md_Persons.Load(i_Company_Id => Ui.Company_Id,
                                  i_Person_Id  => p.r_Number('worker_id'));
    r_Worker := z_Hr_Workers.Load(i_Company_Id => Ui.Company_Id, i_Worker_Id => r_Person.Person_Id);
  
    result := z_Hr_Workers.To_Map(r_Worker, z.Worker_Id, z.Gender, z.Birth_Date);
  
    Result.Put('name', r_Person.Name);
    Result.Put('selected_job_name',
               z_Hr_Jobs.Load(i_Company_Id => r_Worker.Company_Id, i_Job_Id => r_Worker.Job_Id).Job_Name);
    Result.Put('selected_job_id',
               z_Hr_Jobs.Load(i_Company_Id => r_Worker.Company_Id, i_Job_Id => r_Worker.Job_Id).Job_Id);
    Result.Put('photo_sha', r_Person.Photo_Sha);
    Result.Put('references', References);
  
    return result;
  end;

  ----------------------------------------------------------------------------------------------------
  Function Add(p Hashmap) return Hashmap is
    v_Worker_Id number := Md_Next.Person_Id;
  begin
    Hr_Api.Worker_Save(i_Company_Id => Ui.Company_Id,
                       i_Worker_Id  => v_Worker_Id,
                       i_Name       => p.r_Varchar2('name'),
                       i_Job_Id     => p.r_Number('selected_job_id'),
                       i_Photo_Sha  => p.o_Varchar2('photo_sha'),
                       i_Gender     => p.r_Varchar2('gender'),
                       i_Birth_Date => p.o_Date('birth_date'));
  
    return Fazo.Zip_Map('worker_id', v_Worker_Id, 'name', p.r_Varchar2('name'));
  end;

  ----------------------------------------------------------------------------------------------------
  Function Edit(p Hashmap) return Hashmap is
  begin
    Hr_Api.Worker_Save(i_Company_Id => Ui.Company_Id,
                       i_Worker_Id  => p.r_Number('worker_id'),
                       i_Name       => p.r_Varchar2('name'),
                       i_Job_Id     => p.r_Number('selected_job_id'),
                       i_Photo_Sha  => p.o_Varchar2('photo_sha'),
                       i_Gender     => p.r_Varchar2('gender'),
                       i_Birth_Date => p.o_Date('birth_date'));
  
    return Fazo.Zip_Map('worker_id', p.r_Number('worker_id'), 'name', p.r_Varchar2('name'));
  end;

end Ui_Exam4;
/
