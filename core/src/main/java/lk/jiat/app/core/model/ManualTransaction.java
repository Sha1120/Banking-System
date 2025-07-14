package lk.jiat.app.core.model;

import jakarta.persistence.*;
import jakarta.transaction.Transaction;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "manual_transaction")
@NamedQueries({
        @NamedQuery(name ="ManualTransfer.findByDate",query = "SELECT mt FROM ManualTransaction mt WHERE mt.transactionDate BETWEEN :start AND :end ORDER BY mt.transactionDate DESC")
})
public class ManualTransaction implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "accountNumber",nullable = false)
    private String accountNumber;

    @Column(name ="transaction_type",nullable = false)
    private String transactionType;

    @Column(name ="amount",nullable = false)
    private BigDecimal amount;

    @Column(name = "transaction_date", nullable = false)
    private LocalDateTime transactionDate;

    @Column(name = "customer_name")
    private String customerName;

    @Column(name = "customer_nic")
    private String customerNic;

    @Column(name = "branch")
    private String branch;


    public ManualTransaction() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }
    public LocalDateTime getTransactionDate() {
        return transactionDate;
    }
    public void setTransactionDate(LocalDateTime transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getCustomerName() {
        return customerName;
    }
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }
    public String getCustomerNic() {
        return customerNic;
    }
    public void setCustomerNic(String customerNic) {
        this.customerNic = customerNic;
    }
    public String getBranch() {
        return branch;
    }
    public void setBranch(String branch) {
        this.branch = branch;
    }
}
