package lk.jiat.app.core.service;

import jakarta.ejb.Remote;
import lk.jiat.app.core.model.Account;
import lk.jiat.app.core.model.AccountType;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Optional;

@Remote
public interface AccountService {

    void createAccount(Account account);
    Account findById(Long id);
    Account findByAccountNumber(String accountNumber);
    List<Account> findAllAccount();
    void updateAccount(Account account);
    boolean deleteAccount(Long id);
    int countAccountsByTypeForCustomer(String nic, AccountType accountType);
    Account findByNic(String nic);
    void applyInterest(String type);


}
