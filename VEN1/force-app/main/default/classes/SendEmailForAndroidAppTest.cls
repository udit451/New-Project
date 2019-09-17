@IsTest
private class SendEmailForAndroidAppTest {
    @isTest
    private static void doPostTest1(){
        Lead l = new Lead();
        l.LastName = 'Test';
        l.Status = 'Open - Not Contacted';
        l.Company = 'Ca';
        l.Email = 'teat@gmail.com';
        
        l.Phone = '123454321';
        
        insert l;
        
        String emailId = 'test@gmail.com';
        Email_Template__c email = new Email_Template__c();
        email.Email_Body__c= 'Axasuyhas';
        email.Subject__c = 'Test Email';
        insert email;
        
        //String JSONMsg = '{"lead_Id" : "'+l.Id +'","EmailTemplate":"email.Email_Body__c" , "emailId":"test@gmail.com"}';
        RestResponse responce = new RestResponse();
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/';
        request.addParameter('LeadId', l.Id); 
        request.addParameter('Email', emailId);  
        request.addParameter('EmailBody', email.Email_Body__c);  
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = responce;
        
        
        
        Test.startTest();
         SendEmailForAndroidApp.ReturnData message = SendEmailForAndroidApp.doPost();
        Test.stopTest();
        
        system.assert(message != null);
    }
     /*
     * This method is use to cover else if part(LeadId can not be null) .
     */
    @isTest
    private static void doPostTest2(){
       
        
        String emailId = 'test@gmail.com';
        Email_Template__c email = new Email_Template__c();
        email.Email_Body__c= 'Axasuyhas';
        email.Subject__c = 'Test Email';
        insert email;
        
        //String JSONMsg = '{"lead_Id" : "'+l.Id +'","EmailTemplate":"email.Email_Body__c" , "emailId":"test@gmail.com"}';
        RestResponse responce = new RestResponse();
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/';
        request.addParameter('Email', emailId);  
        request.addParameter('EmailBody', email.Email_Body__c);  
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = responce;
        Test.startTest();
         SendEmailForAndroidApp.ReturnData message = SendEmailForAndroidApp.doPost();
        Test.stopTest();
        String msg = JSON.serialize(message);
        system.assert(msg.contains('Lead Id can not be null.'));
        
    }
     /*
     * This method is use to cover else if part(EmailId can not be null) .
     */
    @isTest
    private static void doPostTest3(){
        Lead l = new Lead();
        l.LastName = 'Test';
        l.Status = 'Open - Not Contacted';
        l.Company = 'Ca';
        l.Email = 'teat@gmail.com';
       
        l.Phone = '123454321';
        
        insert l;
        
        
        Email_Template__c email = new Email_Template__c();
        email.Email_Body__c= 'Axasuyhas';
        email.Subject__c = 'Test Email';
        insert email;
        
        //String JSONMsg = '{"lead_Id" : "'+l.Id +'","EmailTemplate":"email.Email_Body__c" , "emailId":"test@gmail.com"}';
        RestResponse responce = new RestResponse();
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/';
        request.addParameter('LeadId', l.Id); 
        request.addParameter('EmailBody', email.Email_Body__c);  
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = responce;
        Test.startTest();
         SendEmailForAndroidApp.ReturnData message = SendEmailForAndroidApp.doPost();
        Test.stopTest();
        String msg = JSON.serialize(message);
        system.assert(msg.contains('Email can not be null.'));
    }
     /*
     * This method is use to cover else if part(EmailBody can not be null) .
     */
    @isTest
    private static void doPostTest4(){
        Lead l = new Lead();
        l.LastName = 'Test';
        l.Status = 'Open - Not Contacted';
        l.Company = 'Ca';
        l.Email = 'teat@gmail.com';
       
        l.Phone = '123454321';
        l.Date__c = Date.today();
        insert l;
        
        String emailId = 'test@gmail.com';
       
        
        RestResponse responce = new RestResponse();
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/';
        request.addParameter('LeadId', l.Id); 
        request.addParameter('Email', emailId);  
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = responce;
        Test.startTest();
         SendEmailForAndroidApp.ReturnData message = SendEmailForAndroidApp.doPost();
        Test.stopTest();
         String msg = JSON.serialize(message);
        system.assert(msg.contains('Email body can not be null.'));
    }
    
    /*
     * This method is use to cover else part(Lead id can not be null) .
     */
     @isTest
    private static void doPostTest5(){
       
        String emailId = 'test@gmail.com';
        Email_Template__c email = new Email_Template__c();
        email.Email_Body__c= 'Axasuyhas';
        email.Subject__c = 'Test Email';
        insert email;
        
        //String JSONMsg = '{"lead_Id" : "'+l.Id +'","EmailTemplate":"email.Email_Body__c" , "emailId":"test@gmail.com"}';
        RestResponse responce = new RestResponse();
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/';
        request.addParameter('LeadId', null); 
        request.addParameter('Email', emailId);  
        request.addParameter('EmailBody', email.Email_Body__c);  
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = responce;
        Test.startTest();
        SendEmailForAndroidApp.ReturnData message = SendEmailForAndroidApp.doPost();
        Test.stopTest();
        
        String msg = JSON.serialize(message);
        system.assert(msg.contains('Lead Id can not be null.'));
    }
    
    /*
     * This method is use to cover else part(Email can not be null) .
     */
    
    @isTest
    private static void doPostTest6(){
       
         Lead l = new Lead();
        l.LastName = 'Test';
        l.Status = 'Open - Not Contacted';
        l.Company = 'Ca';
        l.Email = 'teat@gmail.com';
        
        l.Phone = '123454321';
        
        insert l;
        
        String emailId = 'test@gmail.com';
        Email_Template__c email = new Email_Template__c();
        email.Email_Body__c= 'Axasuyhas';
        email.Subject__c = 'Test Email';
        insert email;
        
        //String JSONMsg = '{"lead_Id" : "'+l.Id +'","EmailTemplate":"email.Email_Body__c" , "emailId":"test@gmail.com"}';
        RestResponse responce = new RestResponse();
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/';
        request.addParameter('LeadId', l.Id); 
        request.addParameter('Email', null);  
        request.addParameter('EmailBody', email.Email_Body__c);  
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = responce;
        Test.startTest();
        SendEmailForAndroidApp.ReturnData message = SendEmailForAndroidApp.doPost();
        Test.stopTest();
        
        String msg = JSON.serialize(message);
       system.assert(msg.contains('Email body can not be null.'));
    }
    
    /*
     * This method is use to cover else part(Email Body can not be null) .
     */
    
     @isTest
    private static void doPostTest7(){
        Lead l = new Lead();
        l.LastName = 'Test';
        l.Status = 'Open - Not Contacted';
        l.Company = 'Ca';
        l.Email = 'teat@gmail.com';
        
        l.Phone = '123454321';
        
        insert l;
        String emailId = 'test@gmail.com';
        
        
        //String JSONMsg = '{"lead_Id" : "'+l.Id +'","EmailTemplate":"email.Email_Body__c" , "emailId":"test@gmail.com"}';
        RestResponse responce = new RestResponse();
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/';
        request.addParameter('LeadId', l.Id); 
        request.addParameter('Email', emailId);  
        request.addParameter('EmailBody', null);  
        request.httpMethod = 'POST';
        RestContext.request = request;
        RestContext.response = responce;
        Test.startTest();
        SendEmailForAndroidApp.ReturnData message = SendEmailForAndroidApp.doPost();
        Test.stopTest();
        
        String msg = JSON.serialize(message);
        system.assert(msg.contains('Email can not be null.'));
    }
    
    /*
     * This method is use to cover Catch part of do save method.
     */
    @isTest
    private static void doPostTest8(){
        Test.startTest();
          SendEmailForAndroidApp.ReturnData message =  SendEmailForAndroidApp.doPost();
        Test.stopTest();
        
        String msg = JSON.serialize(message);
        system.assert(msg.contains('On line:'));
    }
}