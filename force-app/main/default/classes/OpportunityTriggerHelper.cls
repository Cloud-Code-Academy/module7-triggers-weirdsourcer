public with sharing class OpportunityTriggerHelper {
    /* Question 5
    * Opportunity Trigger
    * When an opportunity is updated validate that the amount is greater than 5000.
    * Error Message: 'Opportunity amount must be greater than 5000'
    * Trigger should only fire on update.
    */
    public static void checkAmountValiditity(List<Opportunity> triggerDotNew, Map<Id, Opportunity> triggerDotOldMap) {
        for (Opportunity opp : triggerDotNew) {
            Opportunity oldOpp = triggerDotOldMap.get(opp.Id);
            if (oldOpp.Amount > 5000 && opp.Amount <= 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
    }

    /*
     * Question 6
	 * Opportunity Trigger
	 * When an opportunity is deleted prevent the deletion of a closed won opportunity if the account industry is 'Banking'.
	 * Error Message: 'Cannot delete closed opportunity for a banking account that is won'
	 * Trigger should only fire on delete.
	 */
    public static void preventClosedWonBankingOppDel (List<Opportunity> triggerDotOld) {
        Set<Id> accId = new Set<Id>();
        for (Opportunity opp : triggerDotOld) {
            accId.add(opp.AccountId);
        }

        Map<Id, Account> accIdToIndustryMap = new Map<Id, Account>([SELECT Industry
                                                                    FROM Account
                                                                    WHERE Id IN :accId
                                                                    WITH USER_MODE]);

        for (Opportunity opp : triggerDotOld) {
            Account acc = accIdToIndustryMap.get(opp.AccountId);
            if (opp.StageName == 'Closed Won' &&  acc.Industry == 'Banking') {
                opp.addError('Cannot delete closed opportunity for a banking account that is won');
            }
        }
    }

    /*
    * Question 7
    * Opportunity Trigger
    * When an opportunity is updated set the primary contact on the opportunity to the contact on the same account with the title of 'CEO'.
    * Trigger should only fire on update.
    */
    public static void setOppPriConToCEO(List<Opportunity> triggerDotNew) {
        Set<Id> accId = new Set<Id>();
        for (Opportunity opp : triggerDotNew) {
            accId.add(opp.AccountId);
        }

        Map<Id, Contact> accIdToConMap = new Map<Id, Contact>();
        for (Contact con : [SELECT Id, AccountId
                            FROM Contact
                            WHERE AccountId = :accid AND Title = 'CEO' WITH USER_MODE]) {
            accIdToConMap.put(con.AccountId, con);
                            }
         

       // Map<Id, Id>

        for (Opportunity opp : triggerDotNew) {
            Contact con = accIdToConMap.get(opp.AccountId);
            if (con != null) {
                opp.Primary_Contact__c = con.Id;
            }

        }
    }
}