trigger OrderEventTrigger on Order_Event__e (after insert) {
	List<Task> tasks = new List<Task>();
    
    for(Order_Event__e oEvent : Trigger.new){
        if(oEvent.Has_Shipped__c == true){
            Task t = new Task();
            t.priority = 'Medium';
            t.Subject = 'Follow up on shipped order 105';
            t.OwnerId = oEvent.CreatedById;
            tasks.add(t);
        }
    }
    insert tasks;
}