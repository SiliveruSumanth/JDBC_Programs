import java.sql.*;
import java.util.Scanner;
public class UpdateCName {
    static String url="jdbc:mysql://localhost:3306/JDBC_1";
    static String user="root";
    static String pin="0053";
    static Connection con;
    static Scanner sc;
    public static void update(){
        sc=new Scanner(System.in);
        try {
            con = DriverManager.getConnection(url, user, pin);
            System.out.print("Enter user id: ");
            int user_id = sc.nextInt();
            sc.nextLine();
            System.out.print("Enter new name: ");
            String Name = sc.nextLine();
            String sql = "UPDATE users SET Name = ? WHERE user_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, Name);
            ps.setInt(2, user_id);
            int rows = ps.executeUpdate();
            if(rows > 0)
                System.out.println("Name updated");
            else
                System.out.println("No user found");
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    public static void main(String[] args){
        update();
    }
}
