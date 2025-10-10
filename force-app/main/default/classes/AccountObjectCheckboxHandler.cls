public class AccountObjectCheckboxHandler {
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
}