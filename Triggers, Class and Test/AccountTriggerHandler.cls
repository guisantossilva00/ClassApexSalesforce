public with sharing class AccountTriggerHandler {

    public static void updateRating(List<Account> accList) {
        for(Account acc : accList) {
            if(acc.Industry == 'Media' || acc.Industry == 'Energy') {
                acc.Rating = 'Hot';
            }
        }
    }

    public static void copyBillingToShipping(List<Account> accList) {
        for (Account acc : accList) {
            if (acc.CopyBillingToShipping__c && acc.BillingCity != null) {
                acc.ShippingCity = acc.BillingCity;
                acc.ShippingCountry = acc.BillingCountry;
                acc.ShippingPostalCode = acc.BillingPostalCode;
                acc.ShippingState = acc.BillingState;
                acc.ShippingStreet = acc.BillingStreet;
            }
        }
    }

    public static void createRelatedOpp(List<Account> accList) {
        List<Opportunity> oppList = new List<Opportunity>();

        for (Account acc : accList) {
            Opportunity opp = new Opportunity();

            opp.Name = acc.Name;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today();
            opp.AccountId = acc.Id;

            oppList.add(opp);
        }

        if (!oppList.isEmpty()) {
            insert oppList;
        }
    }

    public static void createRelatedContact(List<Account> accList) {
        List<Contact> conList = new List<Contact>();

        for (Account acc : accList) {
            Contact con = new Contact();

            con.FirstName = 'Test FName';
            con.LastName = 'Test LName ' + acc.Name;
            con.AccountId = acc.Id;

            conList.add(con);
        }

        if (!conList.isEmpty()) {
            insert conList;
        }
    }

    public static void createContactOrOp(List<Account> accList) {
        List<Contact> conList = new List<Contact>();
        List<Opportunity> oppList = new List<Opportunity>();

        for (Account acc : accList) {
            // Contact
            if (acc.New_Contact__c) {
                Contact con = new Contact();

                con.FirstName = 'Test ' + acc.Name;
                con.LastName = 'Test ' + acc.Name;
                con.AccountId = acc.Id;

                conList.add(con);
            }

            // Opportunity
            if (acc.New_Opportunity__c && acc.Active__c == 'Yes') {
                Opportunity opp = new Opportunity();

                opp.Name = acc.Name;
                opp.StageName = 'Prospecting';
                opp.CloseDate = System.today();
                opp.AccountId = acc.Id;

                oppList.add(opp);
            }
        }

        if (!conList.isEmpty()) {
            insert conList;
        }

        if (oppList.size() > 0) {
            insert oppList;
        }
    }
}