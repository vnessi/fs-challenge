@isTest
private class GenericAccountCompareTest {

    @isTest
    static void sortByStringTest() {
        List<Account> accList = new List<Account>();
        accList.add(new Account(
            Name = 'B Test Account'
        ));
        accList.add(new Account(
            Name = 'Z Test Account'
        ));
        accList.add(new Account(
            Name = 'A Test Account'
        ));

        Test.startTest();
        GenericObjectCompare nameCompare = new GenericObjectCompare('Account', 'Name');
        accList.sort(nameCompare);
        Test.stopTest();

        System.assertEquals('A Test Account', accList.get(0).Name, '"A Test Account" Expected to be in first place');
        System.assertEquals('B Test Account', accList.get(1).Name, '"B Test Account" Expected to be in second place');
        System.assertEquals('Z Test Account', accList.get(2).Name, '"Z Test Account" Expected to be in third place');
    }

    @isTest
    static void sortByStringDescendantTest() {
        List<Account> accList = new List<Account>();
        accList.add(new Account(
            Name = 'B Test Account'
        ));
        accList.add(new Account(
            Name = 'Z Test Account'
        ));
        accList.add(new Account(
            Name = 'A Test Account'
        ));

        Test.startTest();
        GenericObjectCompare nameCompare = new GenericObjectCompare('Account', 'Name', GenericObjectCompare.Order.DESCENDANT);
        accList.sort(nameCompare);
        Test.stopTest();

        System.assertEquals('Z Test Account', accList.get(0).Name, '"Z Test Account" Expected to be in first place');
        System.assertEquals('B Test Account', accList.get(1).Name, '"B Test Account" Expected to be in second place');
        System.assertEquals('A Test Account', accList.get(2).Name, '"A Test Account" Expected to be in third place');
    }

    @isTest
    static void sortByDateTimeTest() {
        Account acc1 = new Account(
            Name = 'Second Test Account'
        );
        Account acc2 = new Account(
            Name = 'First Test Account'
        );
        Account acc3 = new Account(
            Name = 'Third Test Account'
        );
        insert new List<Account> {acc1, acc2, acc3};
        Test.setCreatedDate(acc1.Id, DateTime.newInstance(2013,12,12));
        Test.setCreatedDate(acc2.Id, DateTime.newInstance(2012,12,12));
        Test.setCreatedDate(acc3.Id, DateTime.newInstance(2014,12,12));
        
        List<Account> accList = [Select Id, Name, CreatedDate from Account limit 3];

        Test.startTest();
        GenericObjectCompare dateCompare = new GenericObjectCompare('Account', 'CreatedDate');
        accList.sort(dateCompare);
        Test.stopTest();
        
        System.assertEquals('First Test Account', accList.get(0).Name, '"First Test Account" expected to be in first place');
        System.assertEquals('Second Test Account', accList.get(1).Name, '"Second Test Account" expected to be in first place');
        System.assertEquals('Third Test Account', accList.get(2).Name, '"Third Test Account" expected to be in first place');
    }

    @isTest
    static void sortByBooleanTest() {
        Account premierAccount = new Account(
            Name = 'Premier Account',
            IsPremier__c = true
        );
        
        Account acc1 = new Account(
            Name = 'Test Account',
            IsPremier__c = false
        );
        
        Account premierAccount2 = new Account(
            Name = 'Premier Account 2',
            IsPremier__c = true
        );
        
        List<Account> accList = new List<Account> {acc1, premierAccount, premierAccount2};
        
        Test.startTest();
        GenericObjectCompare booleanCompare = new GenericObjectCompare('Account', 'IsPremier__c');
        accList.sort(booleanCompare);
        Test.stopTest();

        System.assertEquals(true, accList.get(0).IsPremier__c, 'Expected true values first');
        System.assertEquals(true, accList.get(1).IsPremier__c, 'Expected true values first');
        System.assertEquals(false, accList.get(2).IsPremier__c, 'Expected false at the end');
    }

    @isTest
    static void sortByDateTest() {
        Account acc1 = new Account(
            Name = 'Second Test Account',
            CustomDate__c = Date.newInstance(2013,12,12)
        );
        Account acc2 = new Account(
            Name = 'First Test Account',
            CustomDate__c = Date.newInstance(2012,12,12)
        );
        Account acc3 = new Account(
            Name = 'Third Test Account',
            CustomDate__c = Date.newInstance(2014,12,12)
        );
        
        List<Account> accList = new List<Account> {acc1, acc2, acc3};

        Test.startTest();
        GenericObjectCompare dateCompare = new GenericObjectCompare('Account', 'CustomDate__c');
        accList.sort(dateCompare);
        Test.stopTest();

        System.assertEquals('First Test Account', accList.get(0).Name, '"First Test Account" expected to be in first place');
        System.assertEquals('Second Test Account', accList.get(1).Name, '"Second Test Account" expected to be in first place');
        System.assertEquals('Third Test Account', accList.get(2).Name, '"Third Test Account" expected to be in first place');
    }

    @isTest
    static void sortByDoubleTest() {
        Account acc1 = new Account(
            Name = 'Second Test Account',
            DecimalNumber__c = 50.2
        );
        Account acc2 = new Account(
            Name = 'First Test Account',
            DecimalNumber__c = 10.2
        );
        Account acc3 = new Account(
            Name = 'Third Test Account',
            DecimalNumber__c = 99.2
        );
        
        List<Account> accList = new List<Account> {acc1, acc2, acc3};

        Test.startTest();
        GenericObjectCompare doubleCompare = new GenericObjectCompare('Account', 'DecimalNumber__c');
        accList.sort(doubleCompare);
        Test.stopTest();

        System.assertEquals('First Test Account', accList.get(0).Name, '"First Test Account" expected to be in first place');
        System.assertEquals('Second Test Account', accList.get(1).Name, '"Second Test Account" expected to be in first place');
        System.assertEquals('Third Test Account', accList.get(2).Name, '"Third Test Account" expected to be in first place');
    }

    @isTest
    static void sortByIdTest() {
        Account acc1 = new Account(
            Name = 'First Account'
        );
        insert acc1;
        
        Account acc2 = new Account(
            Name = 'Second Account'
        );
        insert acc2;
        
        List<Account> accList = new List<Account>();
        accList.add(acc2);
        accList.add(acc1);
                
        Test.startTest();
        GenericObjectCompare idCompare = new GenericObjectCompare('Account', 'Id');
        accList.sort(idCompare);
        Test.stopTest();

        System.assertEquals(acc1.Id, accList.get(0).Id, 'Expected to get "First Account" as the first one');
        System.assertEquals(acc2.Id, accList.get(1).Id, 'Expected to get "Second Account" as the second one');
    }

    @isTest
    static void sortByPicklistNullTest() {
        Account acc1 = new Account(
            Name = 'First Account',
            AccountSource = 'Web'
        );
        
        Account acc2 = new Account(
            Name = 'Null Account'
        );

        Account acc3 = new Account(
            Name = 'Null 2 Account'
        );
        
        List<Account> accList = new List<Account> {acc2, acc1, acc3};
                
        Test.startTest();
        GenericObjectCompare picklistCompare = new GenericObjectCompare('Account', 'AccountSource');
        accList.sort(picklistCompare);
        Test.stopTest();

        System.assert(accList.get(0).AccountSource != null, 'Expected to get "First Account" as the first account in the list');
        System.assert(accList.get(1).AccountSource == null, 'Expected to get nulls at the end');
        System.assert(accList.get(2).AccountSource == null, 'Expected to get nulls at the end');
    }

    @isTest
    static void sortByPicklistNullEndTest() {
        Account acc0 = new Account(
            Name = 'First Account',
            AccountSource = 'Web'
        );
        
        Account acc1 = new Account(
            Name = 'Null 2 Account'
        );

        Account acc2 = new Account(
            Name = 'Null Account',
            AccountSource = 'Other'
        );
        
        List<Account> accList = new List<Account> {acc0, acc2, acc1};
                
        Test.startTest();
        GenericObjectCompare picklistCompare = new GenericObjectCompare('Account', 'AccountSource');
        accList.sort(picklistCompare);
        Test.stopTest();

        System.assert(accList.get(0).AccountSource != null, 'Expected to get "First Account" as the first account in the list');
    }
}