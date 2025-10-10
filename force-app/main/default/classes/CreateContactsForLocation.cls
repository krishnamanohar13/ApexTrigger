public with sharing class CreateContactsForLocation {
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
}