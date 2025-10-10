public with sharing class ContactCreationIndustry {
    public static void createContact(List<Account> accList){
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
}
//Example -- 4
