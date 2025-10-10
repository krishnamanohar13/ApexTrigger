public with sharing class CaseUpdateHandler {
    public static void createCase(List<Case> caseList){
        if(!caseList.isEmpty() && caseList!=null){
            for(Case cl : caseList){
                if(cl.Origin == 'Email'){
                    cl.Status = 'New';
                    cl.Priority = 'Medium';
                }
            }
        }
    }
}