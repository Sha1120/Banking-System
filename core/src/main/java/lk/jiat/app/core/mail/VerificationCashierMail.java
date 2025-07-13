package lk.jiat.app.core.mail;


import jakarta.mail.Message;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class VerificationCashierMail extends Mailable {

    private final String to;
    private final String cashierVerificationCode;

    public VerificationCashierMail(String to, String cashierVerificationCode) {
        this.to = to;
        this.cashierVerificationCode = cashierVerificationCode;
    }

    private String generateContent() {
        return "<html>" +
                "<body>" +
                "<h2>Welcome to National Bank</h2>" +
                "<p>Your 6-digit cashier Employee code is:</p>" +
                "<h1 style='color: #2c3e50;'>" + cashierVerificationCode + "</h1>" +
                "<p>Please use this code to complete your cashier login process.</p>" +
                "<br/><small style='color:red'>This code will be used to unlock your account, so do not share it with anyone. Also, make sure to remember this code..</small>" +
                "</body>" +
                "</html>";
    }

    @Override
    public void build(Message message) throws Exception {

        if (!(message instanceof MimeMessage)) {
            throw new IllegalArgumentException("Message must be an instance of MimeMessage");
        }

        MimeMessage mimeMessage = (MimeMessage) message;

        mimeMessage.setFrom(new InternetAddress("noreply@nationalbank.lk")); // Replace with actual sender
        mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        mimeMessage.setSubject("National Bank | Cashier Employee Code");
        mimeMessage.setContent(generateContent(), "text/html; charset=utf-8");

    }
}
