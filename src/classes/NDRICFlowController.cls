public with sharing class NDRICFlowController 
{
	// Instantiate the Flow for use by the Controller - linked by VF "interview" attribute
 	public Flow.Interview.Comprehensive_Assessment flDemo {get;set;}

	public NDRICFlowController (ApexPages.StandardController controller)
	{
		
	}
	
 	// Factor your PageReference as a full GET/SET
 	public PageReference prFinishLocation 
 	{
 		get 
 		{
 			PageReference prRef = new PageReference('/' + strOutputVariable);
 			prRef.setRedirect(true);
 			return prRef;
 		}
 		set { prFinishLocation = value; }
 	}

 	// Factor your Flow output variable pull as a full GET / SET
 	public String strOutputVariable 
 	{
 		get 
 		{
			String strTemp = '';

 			if(flDemo != null) 
 			{
 				strTemp = string.valueOf(flDemo.getVariableValue('NewAssessment'));
 			}

 			return strTemp;
 		}

 		set { strOutputVariable = value; }
 } 
}