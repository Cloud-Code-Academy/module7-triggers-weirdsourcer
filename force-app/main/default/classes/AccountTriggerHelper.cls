
public with sharing class AccountTriggerHelper {
    // Question 1
    // Account Trigger
    // When an account is inserted change the account type to 'Prospect' if there is no value in the type field.
    // Trigger should only fire on insert.
    public static void setAccountProstpect(List<Account> triggerDotNew) {
        for (Account acc : triggerDotNew) {
            if (acc.Type == null) {
                acc.Type = 'Prospect';
            }
        }
    }

    // Question 2
    // Account Trigger
    // When an account is inserted copy the shipping address to the billing address.
    // BONUS: Check if the shipping fields are empty before copying.
    // Trigger should only fire on insert.
    public static void setShippingAddyToBillingAddy(List<Account> triggerDotNew) {
        for (Account acc : triggerDotNew) {
            if (String.isNotBlank(acc.ShippingStreet)) {
                acc.BillingStreet = acc.ShippingStreet;
                acc.BillingCity = acc.ShippingCity;
                acc.BillingState = acc.ShippingState;
                acc.BillingPostalCode = acc.ShippingPostalCode;
                acc.BillingCountry = acc.ShippingCountry;
              //System.debug('######ShippingAddress: '+acc.ShippingAddress);
              //System.debug('      BillingAddress: '+acc.BillingAddress);
            }

        }
    }

    // Question 3
    // Account Trigger
	// When an account is inserted set the rating to 'Hot' if the Phone, Website, and Fax ALL have a value.
    // Trigger should only fire on insert.
    public static void setRatingToHot(List<Account> triggerDotNew) {
        for (Account acc : triggerDotNew) {
            if (String.isNotBlank(String.valueOf(acc.Phone)) && String.isNotBlank(acc.Website) && String.isNotBlank(acc.Fax)) {
                acc.Rating = 'Hot';
            }
        }
    }

    // Question 4
    // Account Trigger
    // When an account is inserted create a contact related to the account with the following default values:
    // LastName = 'DefaultContact'
    // Email = 'default@email.com'
    // Trigger should only fire on insert.
    public static void createRelatedContact(List<Account> triggerDotNew) {
        //List<Account> accountToProccess = triggerDotNew;
        List<Contact> conToInsert = new List<Contact>();
        for (Account acc : triggerDotNew) {
            Contact con = new Contact();
            con.LastName = 'DefaultContact';
            con.Email = 'default@email.com';
            con.AccountId = acc.Id;
            conToInsert.add(con);
        }
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.DuplicateRuleHeader.AllowSave = true;
        dmo.DuplicateRuleHeader.RunAsCurrentUser = false;
        Database.insert(conToInsert, dmo, AccessLevel.SYSTEM_MODE);
    }

}