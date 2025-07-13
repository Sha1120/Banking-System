package lk.jiat.app.core.mail;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import lk.jiat.app.core.provider.MailServiceProvider;

import java.util.Properties;

public class SendAccountMail extends Mailable {

    private final String to;
    private final String accountNumber;

    public SendAccountMail(String to, String accountNumber) {
        this.to = to;
        this.accountNumber = accountNumber;
    }

    @Override
    public void run() {
        try {
            Properties props = MailServiceProvider.getInstance().getProperties();
            Authenticator auth = MailServiceProvider.getInstance().getAuthenticator();
            Session session = Session.getInstance(props, auth);

            Message message = new MimeMessage(session);
            build(message); // Delegate message creation

            Transport.send(message);
            System.out.println("Email sent to " + to);

        } catch (Exception e) {
            e.printStackTrace(); // In production, use proper logging
        }
    }

    @Override
    public void build(Message message) throws Exception {
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject("Your National Bank Account Number");
        message.setText(
                "Dear Customer,\n\n" +
                        "Your account was created successfully.\n" +
                        "Account Number: " + accountNumber + "\n\n" +
                        "Thank you for choosing National Bank!"
        );
    }
}
