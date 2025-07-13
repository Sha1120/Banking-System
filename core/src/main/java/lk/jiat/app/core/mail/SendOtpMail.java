package lk.jiat.app.core.mail;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import lk.jiat.app.core.provider.MailServiceProvider;

import java.util.Properties;

public class SendOtpMail extends Mailable {

    private final String to;
    private final String otpCode;

    public SendOtpMail(String to, String otpCode) {
        this.to = to;
        this.otpCode = otpCode;
    }

    private String generateHtmlContent() {
        return "<html>" +
                "<body>" +
                "<h2>National Bank OTP Verification</h2>" +
                "<p>Your One-Time Password (OTP) is:</p>" +
                "<h1 style='color: #2980b9;'>" + otpCode + "</h1>" +
                "<p>Please use this code to log into your account. It is valid for a limited time only.</p>" +
                "<br/><small style='color: red;'>Do not share this OTP with anyone.</small>" +
                "</body>" +
                "</html>";
    }

    @Override
    public void run() {
        try {
            Properties props = MailServiceProvider.getInstance().getProperties();
            Authenticator auth = MailServiceProvider.getInstance().getAuthenticator();
            Session session = Session.getInstance(props, auth);

            Message message = new MimeMessage(session);
            build(message); // <-- use build() method to construct email
            Transport.send(message);

            System.out.println("OTP Email sent to " + to);

        } catch (Exception e) {
            e.printStackTrace(); // Log properly in production
        }
    }

    @Override
    public void build(Message message) throws Exception {
        if (!(message instanceof MimeMessage)) {
            throw new IllegalArgumentException("Message must be an instance of MimeMessage");
        }

        MimeMessage mimeMessage = (MimeMessage) message;

        mimeMessage.setFrom(new InternetAddress("noreply@nationalbank.lk")); // Replace with actual sender
        mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        mimeMessage.setSubject("Your OTP Code");
        mimeMessage.setContent(generateHtmlContent(), "text/html; charset=utf-8");
    }
}
