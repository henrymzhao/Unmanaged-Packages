/**
 * Created by henryzhao on 2020-01-17.
 */

public with sharing class SAMPLE_AccountService implements Callable {
    public static void printName(List<Account> accs) {
        for (Account acc : accs) {
            System.debug(LoggingLevel.INFO, '##### SAMPLE_AccountService -> printName -> acc Name -> ' + acc.Name);
        }
    }

    public Object call(String action, Map<String, Object> args) {
        switch on action {
            when 'printName' {
                printName((List<Account>) args.get('new'));
            }
        }
        return null;
    }
}