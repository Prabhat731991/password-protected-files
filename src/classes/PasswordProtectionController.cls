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


public Class PasswordProtectionController{
    
    
    public static void createContentDeliveryFile(String fileBody, String recordId){
        //Creating Salesforce File
            ContentVersion content =new ContentVersion(); 
            content.Title = 'Password Protected';  //File Name
            content.VersionData=EncodingUtil.base64Decode(fileBody); //File body
            content.PathOnClient= 'Password Protected.png'; //File extension
            insert content; 
            
            //Content document for linking the file to parent entity
            ContentDocumentLink docLink = new ContentDocumentLink();
            //Fetch ContentdocumentId from Content Version 
            docLink.ContentDocumentId = [select Id,ContentDocumentId from ContentVersion WHERE Id =:content.Id].ContentDocumentId;
            docLink.LinkedEntityId = recordId; //Id of the parent record
            docLink.ShareType = 'I'; //Inferred Permission. Determined by the user's access to parent record.
            docLink.Visibility = 'AllUsers';
            insert docLink;
            
            ContentDistribution cd = new ContentDistribution();
            cd.name = content.Title;
            cd.ContentVersionId = content.Id;
            cd.PreferencesAllowOriginalDownload = true;
            cd.PreferencesAllowPDFDownload = true;
            cd.PreferencesAllowViewInBrowser = true;
            cd.ExpiryDate = Datetime.now().addMinutes(1080);
            insert cd;
    }
    
    
}