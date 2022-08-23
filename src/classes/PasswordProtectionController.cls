/**
* @File Name          : PasswordProtectionController.cls
* @Description        : Apex class to create content deliveries i.e. Salesforce files with password protection.
* @Author             : 
* @Group              : 
* @Last Modified By   : Prabhat Sharma
* @Last Modified On   : 09/04/2019, 08:35:33 PM
* @Modification Log   : 
*==============================================================================
* Ver         Date                     Author                 Modification
*==============================================================================
* 1.0   09/04/2019, 08:35:33 PM       Prabhat Sharma           Initial Version
**/


public class PasswordProtectionController{
    
    
    public static void createContentDeliveryFile(String fileBody, String recordId){
        //Creating Salesforce File
        ContentVersion contentObj =new ContentVersion(); 
        contentObj.Title = 'Password Protected';  //File Name
        contentObj.VersionData=EncodingUtil.base64Decode(fileBody); //File body
        contentObj.PathOnClient= 'Password Protected.png'; //File extension
        insert contentObj; 
        
        //Content document for linking the file to a parent entity
        ContentDocumentLink docLinkObj = new ContentDocumentLink();
        //Fetch ContentdocumentId from Content Version 
        docLinkObj.ContentDocumentId = [select Id,ContentDocumentId from ContentVersion WHERE Id =:contentObj.Id].ContentDocumentId;
        docLinkObj.LinkedEntityId = recordId; //Id of the parent record
        docLinkObj.ShareType = 'I'; //Inferred Permission. Determined by the user's access to parent record.
        insert docLinkObj;
        
        //Create Content Distribution to make the file publicly available as well as password protected
        ContentDistribution cdistObj = new ContentDistribution();
        cdistObj.name = contentObj.Title;
        cdistObj.ContentVersionId = contentObj.Id; //Id of the content version record
        cdistObj.PreferencesAllowPDFDownload = true; //Allow to download the file as PDF
        cdistObj.PreferencesAllowViewInBrowser = true; // Allow to view the file in browser
        cdistObj.ExpiryDate = Datetime.now().addMinutes(120); // set an expiry date/time for the file (2 hours from current time in this case)
        cdistObj.PreferencesExpires = true; //If setting the expiry date, setting this field to true is required
        cdistObj.PreferencesPasswordRequired = true; // this defines a random password

        insert cdistObj;

        //Fetch the Public URL and Password to store in some into the parent record and use it for further processing
        List<ContentDistribution> cdistObjList = [SELECT DistributionPublicUrl,Password,ExpiryDate FROM ContentDistribution WHERE Id=:cdistObj.Id];
        
        //System.debug(cdistObjList.Password); //uncomment this line to see the magic
        //Further processing .........
        //The above list will have all the details which can be used to store on any object and can be sent out to external users.
    }
    
    
}
