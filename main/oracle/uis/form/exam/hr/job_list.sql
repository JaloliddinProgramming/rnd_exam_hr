set define off
prompt PATH /exam/hr/job_list
begin
uis.route('/exam/hr/job_list$delete','Ui_Exam3.Del','M',null,'A',null,null,null,null,'S','N',null,null);
uis.route('/exam/hr/job_list:jobs','Ui_Exam3.Query_Jobs',null,'Q','A',null,null,null,null,'S','N',null,null);
uis.route('/exam/hr/job_list:model','Ui.No_Model',null,null,'A','Y',null,null,null,'S','N',null,null);

uis.path('/exam/hr/job_list','exam3');
uis.form('/exam/hr/job_list','/exam/hr/job_list','A','A','F','H','M','N',null,'N','S');



uis.action('/exam/hr/job_list','add','A','/exam/hr/jobs+add','S','O');
uis.action('/exam/hr/job_list','delete','A',null,null,'A');
uis.action('/exam/hr/job_list','edit','A','/exam/hr/jobs+edit','S','O');


uis.ready('/exam/hr/job_list','.add.delete.edit.model.');

commit;
end;
/
