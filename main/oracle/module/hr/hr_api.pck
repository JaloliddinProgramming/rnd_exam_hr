create or replace package Hr_Api is
  ----------------------------------------------------------------------------------------------------
  Procedure Job_Save(i_Job Hr_Jobs%rowtype);
  ----------------------------------------------------------------------------------------------------
  Procedure Job_Delete
  (
    i_Company_Id number,
    i_Job_Id     number
  );
  ----------------------------------------------------------------------------------------------------
  Procedure Worker_Save
  (
    i_Company_Id number,
    i_Worker_Id  number,
    i_Name       varchar2,
    i_Job_Id     number,
    i_Photo_Sha  varchar2,
    i_Gender     varchar2,
    i_Birth_Date date
  );
  ----------------------------------------------------------------------------------------------------
  Procedure Worker_Delete
  (
    i_Company_Id number,
    i_Worker_Id  number
  );
  ----------------------------------------------------------------------------------------------------
  Procedure Worker_Score_Save
  (
    i_Company_Id number,
    i_Worker_Id  number,
    i_Score      number,
    i_Note       varchar2
  );
end Hr_Api;
/
create or replace package body Hr_Api is
  ----------------------------------------------------------------------------------------------------
  Function t
  (
    i_Message varchar2,
    i_P1      varchar2 := null,
    i_P2      varchar2 := null,
    i_P3      varchar2 := null,
    i_P4      varchar2 := null,
    i_P5      varchar2 := null
  ) return varchar2 is
  begin
    return b.Translate('HR:' || i_Message, i_P1, i_P2, i_P3, i_P4, i_P5);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Job_Save(i_Job Hr_Jobs%rowtype) is
  begin
    z_Hr_Jobs.Save_Row(i_Job);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Job_Delete
  (
    i_Company_Id number,
    i_Job_Id     number
  ) is
  begin
    z_Hr_Jobs.Delete_One(i_Company_Id => i_Company_Id, i_Job_Id => i_Job_Id);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Worker_Save
  (
    i_Company_Id number,
    i_Worker_Id  number,
    i_Name       varchar2,
    i_Job_Id     number,
    i_Photo_Sha  varchar2,
    i_Gender     varchar2,
    i_Birth_Date date
  ) is
  begin
    if i_Name is null then
      b.Raise_Error(t('Name is required!'));
    end if;
  
    if i_Job_Id is null then
      b.Raise_Error(t('Job is required!'));
    end if;
  
    Md_Api.Person_Save(i_Company_Id => i_Company_Id,
                       i_Person_Id  => i_Worker_Id,
                       i_Name       => i_Name,
                       i_State      => 'A',
                       i_Photo_Sha  => i_Photo_Sha,
                       Is_Legal     => false);
  
    z_Hr_Workers.Save_One(i_Company_Id => i_Company_Id,
                          i_Worker_Id  => i_Worker_Id,
                          i_Job_Id     => i_Job_Id,
                          i_Gender     => i_Gender,
                          i_Birth_Date => i_Birth_Date);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Worker_Delete
  (
    i_Company_Id number,
    i_Worker_Id  number
  ) is
  begin
    z_Hr_Workers.Delete_One(i_Company_Id => i_Company_Id, i_Worker_Id => i_Worker_Id);
    z_Md_Persons.Delete_One(i_Company_Id => i_Company_Id, i_Person_Id => i_Worker_Id);
  end;

  ----------------------------------------------------------------------------------------------------
  Procedure Worker_Score_Save
  (
    i_Company_Id number,
    i_Worker_Id  number,
    i_Score      number,
    i_Note       varchar2
  ) is
  begin
    if i_Score is null then
      b.Raise_Error(t('Score must be filled!'));
    end if;
    if i_Score > 100 or i_Score < 0 then
      b.Raise_Error(t('Invalid score input!'));
    end if;
    z_Hr_Worker_Scores.Insert_One(i_Company_Id => i_Company_Id,
                                  i_Worker_Id  => i_Worker_Id,
                                  i_Score      => i_Score,
                                  i_Note       => i_Note);
  end;
end Hr_Api;
/
