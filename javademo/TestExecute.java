import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
public class TestExecute {
	//private static String url = "jdbc:postgresql://10.14.41.109:20158/test";
	private static String url = "jdbc:qianbase://10.14.41.109:20158/test";
	private static String usr = "root";
	private static String pwd = "boyu1105";
	private static final String prepareSql = "prepare s1 as select * from gh where id = $1;";
	private static final String execSql = "execute s1 ('2');";
	public static void main(String[] args) {
		try {
			//Class.forName("org.postgresql.Driver");
			Class.forName("org.qianbase.Driver");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		try {
			Connection conn = DriverManager.getConnection(url, usr, pwd);
			System.out.println("Create conn success !!!!");
			Statement stmt = conn.createStatement();
			
			stmt.execute(prepareSql);
			boolean f = stmt.execute(execSql);
			if (f) {
				ResultSet rs = stmt.getResultSet();
				while (rs.next()) {
					System.out.println(rs.getString(1));
				}
				if (rs != null) {
					rs.close();
				}
			}
			
			if (stmt != null) {
				stmt.close();
			}
			if (conn != null) {
				conn.close();
			}
			System.out.println("Exec test end !!!");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("Exec test fault end !!!");
			e.printStackTrace();
		}
	}
}
