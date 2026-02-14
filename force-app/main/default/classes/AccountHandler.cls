public with sharing class AccountHandler {
    public static void insertAccount(Integer totalAccounts){
        List <Account> addAccounts = new List<Account>();
        while(totalAccounts > 0){
            Account acc = new Account();
            acc.Name = 'Acme Inc ' + totalAccounts;
            acc.AccountNumber = 'A' + String.valueOf(000 + totalAccounts);
            addAccounts.add(acc);
            totalAccounts--;
        }
        try{
            insert addAccounts;
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}