trigger CaseTrigger on Case (after insert) {

    CaseTriggerHandler.populateLastestCaseNumber(Trigger.New);
}