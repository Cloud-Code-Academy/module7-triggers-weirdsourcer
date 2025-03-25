trigger AccountTrigger on Account (before insert, after insert) {

    switch on Trigger.operationType {
        when BEFORE_INSERT {
            // Question 1
            // Account Trigger
            // When an account is inserted change the account type to 'Prospect' if there is no value in the type field.
            // Trigger should only fire on insert.
            AccountTriggerHelper.setAccountProstpect(Trigger.new);

            // Question 2
            // Account Trigger
            // When an account is inserted copy the shipping address to the billing address.
            // BONUS: Check if the shipping fields are empty before copying.
            // Trigger should only fire on insert.
            AccountTriggerHelper.setShippingAddyToBillingAddy(Trigger.new);

            // Question 3
            // Account Trigger
            // When an account is inserted set the rating to 'Hot' if the Phone, Website, and Fax ALL have a value.
            // Trigger should only fire on insert.
            AccountTriggerHelper.setRatingToHot(Trigger.new);
        }        
        when AFTER_INSERT {
            // Question 4
            // Account Trigger
            // When an account is inserted create a contact related to the account with the following default values:
            // LastName = 'DefaultContact'
            // Email = 'default@email.com'
            // Trigger should only fire on insert.
            AccountTriggerHelper.createRelatedContact(Trigger.new);
        }

    }


}