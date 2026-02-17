import java.sql.*;
import java.util.Scanner;

public class DeleteUser {

    public static void main(String[] args) {

        String url = "jdbc:mysql://localhost:3306/JDBC_1";
        String user = "root";
        String pin = "0053";

        Scanner sc = new Scanner(System.in);
        System.out.print("Enter user id to delete: ");
        int id = sc.nextInt();

        try (
            Connection con = DriverManager.getConnection(url, user, pin);
            PreparedStatement ps = con.prepareStatement("DELETE FROM users WHERE user_id = ?");
        ) {

            ps.setInt(1, id);
            int rows = ps.executeUpdate();

            if (rows > 0)
                System.out.println("User deleted successfully");
            else
                System.out.println("User not found");

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        sc.close();
    }
}
