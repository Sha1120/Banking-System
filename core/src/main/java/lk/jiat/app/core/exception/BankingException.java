package lk.jiat.app.core.exception;

import jakarta.ejb.ApplicationException;

@ApplicationException(rollback=true)
public class BankingException extends Exception {
    public BankingException(String message) {
        super(message);
    }
}