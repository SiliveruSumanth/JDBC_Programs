import java.sql.*;
import java.util.Scanner;
public class App {
    static Scanner sc;
    static Connection con;
    static String url="jdbc:mysql://localhost:3306/JDBC_1";
    static String user="root";
    static String pin="0053";
    public static void insertion() {
   try {
       con=DriverManager.getConnection(url,user,pin);

       System.out.print("Enter user_id : ");
       int user_id=sc.nextInt();
       sc.nextLine();

       System.out.print("Enter the User Name : ");
       String name=sc.nextLine();

       System.out.print("Enter Email: ");
       String email = sc.nextLine();

       System.out.print("Enter Phone: ");
       String phone = sc.nextLine();

       System.out.print("Enter Password: ");
       String password = sc.nextLine();

       java.sql.Date today = new java.sql.Date(System.currentTimeMillis());

       String sql = "INSERT INTO users(User_id,Name,Email_id,Phone,Password,Created_on) VALUES(?,?,?,?,?,?)";

       PreparedStatement ps = con.prepareStatement(sql);

       ps.setInt(1, user_id);
       ps.setString(2, name);
       ps.setString(3, email);
       ps.setString(4, phone);
       ps.setString(5, password);
       ps.setDate(6, today);

       ps.executeUpdate();

       System.out.println("Inserted Successfully");
       System.out.println();
       ps.close();
       con.close();

   } catch (Exception e) {
        e.printStackTrace();
   }
}
    public static void main(String[] args) {
        sc=new Scanner(System.in);
        boolean b=true;
       while(b){
            System.out.printf("1.Insert data \n2.stop \nEnter the option to perfom : ");
            int otn=sc.nextInt();
            switch (otn) {
                case 1:
                    insertion();
                    break;
                case 2:
                    b=false;
                    break;
                default:
                    System.out.println("Enter the option correctly");
            }
        }
        sc.close(); 
    }
}
