//Implementing a trigger, only the system admin user should be able to delete the task
public class TaskHandler {
    public static void preventDeletions(List<Task> taskList){
        System.debug('List of old vales --->'+ taskList);
        String name =  [SELECT Name FROM Profile WHERE Id = :UserInfo.getProfileId()].Name;
        if(taskList == null || taskList.isEmpty()){
            return;
        }
        for(Task ts : taskList){
            if(name != 'System Administrator'){
                ts.addError('You are not deleted it');
            }
        }
    }
}