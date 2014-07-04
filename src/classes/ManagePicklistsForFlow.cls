global Class ManagePicklistsForFlow implements Process.Plugin {


    global Process.PluginResult invoke(Process.PluginRequest request) {    

        String ObjectAPIName = (String) request.inputParameters.get('ObjectAPIName');
        String FieldAPIName = (String) request.inputParameters.get('FieldAPIName');
        
        Map<String,Object> result = new Map<String,Object>();
    
        ManagePicklist(ObjectAPIName, FieldAPIName);
 
        return new Process.PluginResult(result); 

    }


    private void ManagePicklist(String ObjectAPIName, String FieldAPIName) {
 
    Schema.SObjectType sot = Schema.getGlobalDescribe().get(ObjectAPIName);
    Schema.DescribeSOBjectResult sotDesc = sot.getDescribe();
    Schema.DescribeFieldResult F = sotDesc.fields.getMap().get(FieldAPIName).getDescribe();
    List<Schema.PicklistEntry> P = F.getPicklistValues();

    

    for (PicklistEntry aPickListval: P) {
        PicklistForFlow__c[] fpv = [select Name from PicklistForFlow__c where ObjectName__c = :ObjectAPIName and PicklistFieldName__c = :FieldAPIName and PickListValue__c = :aPickListval.getValue()];
        if (fpv.size() == 0 ) {
            PicklistForFlow__c newFpv = new PicklistForFlow__c(ObjectName__c = ObjectAPIName, PickListValue__c = aPickListval.getValue(), PicklistFieldName__c =FieldAPIName, PickListLabel__c =aPickListval.getLabel()  );
            Database.insert(newFpv);
        }
    }
    
    }


    global Process.PluginDescribeResult describe() {
        Process.PluginDescribeResult result = new Process.PluginDescribeResult();
        result.description = 'This Flow Plug-in can be used to manage picklist values of any Field outside of the object definition to be used by Flow.';
        result.tag = 'Picklist Utils';
        
        result.inputParameters = new List<Process.PluginDescribeResult.InputParameter>{
            new Process.PluginDescribeResult.InputParameter('ObjectAPIName', 
                Process.PluginDescribeResult.ParameterType.STRING, true),
            new Process.PluginDescribeResult.InputParameter('FieldAPIName',                                                   
                Process.PluginDescribeResult.ParameterType.STRING, true)
                };

        result.outputParameters = new List<Process.PluginDescribeResult.OutputParameter>{     
                };
   
        
        return result;
    }
}