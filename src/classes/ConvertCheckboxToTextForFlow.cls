global class ConvertCheckboxToTextForFlow implements Process.Plugin 
{
    global Process.PluginResult invoke(Process.PluginRequest request) 
    {    
        Boolean currentValue = (Boolean) request.inputParameters.get('CurrentValue');
        String resultText = currentValue ? 'Yes' : 'No';
        Map<String,Object> result = new Map<String,Object>();
        result.put ('ResultString', resultText);
        return new Process.PluginResult(result); 
    }
    
    global Process.PluginDescribeResult describe() 
    {
        Process.PluginDescribeResult result = new Process.PluginDescribeResult();
        result.description = 'This Flow Plug-in can be used to translate tickbox value into Yes or No';
        result.tag = 'Picklist Utils';
        
        result.inputParameters = new List<Process.PluginDescribeResult.InputParameter>
        {
            new Process.PluginDescribeResult.InputParameter('CurrentValue', 
                Process.PluginDescribeResult.ParameterType.Boolean, true)
        };

        result.outputParameters = new List<Process.PluginDescribeResult.OutputParameter>
        {     
            new Process.PluginDescribeResult.OutputParameter('ResultString', Process.PluginDescribeResult.ParameterType.STRING)
        };
   
        
        return result;
    }
}