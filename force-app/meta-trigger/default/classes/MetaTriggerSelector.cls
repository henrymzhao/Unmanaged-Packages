/**
 * Created by henryzhao on 2020-01-17.
 */

public without sharing class MetaTriggerSelector {

    public static List<Trigger_Control__mdt> retrieveTriggerControls(SObjectType obj, TriggerOperation dmlOperation) {
        return [
                SELECT
                        Apex_Class__c,
                        DeveloperName,
                        DML_Operation__c,
                        Id,
                        Is_Active__c,
                        Label,
                        Language,
                        MasterLabel,
                        Method_Name__c,
                        NamespacePrefix,
                        Order_of_Execution__c,
                        QualifiedApiName,
                        SObject__c
                FROM Trigger_Control__mdt
                WHERE Is_Active__c = TRUE AND
                SObject__c = :obj.getDescribe().getName() AND
                DML_Operation__c = :String.valueOf(dmlOperation)
                ORDER BY Order_of_Execution__c ASC
        ];
    }
}