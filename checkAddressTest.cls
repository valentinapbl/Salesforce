@isTest
private class checkAddressTest {
@isTest static void TestCheckAddress() {
    
        Account acct = new Account(Name='Test Account', Address__c='Street Example');
        insert acct;
        Contact con = new Contact(LastName=acct.Name + 'Contact',
                                  AccountId=acct.Id,
                                  Address__c='Street Example');
		insert con;
    	acct = [SELECT Id, matchedContactId__c FROM Account WHERE Id = :acct.Id];
    	con =  [SELECT Id, hasSameAddress__c  FROM Contact WHERE Id =: con.Id];
   		
    	System.assertEquals(acct.matchedContactId__c,con.Id);
    	System.assertEquals(CON.hasSameAddress__c,true);
    }
}
