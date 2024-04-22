
public class GenericObjectCompare implements Comparator<sObject>{

    public String compareField;
    public String comparesObjectType;
    public Order compareOrder;
    
    public enum Order {
        ASCENDANT, 
        DESCENDANT
    }

    public GenericObjectCompare(String compareObject, String compareField, Order compareOrder) {
        this.compareField = compareField;
        this.comparesObjectType = compareObject;
        this.compareOrder = compareOrder;
    }

    public GenericObjectCompare(String compareObject, String compareField) {
        this.compareField = compareField;
        this.comparesObjectType = compareObject;
        this.compareOrder = Order.ASCENDANT;
    }
    
    public Integer compare(sObject o1, sObject o2) {
        return primitiveDateTypeCompare(o1, o2);
    }

    
    private Integer primitiveDateTypeCompare(sObject o1, sObject o2) {
        String fieldType = getCompareFieldType();
        System.debug(fieldType);
        Object currentObjectValue = o1.get(this.compareField);
        Object compareToObjectValue = o2.get(this.compareField);
        Integer returnValue = null;
        // leave null value at the end
        if(compareToObjectValue == null && currentObjectValue == null) {
            returnValue = 0;
        } else if (compareToObjectValue == null) {
            returnValue = -1;
        } else if (currentObjectValue == null) {
            returnValue = 1;
        } 
        if(returnValue == null) {
            switch on fieldType {
                when 'STRING' {
                    returnValue = compareString(currentObjectValue, compareToObjectValue);
                }
                when 'DATE' {
                    returnValue = compareDate(currentObjectValue, compareToObjectValue);
                }	
                when 'BOOLEAN' {
                    returnValue = compareBoolean(currentObjectValue, compareToObjectValue);
                }
                when 'DATETIME' {
                    returnValue = compareDateTime(currentObjectValue, compareToObjectValue);
                }	
                when 'DOUBLE' {		
                    returnValue = compareDouble(currentObjectValue, compareToObjectValue);
                }
                when 'ID' {		
                    returnValue = compareString(currentObjectValue, compareToObjectValue);
                }
                when 'PICKLIST' {		
                    returnValue = compareString(currentObjectValue, compareToObjectValue);
                }
                when else {		  
                    throw new GenericObjectCompareException('Unsupported parameter type: ' + fieldType);
                }
            }
        }
        if(this.compareOrder == Order.DESCENDANT) {
            return returnValue * -1;
        }
        return returnValue;
    }

    private Integer compareString(Object currentObjectValue, Object compareToObjectValue) {
        String currentValue = String.valueOf(currentObjectValue);
        String compareToValue = String.valueOf(compareToObjectValue);
        return currentValue.compareTo(compareToValue); 
    }

    private Integer compareDate(Object currentObjectValue, Object compareToObjectValue) {
        Date currentValue = Date.valueOf(currentObjectValue);
        Date compareToValue = Date.valueOf(compareToObjectValue);
        Integer returnValue = 0;
        if (currentValue > compareToValue) {
            // Set return value to a positive value.
            returnValue = 1;
        } else if (currentValue < compareToValue) {
            // Set return value to a negative value.
            returnValue = -1;
        }
        return returnValue;
    }

    private Integer compareDouble(Object currentObjectValue, Object compareToObjectValue) {
        Double currentValue = Double.valueOf(currentObjectValue);
        Double compareToValue = Double.valueOf(compareToObjectValue);
        Integer returnValue = 0;
        if (currentValue > compareToValue) {
            // Set return value to a positive value.
            returnValue = 1;
        } else if (currentValue < compareToValue) {
            // Set return value to a negative value.
            returnValue = -1;
        }
        return returnValue;
    }

    
    private Integer compareBoolean(Object currentObjectValue, Object compareToObjectValue) {
        Boolean currentValue = (Boolean)currentObjectValue;
        Boolean compareToValue = (Boolean)compareToObjectValue;
        Integer returnValue = 0;
        if (currentValue == false && compareToValue == true) {
            // Set return value to a positive value.
            returnValue = 1;
        } else if (currentValue == true && compareToValue == false){
            returnValue = -1;
        }
        return returnValue;
    }

    private Integer compareDateTime(Object currentObjectValue, Object compareToObjectValue) {
        DateTime currentValue = DateTime.valueOf(currentObjectValue);
        DateTime compareToValue = DateTime.valueOf(compareToObjectValue);
        Integer returnValue = 0;
        if (currentValue > compareToValue) {
            // Set return value to a positive value.
            returnValue = 1;
        } else if (currentValue < compareToValue) {
            // Set return value to a negative value.
            returnValue = -1;
        }
        return returnValue;
    }

    private String getCompareFieldType() {
        if(String.isEmpty(this.comparesObjectType)) {
            throw new GenericObjectCompareInternalException('Compare sObject type must be defined. Value: ' + this.comparesObjectType);
        }
        if(String.isEmpty(this.compareField)) {
            throw new GenericObjectCompareInternalException('Compare field name must be defined. Value: ' + this.compareField);
        }
        try {
            SObjectType r = ((SObject)(Type.forName('Schema.'+this.comparesObjectType).newInstance())).getSObjectType();
            DescribeSObjectResult d = r.getDescribe();
            return String.valueOf(d.fields.getMap().get(this.compareField).getDescribe().getType());
        } catch (Exception ex) {
            throw new GenericObjectCompareInternalException ('Exception thrown while trying to determine type of field. Value: ' + this.compareField + ' Exception: ' + ex.getMessage());
        }
    }

    public class GenericObjectCompareInternalException extends Exception {}
    public class GenericObjectCompareException extends Exception {}
}