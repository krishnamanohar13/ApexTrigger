public with sharing class CopyBillingToShipping {
    public static void updateDescription(List<Account> accList){
        if(accList == null || accList.isEmpty()){
            return;
        }
        if(accList != null && !accList.isEmpty()){
            for(Account acc : accList){
                if(acc.DescriptionCheckBox__c == true && acc.BillingCountry != null && acc.BillingAddress !=null && acc.BillingCity != null && acc.BillingState != null && acc.BillingPostalCode != null){
                    acc.ShippingCountry = acc.BillingCountry;
                    acc.ShippingStreet = acc.BillingStreet;
                    acc.ShippingCity = acc.BillingCity;
                    acc.BillingState = acc.BillingState;
                    acc.BillingPostalCode = acc.BillingPostalCode;
                }
            }
        }
    }
}