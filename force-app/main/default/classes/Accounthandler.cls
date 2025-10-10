public with sharing class Accounthandler {  
    public static void createOpporunity(List<Account> accList){
        List<Opportunity> oppoList = new List<Opportunity>();
        if(accList == null || accList.isEmpty()){
            return ;
        }
        for(Account acc : accList){
            Opportunity oppo = new Opportunity();
            oppo.Name = acc.Name;
            oppo.AccountId = acc.Id;
            oppo.StageName = 'Prospecting';
            oppo.CloseDate = Date.today();
            oppoList.add(oppo);
        }
        if(!oppoList.isEmpty()){
            insert oppoList;
        }
    }

      public static void objectCheckbox(List<Account> accList){
        List<Contact> conLister = new List<Contact>();
        List<Opportunity> oppoList = new List<Opportunity>();
        if(accList == null || accList.isEmpty()){
            return ;
        }
        for(Account acc: accList){
            if(acc.Contact__c == true){
                Contact con = new Contact();
                con.LastName = acc.Name;
                con.AccountId = acc.Id;
                conLister.add(con);
            }
            if(acc.Opporunity__c == true && acc.Activated_picklist__c == 'Yes'){
                Opportunity oppo = new Opportunity();
                oppo.Name = acc.Name;
                oppo.AccountId = acc.Id;
                oppo.StageName = 'Prospecting';
                oppo.CloseDate = Date.today();
                oppoList.add(oppo);
            }
        }
        if(!conLister.isEmpty()){
            insert conLister;
        }
        if(!oppoList.isEmpty()){
            insert oppoList;
        }
    }

    
    // If the Account phone is updated then populate below message in  description
    public static void updateDescription(List<Account> accList,Map<Id,Account> oldMap){
        if(accList == null || accList.isEmpty()){
            return ;
        }
        for(Account acc : accList){
            Account oldAcc = oldMap.get(acc.Id);
            System.debug('old --->'+ oldAcc.Phone);
            if(acc.Phone != oldAcc.Phone){
                acc.Description = 'Phone number has been updated with '+ acc.Phone + 'with ' + oldAcc.Phone;
            }
        }
    }

    //Duplicate Names are not allowed and Add Error()
    public static void duplicateNames(List<Account> accList){
        Map<String,Account> accMap = new Map<String,Account>();
        if(accList == null || accList.isEmpty()){
            return ;
        }
        List<Account> accNames = [Select Id,Name FROM Account ];
        for(Account acc: accNames){
            accMap.put(acc.Name,acc);
        }
        System.debug('Map --->'+ accMap);
        for(Account accl : accList){
            if(accMap.containsKey(accl.Name)){
                accl.addError('Duplicate Names are not allowed');
            }
        }
    }

    // If the Account phone is updated then populate the phone number on all related Contacts 
    public static void updatePhone(List<Account> accList){
        Map<Id,String> accMap = new Map<Id,String>();
        if(accList == null || accList.isEmpty()){
            return ;
        }
        for(Account acc : accList){
            if(acc.Phone !=null){
                accMap.put(acc.Id,acc.Phone);
            }
        }
        if(!accMap.isEmpty()){
            List<Contact> conList = [Select Id,Name,Phone,AccountId FROM Contact where AccountId IN:accMap.keySet()];
            for(Contact con : conList){
                if(accMap.containsKey(con.AccountId)){
                    con.Phone = accMap.get(con.AccountId);
                }
            }
            if(!conList.isEmpty()){
                update conList;
            }
        }
    }
//    If the Account billing address is updated then update related contacts mailing address
    public static void updateMailingAddress(List<Account> accList){
       Map<Id,Address> accMap = new Map<Id,Address>();
        if(accList == null || accList.isEmpty()){
            return ;
        }
        System.debug('COming');
        System.debug('accList-=-=-=-->'+ accList);
        System.debug('accList--->'+ accList.size());
        for(Account acc : accList){
            if(acc.BillingAddress != null && acc.BillingAddress != null ){
            }
            System.debug('Account --->'+ acc.BillingAddress);
            accMap.put(acc.Id,acc.BillingAddress);
        }
        System.debug('List of Account --->'+ accMap);
        if(accMap.isEmpty()){
            return ;
        }
        List<Contact> conLister = [Select Id,LastName,MailingAddress,AccountId FROM Contact WHERE AccountId IN:accMap.keySet()];
        for(Contact con : conLister){
            if(accMap.containsKey(con.AccountId)){

            }
        }
        if(!conLister.isEmpty()){
            update conLister;
        }
    }
    
    //prevent deletion of Account if checkbox is true
    public static void preventDeletions(List<Account> accList){
        System.debug('Triggerold --->'+ accList);
        if(accList ==null  && accList.isEmpty()){
            return ;
        }
        for(Account acc : accList){
            if(acc.PreventDeletion__c == true){
                acc.addError('Please dont delete this records');
            }
        }
    }
    //Implementing a trigger, if the owner of an account is changed then the owner for the related contacts should also be updated
    public static void updateOwner(List<Account> accList){
        Map<Id,Id> accMap = new Map<Id,Id>();
        if(accList == null || accList.isEmpty()){
            return ;
        }
        for(Account acc : accList){
            if(acc.OwnerId !=null || acc.Id!=null){
                accMap.put(acc.Id,acc.OwnerId);
            }
        }
        System.debug('Map of owners changes --->'+ accMap);
        List<Contact> conList = [Select Id,LastName,OwnerId,AccountId FROM Contact WHERE Id IN:accMap.keySet()];
        for(Contact con : conList){
            if(accMap.containsKey(con.AccountId)){
                con.OwnerId = accMap.get(con.AccountId);
            }
        }
        if(!conList.isEmpty()){
            update conList;
        }
    }
}