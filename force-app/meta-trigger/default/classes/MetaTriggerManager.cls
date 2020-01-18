/**
 * Created by henryzhao on 2020-01-17.
 */

public class MetaTriggerManager {
    class MetaTriggerManagerException extends Exception {
    }

    private List<Trigger_Control__mdt> activeTriggerControls = new List<Trigger_Control__mdt>();
    private SObjectType objectFiringOn;
    private TriggerOperation dmlOperation;

    public MetaTriggerManager() {
        this.objectFiringOn = Trigger.isDelete ? Trigger.old.getSObjectType() : Trigger.new.getSObjectType();
        this.dmlOperation = Trigger.operationType;
        this.activeTriggerControls = MetaTriggerSelector.retrieveTriggerControls(this.objectFiringOn, this.dmlOperation);
    }

    public void start() {
        for (Trigger_Control__mdt tc : this.activeTriggerControls) {
            Callable dynamicClass = (Callable) Type.forName(tc.Apex_Class__c).newInstance();
            Object old, escapeNew;
            if (Trigger.oldMap == null) {
                old = Trigger.old;
            } else {
                old = Trigger.oldMap;
            }
            if (Trigger.newMap == null) {
                escapeNew = Trigger.new;
            } else {
                escapeNew = Trigger.newMap;
            }
            dynamicClass.call(tc.Method_Name__c, new Map<String, Object>{
                    'old' => old,
                    'new' => escapeNew
            });
        }
        System.debug(LoggingLevel.INFO, '##### MetaTriggerManager -> start -> before -> ' + Trigger.oldMap);
        System.debug(LoggingLevel.INFO, '##### MetaTriggerManager -> start -> after -> ' + Trigger.newMap);
        System.debug(LoggingLevel.INFO, '##### MetaTriggerManager -> start -> objectFiringOn -> ' + objectFiringOn);
        System.debug(LoggingLevel.INFO, '##### MetaTriggerManager -> start -> dmlOperation -> ' + dmlOperation);
        System.debug(LoggingLevel.INFO, '##### MetaTriggerManager -> start -> activeTriggerControls -> ' + activeTriggerControls);
    }

}