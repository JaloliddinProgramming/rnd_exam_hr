set define off
prompt PATH /exam/hr/worker_list
begin
uis.route('/exam/hr/worker_list$delete','Ui_Exam5.Del','M',null,'A',null,null,null,null,'S','N',null,null);
uis.route('/exam/hr/worker_list:model','Ui.No_Model',null,null,'A','Y',null,null,null,'S','N',null,null);
uis.route('/exam/hr/worker_list:save','Ui_Exam5.Add_Score','M','M','A',null,null,null,null,'S','N',null,null);
uis.route('/exam/hr/worker_list:workers','Ui_Exam5.Query_Workers',null,'Q','A',null,null,null,null,'S','N',null,null);

uis.path('/exam/hr/worker_list','exam5');
uis.form('/exam/hr/worker_list','/exam/hr/worker_list','A','A','F','H','M','N',null,'N','S');



uis.action('/exam/hr/worker_list','add','A','/exam/hr/workers+add','S','O');
uis.action('/exam/hr/worker_list','delete','A',null,null,'A');
uis.action('/exam/hr/worker_list','edit','A','/exam/hr/workers+edit','S','O');


uis.ready('/exam/hr/worker_list','..');

commit;
end;
/
