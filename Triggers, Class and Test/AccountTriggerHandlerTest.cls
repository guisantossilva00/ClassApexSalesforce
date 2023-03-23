@isTest
public with sharing class AccountTriggerHandlerTest {

    @isTest
    public static void createRelatedOppTest() {
        // Create Sample Data
        List<Account> accList = new List<Account>();

        for (Integer i = 1; i <= 5; i++) {
            Account acc = new Account();

            acc.Name = 'Test ' + i;
            accList.add(acc);
        }

        // insert data
        Test.startTest();
            insert accList;
        Test.stopTest();

        List<Opportunity> oppList = [SELECT Id FROM Opportunity WHERE AccountId =: accList[0].Id];

        System.assert(!oppList.isEmpty(), 'Opportunity is not created');
    }

    @isTest
    public static void createRelatedContactTest() {
        // Create Sample Data
        List<Account> accList = new List<Account>();

        for (Integer i = 1; i <= 5; i++) {
            Account acc = new Account();

            acc.Name = 'Test ' + i;
            accList.add(acc);
        }

        // insert data
        Test.startTest();
            insert accList;
        Test.stopTest();

        List<Contact> conList = [SELECT Id FROM Contact WHERE AccountId =: accList[0].Id];

        System.assert(!conList.isEmpty(), 'Contact is not created');
    }

    @isTest
    public static void copyBillingToShippingTest() {
        // Create Sample Data
        List<Account> accList = new List<Account>();

        for (Integer i = 1; i <= 5; i++) {
            Account acc = new Account();

            acc.Name = 'Test ' + i;
            acc.BillingCity = 'Test City';
            acc.BillingCountry = 'Test Country';
            acc.BillingPostalCode = '1234';
            acc.BillingState = 'Test State';
            acc.BillingStreet = 'Test Street';
            acc.CopyBillingToShipping__c = true;

            accList.add(acc);
        }

        // insert data
        Test.startTest();
            insert accList;
        Test.stopTest();

        List<Account> updatedAccList = [SELECT Id, ShippingCity FROM Account WHERE Id =: accList[0].Id];

        System.assertEquals('Test City', updatedAccList[0].ShippingCity);
    }
    
    @isTest
    public static void updateRatingTest() {
        // Create Sample Data
        List<Account> accList = new List<Account>();

        for (Integer i = 1; i <= 5; i++) {
            Account acc = new Account();

            acc.Name = 'Test ' + i;
            acc.Industry = 'Energy';
            accList.add(acc);
        }

        // insert data
        Test.startTest();
            insert accList;
        Test.stopTest();

        List<Account> updatedAccList = [SELECT Id, Rating FROM Account WHERE Id =: accList[0].id];

        // apply assert condition
        System.assertEquals('Hot', updatedAccList[0].Rating);
    }

    @isTest
    private static void createContactOrOpTest() {
        List<Account> accList = new List<Account>();

        for (Integer i = 1; i <= 10; i++) {
            Account acc = new Account();

            acc.Name = 'Test ' + i;

            if (Math.mod(i, 2) == 0) {
                acc.New_Contact__c = true;
            } else {
                acc.New_Opportunity__c = true;
                acc.Active__c = 'Yes';
            }
            accList.add(acc);
        }

        // insert data
        Test.startTest();
            insert accList;
        Test.stopTest();

        List<Contact> conList = [SELECT Id FROM Contact WHERE AccountId =: accList[0].Id];
        List<Opportunity> oppList = [SELECT Id FROM Opportunity WHERE AccountId =: accList[1].Id];

        System.assert(conList.isEmpty(), 'Contact is not created');
        System.assert(oppList.isEmpty(), 'Opportunity is not created');
    }
}