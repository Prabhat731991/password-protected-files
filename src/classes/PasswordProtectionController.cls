/**
* @File Name          : AvoidRecursion.cls
* @Description        : Apex class to avoid recusrive triggers
* @Author             : 
* @Group              : 
* @Last Modified By   : Prabhat Sharma
* @Last Modified On   : 7/24/2019, 05:05:33 PM
* @Modification Log   : 
*==============================================================================
* Ver         Date                     Author                 Modification
*==============================================================================
* 1.0    7/24/2019, 9:14:54 PM       Prabhat Sharma           Initial Version
**/


public Class AvoidRecursion{
    
    
    //Static variable to stop recursion of before event trigger execution
    public static boolean isBefore = true;
    
    public static boolean isBeforeRun(){
        if(isBefore){
            isBefore = false;
            return true;
        }else{
            return isBefore;
        }
    }

    //Static variable to stop recursion of after event trigger execution
    public static boolean isAfter = true;
    
    public static boolean isAfterRun(){
        if(isAfter){
            isAfter = false;
            return true;
        }else{
            return isAfter;
        }
    }

    //Static variable to stop recursion of after event trigger execution on SVOC Logic
    public static boolean isSVOCAfter = true;
    
    public static boolean isSVOCAfterRun(){
        if(isSVOCAfter){
            isSVOCAfter = false;
            return true;
        }else{
            return isSVOCAfter;
        }
    }


    //Static variable to stop recursion of after insert event trigger execution on Opportunity
    public static boolean isPreBookingInsert = true;
    
    public static boolean isPreBookingInsertRun(){
        if(isPreBookingInsert){
            isPreBookingInsert = false;
            return true;
        }else{
            return isPreBookingInsert;
        }
    }
    
}