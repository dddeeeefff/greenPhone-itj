package dao;

import static db.JdbcUtil.*;	// JdbcUtil 클래스의 모든 멤버들을 자유롭게 사용
import java.util.*;
import java.sql.*;
import vo.*;

public class MemberProcInDao {
		private static MemberProcInDao memberProcInDao;
		private Connection conn;
		private MemberProcInDao() {}
		
		public static MemberProcInDao getInstance() {
			if (memberProcInDao == null) { 
				memberProcInDao = new MemberProcInDao();
			}
			
			return memberProcInDao;
		}
		
		public void setConnection(Connection conn) {
			this.conn = conn;
		}
		
		public int memberProcIn(MemberInfo memberInfo) {
			CallableStatement cstmt = null;
			int result = 0;
			
			try {
				String sql = "{call sp_join_member(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
				cstmt = conn.prepareCall(sql);
				cstmt.setString(1, memberInfo.getMi_id());
				cstmt.setString(2, memberInfo.getMi_pw());
				cstmt.setString(3, memberInfo.getMi_name());
				cstmt.setString(4, memberInfo.getMi_gender());
				cstmt.setString(5, memberInfo.getMi_birth());
				cstmt.setString(6, memberInfo.getMi_phone());
				cstmt.setString(7, memberInfo.getMi_email());
				cstmt.setString(8, memberInfo.getMi_zip());
				cstmt.setString(9, memberInfo.getMi_addr1());
				cstmt.setString(10, memberInfo.getMi_addr2());
				cstmt.registerOutParameter(11, java.sql.Types.INTEGER);
				cstmt.execute();
				result = cstmt.getInt(11);
									
			} catch (Exception e) {
				System.out.println("MemberProcInDao 클래스의 memberProcIn() 메소드 오류");
				e.printStackTrace();
				
			} finally {
				close(cstmt);
				
			}
			
			return result;
		}
}
