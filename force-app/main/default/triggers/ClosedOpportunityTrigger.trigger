trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    Boolean afterInsert = Trigger.isAfter && Trigger.isInsert;
    boolean afterUpdate = Trigger.isAfter && Trigger.isUpdate;

    List<Task> taskList = new List<Task>();
    if(afterInsert || afterUpdate){
        for(Opportunity opp : Trigger.new){
            if(opp.StageName == 'Closed Won'){
                taskList.add(new Task(
                    Subject = 'Follow Up Test Task',
                    WhatId = opp.Id
                ));
            }
        }

        if(taskList.size() > 0){
            insert taskList;
        }
    }
}