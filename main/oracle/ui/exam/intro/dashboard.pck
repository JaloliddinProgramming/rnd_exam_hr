create or replace package Ui_Exam2 is
  ----------------------------------------------------------------------------------------------------
  Function Query_Birth_Dates return Fazo_Query;
  ----------------------------------------------------------------------------------------------------
  Function Query_Top_10 return Fazo_Query;
  ----------------------------------------------------------------------------------------------------
  Function Query_Report_By_Gender return Fazo_Query;
end Ui_Exam2;
/
create or replace package body Ui_Exam2 is
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
    return b.Translate('UI-EXAM2:' || i_Message, i_P1, i_P2, i_P3, i_P4, i_P5);
  end;

  ----------------------------------------------------------------------------------------------------
  Function Query_Birth_Dates return Fazo_Query is
    q Fazo_Query;
  begin
    q := Fazo_Query('select p.name,
                            p.Photo_Sha,
                            w.gender,
                            case
                               when to_char(w.Birth_Date, ''dd-Month'') = to_char(sysdate, ''dd-Month'') then
                                ''Today''
                               else
                                to_char(w.Birth_Date, ''dd-Month'')
                             end Birth_Date
                       from Hr_Workers w
                       join Md_Persons p
                         on w.Worker_Id = p.Person_Id
                      where to_date(to_char(w.Birth_Date, ''DD-MON''), ''DD-MON'') between Trunc(sysdate) and
                            Trunc(sysdate) + 30
                      order by to_date(to_char(w.Birth_Date, ''DD-MON''), ''DD-MON''), p.name',
                    Fazo.Zip_Map('company_id', Ui.Company_Id));
  
    q.Varchar2_Field('name', 'photo_sha', 'birth_date', 'gender');
  
    return q;
  end;

  ----------------------------------------------------------------------------------------------------
  Function Query_Top_10 return Fazo_Query is
    q Fazo_Query;
  begin
    q := Fazo_Query('select p.Photo_Sha, p.Name, w.Gender, Rank() Over(order by(Score) desc) Place, s.Score
                       from (select Worker_Id, round(avg(Score)) Score
                               from Hr_Worker_Scores s
                              group by Worker_Id) s
                       join Md_Persons p
                         on s.Worker_Id = p.Person_Id
                       join Hr_Workers w
                         on s.Worker_Id = w.Worker_Id
                      order by Score desc, p.name',
                    Fazo.Zip_Map('company_id', Ui.Company_Id));
  
    q.Number_Field('place', 'score');
    q.Varchar2_Field('photo_sha', 'name', 'gender');
  
    return q;
  end;

  ----------------------------------------------------------------------------------------------------
  Function Query_Report_By_Gender return Fazo_Query is
    q Fazo_Query;
  begin
    q := Fazo_Query('with Worker_Cnt as
                  (select count(*)
                     from Hr_Workers),
                 Worker_Score as
                  (select sum(Score)
                     from Hr_Worker_Scores)
                 select p.Gender, p.Percent, s.Score
                   from (select Gender,
                                Round(count(Gender) / (select *
                                                         from Worker_Cnt) * 100) || ''%'' Percent
                           from Hr_Workers
                          group by Gender) p
                   join (select Gender,
                                Round(sum(Score) / (select *
                                                      from Worker_Score) * 100) || ''%'' Score
                           from Hr_Worker_Scores s
                           join Hr_Workers w
                             on s.Worker_Id = w.Worker_Id
                          group by Gender) s
                     on p.Gender = s.Gender',
                    Fazo.Zip_Map('company_id', Ui.Company_Id));
  
    q.Varchar2_Field('gender', 'percent', 'score');
    q.Option_Field('gender_name',
                   'gender',
                   Array_Varchar2('M', 'F'),
                   Array_Varchar2(t('Male'), --
                                  t('Female')));
  
    return q;
  end;

end Ui_Exam2;
/
