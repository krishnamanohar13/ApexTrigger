
public with sharing class Accounthandler {
   // Whenever New Account Record is created then needs to create associated Contact Record automatically.
       public static void  createContact(List<Account> accList){
        List<Contact> conLister = new List<Contact>();
        if(!accList.isEmpty() && accList!=null){
            for(Account acc : accList){
                Contact con = new Contact();
                con.LastName = acc.Name;
                con.AccountId = acc.Id;
                conLister.add(con);
            }
        }
        if(!conLister.isEmpty()){
            try{
                insert conLister;
            }
            catch(Exception e){
                System.debug('It is  Message '+ e.getMessage());
            }
        }
    }

    trigger AccountHandlerTrigger on Account (after insert){
        if(Trigger.isAfter && Trigger.isInsert){
            Accounthandler.createContact(Trigger.new);
        }
    }

    // When ever the Account is created with Industry as Banking then create a contact for account, Contact Lastname as Account name and contact phone as account phone.
    public static void populateValue(List<Account> accList){
        List<Contact> conLister = new List<Contact>();
        if(!accList.isEmpty() && accList!=null){
            for(Account acc : accList){
                if(acc.Industry == 'Banking'){
                    Contact con = new Contact();
                    con.LastName = acc.Name;
                    con.Phone = acc.Phone;
                    con.AccountId = acc.Id;
                    conLister.add(con);
                }
            }
        }
        if(!conLister.isEmpty()){
            insert conLister;
        }
    }

    trigger AccountHandlerTrigger on Account (after insert) {
        if(Trigger.isAfter && Trigger.isInsert){
            Accounthandler.createContact(Trigger.new); 
        }
    }


    // Creates the number of contacts which are equal to the number which we will enter in the Number of Locations field on the Account Object.
     public static void numberofConatcts(List<Account> accList){
        if(accList == null || accList.isEmpty()){
            return ;
        }
        List<Contact> conToInsert = new List<Contact>();
        for(Account acc : accList){
            if(acc.NumberofLocations__c !=null && acc.NumberofLocations__c > 0){
                Decimal noOfContacts = Integer.valueOf(acc.NumberofLocations__c);
                for(Integer k = 0 ; k < noOfContacts ; k++){
                    Contact con = new Contact();
                    con.LastName = acc.Name + k;
                    con.AccountId = acc.Id;
                    conToInsert.add(con);
                }
            }
        }
        if(!conToInsert.isEmpty()){
            insert conToInsert;
        }
    }
    

    // When an account inserts and CopyBillingToShipping (Custom Field) checkbox is checked then automatically copy account billing address into account shipping address.
    public static void updateDescription(List<Account> accList){
        if(accList == null || accList.isEmpty()){
            return;
        }
        for(Account acc : accList){
            if(acc.DescriptionCheckBox__c == true){
                acc.ShippingCountry = acc.BillingCountry;
                acc.ShippingStreet = acc.BillingStreet;
                acc.ShippingCity = acc.BillingCity;
                acc.BillingState = acc.BillingState;
                acc.BillingPostalCode = acc.BillingPostalCode;
            }
        }
    }
    //Upon Account Creation if Industry is not null and having value as Media then populate Rating as Hot
    public static void updateRating(List<Account> accList){
        if(accList == null || accList.isEmpty()){
            return ;
        }
        for(Account acc : accList){
            if(acc.Industry == 'Media' && acc.Industry!=null){
                System.debug('Incoming');
                acc.Rating = 'Hot';
            }
        }
    }

    //Create a related Opportunity when an Account is created.
    public static void createOpporunity(List<Account> accList){
        List<Opportunity> oppoList = new List<Opportunity>();
        if(accList == null || accList.isEmpty()){
            return ;
        }
        for(Account acc : accList){
            Opportunity oppo = new Opportunity();
            oppo.Name = acc.Name;
            oppo.StageName = 'Prospecting';
            oppo.CloseDate = Date.today();
            oppo.AccountId = acc.Id;
            oppoList.add(oppo);
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

    // If the Checkbox is true of the contact create contact record related of Account and checkbox is true and custom field of Account is yes then create the Opporunity of related Account
    public static void objectCheckbox(List<Account> accList){
        List<Contact> conLister = new List<Contact>();
        List<Opportunity> oppoList = new List<Opportunity>();

        if(accList == null || accList.isEmpty()){
            return ;
        }
        for(Account acc: accList){
            if(acc.Contact__c == true){
                System.debug('Incoming');
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