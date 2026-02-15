import java.sql.*;
public class DESC {
    static String url="jdbc:mysql://localhost:3306/JDBC_1";
    static String user="root";
    static String pin="0053";
    static Connection con;
    public static void main(String[] args){
        try {
            con=DriverManager.getConnection(url, user, pin);
            Statement st=con.createStatement();
            String sql="desc users";
            ResultSet rs=st.executeQuery(sql);
            while(rs.next()){
              System.out.println(
                rs.getString("Field")
                +" : "+
                rs.getString("Type"));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}

