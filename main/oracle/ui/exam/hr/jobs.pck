create or replace package Ui_Exam1 is
  ----------------------------------------------------------------------------------------------------
  Function Add_Model return Hashmap;
  ----------------------------------------------------------------------------------------------------
  Function Edit_Model(p Hashmap) return Hashmap;
  ----------------------------------------------------------------------------------------------------
  Function Add(p Hashmap) return Hashmap;
  ----------------------------------------------------------------------------------------------------
  Function Edit(p Hashmap) return Hashmap;
end Ui_Exam1;
/
create or replace package body Ui_Exam1 is
  ----------------------------------------------------------------------------------------------------
  Function Add_Model return Hashmap is
  begin
    return Fazo.Zip_Map('state', 'A');
  end;

  ----------------------------------------------------------------------------------------------------  
  Function Edit_Model(p Hashmap) return Hashmap is
    r_Data Hr_Jobs%rowtype;
  begin
    r_Data := z_Hr_Jobs.Load(i_Company_Id => Ui.Company_Id, i_Job_Id => p.r_Number('job_id'));
    
    return z_Hr_Jobs.To_Map(r_Data, z.Job_Id, z.Job_Name, z.State);
  end;

  ----------------------------------------------------------------------------------------------------  
  Function Add(p Hashmap) return Hashmap is
    r_Data Hr_Jobs%rowtype;
  begin
    z_Hr_Jobs.To_Row(r_Data, p, z.Job_Name, z.State);
  
    r_Data.Company_Id := Ui.Company_Id;
    r_Data.Job_Id     := Hr_Next.Job_Id;
  
    Hr_Api.Job_Save(r_Data);
  
    return Fazo.Zip_Map('job_id', r_Data.Job_Id, 'job_name', r_Data.Job_Name);
  end;

  ----------------------------------------------------------------------------------------------------  
  Function Edit(p Hashmap) return Hashmap is
    r_Data Hr_Jobs%rowtype;
  begin
    r_Data          := z_Hr_Jobs.Lock_Load(i_Company_Id => Ui.Company_Id,
                                           i_Job_Id     => p.r_Number('job_id'));
    r_Data.Job_Name := p.r_Varchar2('job_name');
    r_Data.State    := p.r_Varchar2('state');
  
    Hr_Api.Job_Save(r_Data);
  
    return Fazo.Zip_Map('job_id', r_Data.Job_Id, 'job_name', r_Data.Job_Name);
  end;

end Ui_Exam1;
/
