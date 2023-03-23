public with sharing class OpportunityTriggerHandler {

    public static void updateDescription(List<Opportunity> oppList) {
        for (Opportunity opp : oppList) {
            if (opp.Amount != null && opp.Amount >= 100000 && opp.Amount <= 500000) {
                opp.Description = 'Hot Opportunity';
            }
        }
    }

    public static void populateLatestOppAmt(List<Opportunity> oppList) {
        List<Account> accList = new List<Account>();

        for (Opportunity opp : oppList) {
            if (opp.Amount != null && opp.AccountId != null) {
                Account acc = new Account();
                acc.Id = opp.AccountId;
                acc.Latest_Opp_Amount__c = opp.Amount;

                accList.add(acc);
            }
        }

        if(!accList.isEmpty()) {
            update accList;
        }
    }
}