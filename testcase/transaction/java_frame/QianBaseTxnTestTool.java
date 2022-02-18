import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

public class QianBaseTxnTestTool extends Thread
{
	public class SqlItem
	{
		String m_strName;
		String m_strSql;
	};
	
	private static Properties conf;
	private SqlItem items;
	private static Connection conn1;
	private static Connection conn2;
	private static Connection conn3;
	private static Connection conn4;
	private static Connection conn5;
	private static Connection conn6;
	private static Connection conn7;
	private static Connection conn8;
	private static Connection conn9;
	private static Connection conn10;
	private static String m_strUrl="";
	private static String m_strUser="";
	private static String m_strPassword="";
	private static String m_strDriver="";
	private  String threadname;	
	
	static{
		String 	strConf = "conf.properties";
		conf = new Properties();
		try {
			conf.load(new InputStreamReader(new FileInputStream(strConf)));
			m_strUrl = conf.getProperty("url");
			m_strUser = conf.getProperty("user");
			m_strPassword = conf.getProperty("password");
			m_strDriver = conf.getProperty("driver");
			Class.forName(m_strDriver);
			conn1 = DriverManager.getConnection(m_strUrl,m_strUser,m_strPassword);
			conn2 = DriverManager.getConnection(m_strUrl,m_strUser,m_strPassword);
			conn3 = DriverManager.getConnection(m_strUrl,m_strUser,m_strPassword);
			conn4 = DriverManager.getConnection(m_strUrl,m_strUser,m_strPassword);
			conn5 = DriverManager.getConnection(m_strUrl,m_strUser,m_strPassword);
			conn6 = DriverManager.getConnection(m_strUrl,m_strUser,m_strPassword);
			conn7 = DriverManager.getConnection(m_strUrl,m_strUser,m_strPassword);
			conn8 = DriverManager.getConnection(m_strUrl,m_strUser,m_strPassword);
			conn9 = DriverManager.getConnection(m_strUrl,m_strUser,m_strPassword);
			conn10 = DriverManager.getConnection(m_strUrl,m_strUser,m_strPassword);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}catch(SQLException ex){
			ex.printStackTrace();
		}catch(IOException ex){
			ex.printStackTrace();
		}
	}

	List<SqlItem> m_lsSql = new ArrayList<SqlItem>();
	Map<String, Connection> m_mapConnect = new HashMap<String, Connection>();
	
	/**
	 * 
	 * @param name
	 * @param conn1
	 * @param conn2
	 * @param conn3
	 * @param conn4
	 * @param conn5
	 * @param conn6
	 * @param conn7
	 * @param conn8
	 * @param conn9
	 * @param conn10
	 * @param item
	 */
	public void executesql(String name,Connection conn1,Connection conn2,Connection conn3,Connection conn4,Connection conn5,Connection conn6,Connection conn7,Connection conn8,Connection conn9,Connection conn10,SqlItem item)
	{
		try
		{
			QianBaseTxnTestTool mv = new QianBaseTxnTestTool();
			if (item.m_strName.trim().equals("1"))
			{
				System.out.println(item.m_strName.trim()+") "+item.m_strSql);
				Statement stmt1 =conn1.createStatement();
				mv.runsql(stmt1, item.m_strName.trim(), item.m_strSql); 
			}else if(item.m_strName.equals("2")){
				System.out.println(item.m_strName+") "+item.m_strSql);
				Statement stmt2 =conn2.createStatement();
				mv.runsql(stmt2, item.m_strName.trim(), item.m_strSql); 
			}else if(item.m_strName.equals("3")){
				System.out.println(item.m_strName+") "+item.m_strSql);
				Statement stmt3 =conn3.createStatement();
				mv.runsql(stmt3, item.m_strName.trim(), item.m_strSql); 
			}else if(item.m_strName.equals("4")){
				System.out.println(item.m_strName+") "+item.m_strSql);
				Statement stmt4 =conn4.createStatement();
				mv.runsql(stmt4, item.m_strName.trim(), item.m_strSql); 
			}else if(item.m_strName.equals("5")){
				System.out.println(item.m_strName+") "+item.m_strSql);
				Statement stmt5 =conn2.createStatement();
				mv.runsql(stmt5, item.m_strName.trim(), item.m_strSql); 
			}else if(item.m_strName.equals("6")){
				System.out.println(item.m_strName+") "+item.m_strSql);
				Statement stmt6 =conn6.createStatement();
				mv.runsql(stmt6, item.m_strName.trim(), item.m_strSql); 
			}else if(item.m_strName.equals("7")){
				System.out.println(item.m_strName+") "+item.m_strSql);
				Statement stmt7 =conn7.createStatement();
				mv.runsql(stmt7, item.m_strName.trim(), item.m_strSql); 
			}else if(item.m_strName.equals("8")){
				System.out.println(item.m_strName+") "+item.m_strSql);
				Statement stmt8 =conn8.createStatement();
				mv.runsql(stmt8, item.m_strName.trim(), item.m_strSql); 
			}else if(item.m_strName.equals("9")){
				System.out.println(item.m_strName+") "+item.m_strSql);
				Statement stmt9 =conn2.createStatement();
				mv.runsql(stmt9, item.m_strName.trim(), item.m_strSql); 
			}else if(item.m_strName.equals("10")){
				System.out.println(item.m_strName+") "+item.m_strSql);
				Statement stmt10 =conn2.createStatement();
				mv.runsql(stmt10, item.m_strName.trim(), item.m_strSql); 
			}else{
				System.out.println("test sql file is not contian "+item.m_strName);
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		System.out.println("");	
	}
		
	public  void runsql(Statement stmt,String strname,String sql){
		try {
			List<String> lsName = new ArrayList<String>();
			List<String> lsSplit = new ArrayList<String>();
			List<Integer> lsWidth = new ArrayList<Integer>();
			String newsql = null;
			if(sql.contains("--hang")){
				newsql = sql.substring(0,sql.indexOf("--hang"));
			}else{
				newsql = sql;
			}
			
			if (sql.toLowerCase().startsWith("select") || (sql.toLowerCase().startsWith("alter") && sql.toLowerCase().contains("split")) || (sql.toLowerCase().startsWith("show") && sql.toLowerCase().contains("ranges")) || (sql.toLowerCase().startsWith("show") && sql.toLowerCase().contains("range")) || (sql.toLowerCase().startsWith("alter") && sql.toLowerCase().contains("experimental_relocate"))){
				ResultSet rs = stmt.executeQuery(newsql);
				ResultSetMetaData rsMeta = rs.getMetaData();
				int nIndex = 0;
				if (rs != null)
				{
					StringBuilder line = new StringBuilder();	
//					System.out.println("aaa===="+rsMeta.getColumnCount());
					int filedlen = 0;
					for (int i = 1; i <= rsMeta.getColumnCount(); i++){
						
						if(sql.toLowerCase().startsWith("select")){
							filedlen = rsMeta.getColumnDisplaySize(i);
							//jsonb getColumnDisplaySizeÄÃµ½Öµ2147483647£¬Ôì³ÉÑ­»·line.append("-")ÄÚ´æÒç³öÎÊÌâ£¬2021-12-06
							if(filedlen > 100000){
								filedlen = 200;
							}
						}else{
							//½â¾öÓÉÓÚgetColumnDisplaySizeÄÃµ½Öµ2147483647£¬Ôì³ÉÑ­»·line.append("-")ÄÚ´æÒç³öÎÊÌâ£¬2021-11-17
							filedlen = 40;
						}
						lsName.add(rsMeta.getColumnName(i));
						lsWidth.add(filedlen);
//						System.out.println("column==="+rsMeta.getColumnName(i)+"   "+rsMeta.getColumnDisplaySize(i)+"  "+rsMeta.getColumnTypeName(i));
						line.setLength(0);
						
						for ( int j = 0; j < filedlen; j++){
							line.append("-");	
						}
						lsSplit.add(line.toString());
					}		
					while(rs.next())
					{
						if (nIndex == 0)
						{
							printLine(true,lsSplit,lsWidth);
			                printLine(false,lsName,lsWidth);
			                printLine(true,lsSplit,lsWidth);				
						}
						
						List<String> lsCols	= new ArrayList<String>();
						
						for (int i = 1; i <= rsMeta.getColumnCount(); i++)
						{
//							System.out.println("columntype===="+rsMeta.getColumnTypeName(i));
							//½â¾ö×Ö¶ÎÀàÐÍÎªbyteaÀàÐÍµÄ¶ÁÈ¡ÎÊÌâ£¬Ç¿ÖÆ×ª»»³ÉÊ®Áù½øÖÆ
							if(rsMeta.getColumnTypeName(i).equalsIgnoreCase("bytea")){
								InputStream ips = rs.getBinaryStream(i);
								String colval = bytetohexstring(getByteaStream(ips));
								lsCols.add(colval);				
							}else{
								//½â¾ö×Ö¶ÎÖµÎªnullµÄÇé¿ö£¬±¨¿ÕÖ¸ÕëµÄÎÊÌâ
								String colvalue = rs.getObject(i)==null ? null : rs.getObject(i).toString();
								lsCols.add(colvalue);
							}
							
						}
						printLine(false,lsCols,lsWidth);
						nIndex ++;		
					}
					if (nIndex > 0){
						printLine(true,lsSplit,lsWidth);
					}
					 System.out.println();
				}
					System.out.println(strname+"): <"+sql+"> query ok "+nIndex+" rows");		
			}else if(sql.toLowerCase().startsWith("explain") || sql.toLowerCase().startsWith("show")){
				ResultSet rs2 = stmt.executeQuery(newsql);
				while(rs2.next()){
					if(sql.toLowerCase().startsWith("explain")){
						System.out.println(rs2.getString(1));
					}else{
						System.out.println(rs2.getString(2));
					}
				}			
			}else{
				int count = 0;
				count = stmt.executeUpdate(sql);
				System.out.println(strname+"): <"+sql+">  query ok "+count+" row affected");	
			}
			stmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	/**
	 * ½«byteaÀàÐÍ¶þ½øÖÆÁ÷×ª»»³Ébyte[]Êý×é
	 * @param ips
	 * @return
	 */
	public static byte[] getByteaStream(InputStream ips){
		ByteArrayOutputStream outstream = new ByteArrayOutputStream();
		try {
			byte[] buffer = new byte[ips.available()];
			int len = -1;
			while((len = ips.read(buffer)) != -1){
				outstream.write(buffer,0,len);
			}
			outstream.close();
			ips.close();		
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return outstream.toByteArray();
	}
	
	public static String bytetohexstring(byte[] bytes) {
		StringBuilder sBuilder = new StringBuilder();
		String hexString = "";
		try {
			for (int i = 0; i < bytes.length; i++) {
				String strHex = Integer.toHexString(bytes[i] & 0xFF);
				sBuilder.append(strHex);
			}
			hexString = sBuilder.toString().toUpperCase();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return hexString;
	}
	
	/**
	 * 
	 * @param rs
	 * @param sql
	 * @throws SQLException
	 ********************/
	/*****************
	public void printResult(ResultSet rs,String sql) throws SQLException{
		List<String> lsName = new ArrayList<String>();
		List<String> lsSplit = new ArrayList<String>();
		List<Integer> lsWidth = new ArrayList<Integer>();
		
		StringBuilder line = new StringBuilder();
		ResultSetMetaData rsMeta = rs.getMetaData();
		for (int i = 1; i <= rsMeta.getColumnCount(); i++){
			lsName.add(rsMeta.getColumnName(i));
			lsWidth.add(rsMeta.getColumnDisplaySize(i));
			
			line.setLength(0);
			
			for ( int j = 0; j < rsMeta.getColumnDisplaySize(i); j++){
				line.append("-");	
			}
			lsSplit.add(line.toString());
		}	
		
		int nIndex = 0;
		while(rs.next()){
			if (nIndex == 0)
			{
				printLine(true,lsSplit,lsWidth);
                printLine(false,lsName,lsWidth);
                printLine(true,lsSplit,lsWidth);				
			}	
			List<String> lsCols	= new ArrayList<String>();
			for (int i = 1; i <= rsMeta.getColumnCount(); i++){
				String colvalue = rs.getObject(i)==null ? null : rs.getObject(i).toString();
				lsCols.add(colvalue);
			}
			printLine(false,lsCols,lsWidth);	
			nIndex ++;		
		}
		if (nIndex > 0){
			printLine(true,lsSplit,lsWidth);
		}
	}
******************************/
	/**
	 * 
	 * @param bHeader
	 * @param lsCols
	 * @param lsWith
	 */
	public void printLine(boolean bHeader,List<String> lsCols,List<Integer> lsWith)
	{
		StringBuilder line = new StringBuilder();
		for (int i = 0; i < lsCols.size(); i++){
			if (i == 0){
				if (bHeader)
					line.append('+');
				else
					line.append('|');
			}
			line.append(lsCols.get(i));	
			int collength = lsCols.get(i) == null ? 4 : lsCols.get(i).length();
			for (int j = collength; j < lsWith.get(i);j++){
				line.append(' ');
			}
			if (bHeader)
				line.append('+');
			else
				line.append('|');			
		}
		System.out.println(line.toString());				
	}
	
	public QianBaseTxnTestTool(){
		System.out.print("");
	}
	
	public QianBaseTxnTestTool(String name,SqlItem item){
		items = item;
		threadname = name;
	}
		
	public void run(){
		try {
			if(items.m_strName.equals("20")){
				//print zhushi
				System.out.println(items.m_strSql);
			}else{
				executesql(threadname,conn1,conn2,conn3,conn4,conn5,conn6,conn7,conn8,conn9,conn10,items);
			}	
			//±ØÐëÃ¿¸öÏß³ÌÖ´ÐÐÍêºósleep
			Thread.sleep(2000);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
		
	public  List<SqlItem> readfile(String strFile,List<SqlItem> lsSql) throws IOException{
		BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(strFile)));
			
		for(String strLine = br.readLine();strLine != null;strLine = br.readLine()){
			strLine = strLine.trim();
			SqlItem sqlItem = new SqlItem();
			if (strLine.startsWith("#") || strLine.isEmpty() || strLine.startsWith("--")){
				sqlItem.m_strName = "20";
				sqlItem.m_strSql = strLine;
				lsSql.add(sqlItem);
				continue;
			}
			String aSplit[] = strLine.split("\t");
			if(aSplit.length == 2){
				
				sqlItem.m_strName = aSplit[0];
				sqlItem.m_strSql = aSplit[1];
				lsSql.add(sqlItem);
			}
		}	
			br.close();
			return lsSql;
	}
	
	/**
	 * close all connection
	 */
	public static void CloseAllConn(){
		try {
			if(conn1 != null){
				conn1.close();
			}
			if(conn2 != null){
				conn2.close();
			}
			if(conn3 != null){
				conn3.close();
			}
			if(conn4 != null){
				conn4.close();
			}
			if(conn5 != null){
				conn5.close();
			}
			if(conn6 != null){
				conn6.close();
			}
			if(conn7 != null){
				conn7.close();
			}
			if(conn8 != null){
				conn8.close();
			}
			if(conn9 != null){
				conn9.close();
			}
			if(conn10 != null){
				conn10.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
		
	public static void main(String[] args){			
		String m_strFile = args[0];
		List<SqlItem> m_lsSql = new ArrayList<SqlItem>();	
		try{
			QianBaseTxnTestTool tx = new QianBaseTxnTestTool();
			tx.readfile(m_strFile,m_lsSql);
			QianBaseTxnTestTool T1 = null;
			for (int i = 0; i < m_lsSql.size(); i++){
				T1 = new QianBaseTxnTestTool("threadname_"+i,m_lsSql.get(i));
				T1.setDaemon(true);
				T1.start();		
				if(m_lsSql.get(i).m_strSql.contains("--hang")){
					T1.join(20000);
				}else{
					T1.join();
				}
			}	
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			CloseAllConn();
		}
	}

}
