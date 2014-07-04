@isTest
private class testManagePicklistsForFlow {

    static testMethod void basicTest() {

        // Create dummy lead
        Account testAccount = new Account(Name='acme');
        insert testAccount;

        ManagePicklistsForFlow aPicklistPlugin = new ManagePicklistsForFlow();
        Map<String,Object> inputParams = new Map<String,Object>();
        Map<String,Object> outputParams = new Map<String,Object>();

        inputParams.put('ObjectAPIName','Account');
        inputParams.put('FieldAPIName','Industry');
        
        Process.PluginRequest request = new Process.PluginRequest(inputParams);
        Process.PluginResult result;
        result = aPicklistPlugin.invoke(request);
        
        
        Schema.DescribeFieldResult F = Account.Industry.getDescribe();
        List<Schema.PicklistEntry> P = F.getPicklistValues();
        
        PicklistForFlow__c[] fpv = [select PicklistFieldName__c from PicklistForFlow__c where ObjectName__c = 'Account' and PicklistFieldName__c = 'Industry'];
        
        System.AssertEquals(P.size(), fpv.size());
        
        
        //Make sure another call to the plugin does not result in duplicate entries
        result = aPicklistPlugin.invoke(request);        
        fpv = [select PicklistFieldName__c from PicklistForFlow__c where ObjectName__c = 'Account' and PicklistFieldName__c = 'Industry'];
        
        System.AssertEquals(P.size(), fpv.size());
                
        }

        
                

        static testMethod void describeTest() {

            ManagePicklistsForFlow aPicklistPlugin = new ManagePicklistsForFlow();
            Process.PluginDescribeResult result = aPicklistPlugin.describe();
                
            System.AssertEquals(result.inputParameters.size(), 2);
            System.AssertEquals(result.OutputParameters.size(), 0);
        
        }
        
}