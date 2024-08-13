set define off
prompt PATH /exam/hr/jobs
begin
uis.route('/exam/hr/jobs+add:model','Ui_Exam1.Add_Model',null,'M','A','Y',null,null,null,'S','N',null,null);
uis.route('/exam/hr/jobs+add:save','Ui_Exam1.Add','M','M','A',null,null,null,null,'S','N',null,null);
uis.route('/exam/hr/jobs+edit:model','Ui_Exam1.Edit_Model','M','M','A','Y',null,null,null,'S','N',null,null);
uis.route('/exam/hr/jobs+edit:save','Ui_Exam1.Edit','M','M','A',null,null,null,null,'S','N',null,null);

uis.path('/exam/hr/jobs','exam1');
uis.form('/exam/hr/jobs+add','/exam/hr/jobs','A','A','F','H','M','N',null,'N','S');
uis.form('/exam/hr/jobs+edit','/exam/hr/jobs','A','A','F','H','M','N',null,'N','S');





uis.ready('/exam/hr/jobs+edit','..');
uis.ready('/exam/hr/jobs+add','.model.');

commit;
end;
/
