/**
 * Created by henryzhao on 2020-01-17.
 */

trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    (new MetaTriggerManager()).start();
}