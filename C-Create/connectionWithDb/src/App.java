import java.sql.Connection;
import java.sql.DriverManager;

public class App {
    public static void main(String[] args) {
        try {
            String url = "jdbc:mysql://localhost:3306/JDBC_1";
            String user = "root";
            String pin = "0053";
            Connection con = DriverManager.getConnection(url, user, pin);
            System.out.println("Connected successfully");
            con.close();

        } catch (Exception e) {
            System.out.println(e);
        }
    }
}