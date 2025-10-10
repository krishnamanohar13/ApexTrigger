public with sharing class AccountDescriptionUpdate {
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
}
//Example -- 8