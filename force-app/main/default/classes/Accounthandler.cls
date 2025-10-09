public with sharing class Accounthandler {  
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
}