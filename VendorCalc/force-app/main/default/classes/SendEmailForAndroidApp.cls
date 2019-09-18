@RestResource(UrlMapping='/SendEmail')
global class SendEmailForAndroidApp {
    @HttpPost
    global static ReturnData doPost() {
        ReturnData returnData = new ReturnData();
        try {
            returnData.isSuccess = false;
            Map<String, String> headerMap = RestContext.request.params;
            system.debug('headerMap');
            system.debug(headerMap);
            if(headerMap.containsKey('Email') && headerMap.containsKey('EmailBody') && headerMap.containsKey('LeadId')){
                if(headerMap.get('Email') != null){
                    String email = headerMap.get('Email');
                    if(headerMap.get('EmailBody') != null){
                        String emailBody = headerMap.get('EmailBody');
                  
                        if(headerMap.get('LeadId') != null){
                            String leadId = headerMap.get('LeadId');
                            if(!Test.isRunningTest()){
                               emailBody=emailBody.replace('Â', '');
                                String response = SendEmailForAndroidApp.sendEmailLink_Apex(email, emailBody, leadId);
                                if(response == 'SUCCESS'){
                                    returnData.isSuccess = true;
                                    returnData.message = 'Email sent successfully.';
                                }else {
                                     returnData.message = 'Sending email failed. Please contact administator.';
                                }
                            }
                        }else{
                            returnData.message = 'Lead Id can not be null.';
                        }                        
                    }else {
                        returnData.message = 'Email can not be null.';
                    }
                }else {
                    returnData.message = 'Email body can not be null.';
                }
                
            }else if(!headerMap.containsKey('Email')){
                returnData.message = 'Email can not be null.';
            }else if(!headerMap.containsKey('EmailBody')){
                returnData.message = 'Email body can not be null.';
            }else if(!headerMap.containsKey('LeadId')){
                returnData.message = 'Lead Id can not be null.';
            }else {
                returnData.message = 'Make sure you have filled email and email body.';
            }
        } catch (Exception ex) {
            returnData.message = ex.getMessage() + '. On line: ' + ex.getLineNumber();
        }
        return returnData;
    }
    
    global class ReturnData {
        public Boolean isSuccess { get; set; }
        public String message { get; set; }
    }
    private static String sendEmailLink_Apex(String emailAddress, String emailBody, String leadId) {
        try{
            if(emailAddress != null && emailBody != null){
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setSubject('Details');
                string[] to = new string[] {emailAddress};
                email.setToAddresses(to);
                String body = emailBody;
                body = body.replaceAll('\n', '\\\\n');
                email.setHTMLBody(body);
                if(!Test.isRunningTest()) {
                    Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{
                            email
                    });
                }
                return 'SUCCESS';
            }
            return 'FAIL';
        } catch(Exception ex){
            System.debug(ex.getMessage());
            return 'FAIL';
        }
    }
}