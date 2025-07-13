package lk.jiat.app.core.util;

public class VerificationUtil {
    public static String generate6DigitCode() {
        int code = 100000 + (int)(Math.random() * 900000);
        return String.valueOf(code);
    }
}
