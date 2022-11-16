trigger checkAddress on Contact (before insert,after insert) {
    List<Account> accsForUpdate = new List<Account>();
	Map<Id,Contact> mp = new Map<Id,Contact>(); 
  		for(Contact con :trigger.new){  
        	if(con.AccountId != null && con.Address__c != null){
     			mp.put(con.AccountId,con);
            }
  		}
    Map<Id, Account> mapIdAccount = new Map<Id, Account>([SELECT Id,Address__c, matchedContactId__c FROM Account WHERE Id IN:mp.KeySet()]); 
    
    if(Trigger.isBefore){
        for(Contact c: Trigger.new){
        if(c.Address__c  == mapIdAccount.get(c.AccountId).Address__c){
            c.hasSameAddress__c = true;
        }
    	}
    }
    
    if(Trigger.isAfter){
        for(Contact c: Trigger.new){          
        if(c.Address__c  == mapIdAccount.get(c.AccountId).Address__c){
            mapIdAccount.get(c.AccountId).matchedContactId__c = c.Id;
            accsForUpdate.add(mapIdAccount.values());
        }
		update accsForUpdate;
    }
    } 
}
