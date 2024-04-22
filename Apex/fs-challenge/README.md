# Generic sObject sort

This repo contains the Apex code with the functionality to order any field on any sObject in Salesforce. For a given sObject Type and field Name you can get a list ordered by those critieria Ascendant or Descendant.

## Installation link

This is an unlocked package and could installed using the following link

Package Installation URL: https://login.salesforce.com/packaging/installPackage.apexp?p0=04tak00000013ThAAI

## How to use it from Apex?

1. Define the list of sObject you need to sort
2. Instantiate `GenericObjectCompare` giving 3 params `sObject type`, `field name` and `order`

Example

```List<Account> accList = new List<Account>();
accList.add(new Account(
    Name = 'B Test Account'
));
accList.add(new Account(
    Name = 'Z Test Account'
));
accList.add(new Account(
    Name = 'A Test Account'
));

GenericObjectCompare nameCompare = new GenericObjectCompare('Account', 'Name', GenericObjectCompare.Order.DESCENDANT);
accList.sort(nameCompare);
```

## Supported field types in Salesforce

- String (also Picklist sObject fields is supported)
- Date
- DateTime
- Id
- Double/Decimal/Integer
