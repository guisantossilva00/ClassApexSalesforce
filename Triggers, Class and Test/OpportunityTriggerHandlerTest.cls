@isTest
public with sharing class OpportunityTriggerHandlerTest {
    @isTest
    public static void updateDescriptionTest() {
        // Create Data
        List<Opportunity> oppList = new List<Opportunity>();

        for (Integer i = 1; i <= 5; i++) {
            Opportunity opp = new Opportunity();

            opp.Name = 'Test Opp ' + i;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today();
            opp.Amount = 200000;
            
            oppList.add(opp);
        }

        Test.startTest();
            insert oppList;
        Test.stopTest();

        List<Opportunity> updatedOppList = [SELECT Id, Description FROM Opportunity WHERE Id =: oppList[0].Id];

        System.assertEquals('Hot Opportunity', updatedOppList[0].Description);
    }

    @isTest
    private static void populateLatestOppAmtTest() {
        List<Account> accList = new List<Account>();
        List<Opportunity> oppList = new List<Opportunity>();

        for (Integer i = 1; i <= 5; i++) {
            Account acc = new Account();
            acc.Name = 'Test ' + 1;
            accList.add(acc);
        }

        insert accList;

        for (Account acc : accList) {
            Opportunity opp = new Opportunity();

            opp.Name = acc.Name;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today();
            opp.Amount = 200000;
            opp.AccountId = acc.Id;
            
            oppList.add(opp);
        }

        Test.startTest();
            insert oppList;
        Test.stopTest();

        List<Account> updatedAcc = [SELECT Id, Latest_Opp_Amount__c FROM Account WHERE Id =: accList[0].Id];

        System.assertEquals(200000, updatedAcc[0].Latest_Opp_Amount__c);
        System.assertEquals(oppList[0].Amount, updatedAcc[0].Latest_Opp_Amount__c);
    }
}