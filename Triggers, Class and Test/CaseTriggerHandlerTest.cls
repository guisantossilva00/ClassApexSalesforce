@isTest
public with sharing class CaseTriggerHandlerTest {

    @isTest
    private static void populateLastestCaseNumberTest() {
        List<Account> accList = new List<Account>();
        List<Case> caseList = new List<Case>();

        for (Integer i = 1; i < 5; i++) {
            Account acc = new Account();
            acc.Name = 'Test ' + 1;
            accList.add(acc);
        }

        insert accList;

        for (Account acc : accList) {
            Case cs = new Case();

            cs.Status = 'New';
            cs.Origin = 'Phone';
            cs.AccountId = acc.Id;
            caseList.add(cs);
        }
        
        Test.startTest();
            insert caseList;
        Test.stopTest();

        List<Account> updateAcc = [SELECT Id, Latest_Case_Number__c FROM Account
                                    WHERE Id =: accList[0].Id];
        
        List<Case> newCaseList = [SELECT Id, CaseNumber FROM Case WHERE Id =: caseList[0].Id];

        System.assertEquals(newCaseList[0].CaseNumber, updateAcc[0].Latest_Case_Number__c);
    }
}