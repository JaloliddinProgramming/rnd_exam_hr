set define off
prompt PATH /exam/intro/dashboard
begin
uis.route('/exam/intro/dashboard:birth_days','Ui_Exam2.Query_Birth_Dates',null,'Q','A',null,null,null,null,'S','N',null,null);
uis.route('/exam/intro/dashboard:model','Ui.No_Model',null,null,'A','Y',null,null,null,'S','N',null,null);
uis.route('/exam/intro/dashboard:report_by_gender','Ui_Exam2.Query_Report_By_Gender',null,'Q','A',null,null,null,null,'S','N',null,null);
uis.route('/exam/intro/dashboard:top_scores','Ui_Exam2.Query_Top_10',null,'Q','A',null,null,null,null,'S','N',null,null);

uis.path('/exam/intro/dashboard','exam2');
uis.form('/exam/intro/dashboard','/exam/intro/dashboard','A','A','F','H','M','N',null,'N','S');





uis.ready('/exam/intro/dashboard','.model.');

commit;
end;
/
