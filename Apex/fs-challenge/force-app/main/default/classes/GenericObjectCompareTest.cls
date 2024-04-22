
@isTest
private class GenericObjectCompareTest {

    @isTest
    static void sortContactByStringTest() {
        List<Contact> contacts = new List<Contact>();
        contacts.add(new Contact(
            LastName = 'B Test Contact'
        ));
        contacts.add(new Contact(
            LastName = 'A Test Contact'
        ));

        Test.startTest();
        GenericObjectCompare lastNameCompare = new GenericObjectCompare('Contact', 'LastName');
        contacts.sort(lastNameCompare);
        Test.stopTest();

        System.assertEquals('A Test Contact', contacts.get(0).LastName, 'A Test Contact should be first');
        System.assertEquals('B Test Contact', contacts.get(1).LastName, 'B Test Contact should be second');

    }

    @isTest
    static void sortContactByStringDescTest() {
        List<Contact> contacts = new List<Contact>();
        contacts.add(new Contact(
            LastName = 'B Test Contact'
        ));
        contacts.add(new Contact(
            LastName = 'A Test Contact'
        ));
        contacts.add(new Contact(
            LastName = 'C Test Contact'
        ));
        contacts.add(new Contact(
            LastName = 'Z Test Contact'
        ));

        Test.startTest();
        GenericObjectCompare lastNameCompare = new GenericObjectCompare('Contact', 'LastName', GenericObjectCompare.ORder.DESCENDANT);
        contacts.sort(lastNameCompare);
        Test.stopTest();

        System.assertEquals('Z Test Contact', contacts.get(0).LastName, 'Z Test Contact should be first');
        System.assertEquals('C Test Contact', contacts.get(1).LastName, 'C Test Contact should be second');
        System.assertEquals('B Test Contact', contacts.get(2).LastName, 'B Test Contact should be first');
        System.assertEquals('A Test Contact', contacts.get(3).LastName, 'A Test Contact should be first');

    }
}