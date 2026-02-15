import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.*;
public class create {
    static String url="jdbc:mysql://localhost:3306/JDBC_1";

            // url => "jdbc:{platform_name}://{Localhost}/{Database_name}"
        
    static String user="root";
    static String pin="0053";//password of your platform
    static Connection con;
    public static void create_table(String sql){
        try {
            con=DriverManager.getConnection(url, user, pin); // connects to your database
            Statement s=con.createStatement();
            s.execute(sql);// helps to execute the query
            System.out.println(" Table has created");
            s.close();
            con.close();
            
        }
        catch(Exception e){
            System.out.println(e);
        }
    }
    public static void main(String[] args) {
        Scanner sc=new Scanner(System.in);
        System.out.println("Enter the query to create a table : ");
        String sql=sc.nextLine();
        create_table(sql);
    }
}
