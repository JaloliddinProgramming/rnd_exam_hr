set define off
prompt PATH /exam/hr/workers
begin
uis.route('/exam/hr/workers+add:model','Ui_Exam4.Add_Model',null,'M','A','Y',null,null,null,'S','N',null,null);
uis.route('/exam/hr/workers+add:save','Ui_Exam4.Add','M','M','A',null,null,null,null,'S','N',null,null);
uis.route('/exam/hr/workers+edit:model','Ui_Exam4.Edit_Model','M','M','A','Y',null,null,null,'S','N',null,null);
uis.route('/exam/hr/workers+edit:save','Ui_Exam4.Ecit','M','M','A',null,null,null,null,'S','N',null,null);

uis.path('/exam/hr/workers','exam4');
uis.form('/exam/hr/workers+add','/exam/hr/workers','A','A','F','H','M','N',null,'N','S');
uis.form('/exam/hr/workers+edit','/exam/hr/workers','A','A','F','H','M','N',null,'N','S');





uis.ready('/exam/hr/workers+add','.model.');
uis.ready('/exam/hr/workers+edit','.model.');

commit;
end;
/
