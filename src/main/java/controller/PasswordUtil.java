package controller;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {
    // Mã hóa mật khẩu bằng BCrypt
    public static String hashPassword(String plainTextPassword) {
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt(12)); // 12 là độ mạnh của mã hóa
    }

    // Kiểm tra mật khẩu khi đăng nhập
    public static boolean checkPassword(String plainTextPassword, String hashedPassword) {
        return BCrypt.checkpw(plainTextPassword, hashedPassword);
    }
}

