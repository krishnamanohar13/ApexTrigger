public with sharing class OpporunityStageUpdateHandler {
    public static void updateStage(List<Opportunity> newList){
        if(newList == null || newList.isEmpty()){
            return ;
        }
        Map<String, String> stageDescMap = new Map<String, String>{'Closed Lost' => 'Closed Lost','Closed Won' => 'Closed Won','Open' => 'Opp is Open','Qualification' => 'Qualification','Needs Analysis' => 'Needs Analysis',
        'Value Proposition' => 'Value Proposition','Identify Decision Makers' => 'Identify Decision Makers','Perception Analysis' => 'Perception Analysis','Proposal/Price Quote' => 'Proposal/Price Quote','Negotiation/Review' => 'Negotiation/Review'};
        for(Opportunity oppo : newList){
            if(oppo.StageName != null && stageDescMap.containsKey(oppo.StageName)){
                oppo.Description = stageDescMap.get(oppo.StageName);
            }
        }
    }
}