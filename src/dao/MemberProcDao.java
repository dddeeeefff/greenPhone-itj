package dao;

import static db.JdbcUtil.*;	// JdbcUtil 클래스의 모든 멤버들을 자유롭게 사용
import java.util.*;
import java.sql.*;
import vo.*;

public class MemberProcDao {
	// 회원 정보수정에 관련된 쿼리 작업을 처리하는 클래스
	private static MemberProcDao memberProcUpDao;
	private Connection conn;
	private MemberProcDao() {}
	
	public static MemberProcDao getInstance() {
		if (memberProcUpDao == null) { 
			memberProcUpDao = new MemberProcDao();
		}
		return memberProcUpDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public int memberProcUp(MemberInfo memberInfo) {
		// 사용자가 입력한 데이터들로 정보수정을 하는 메소드
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "update t_member_info set " + 
			" mi_phone = '" + memberInfo.getMi_phone()	+ "', " +
			" mi_email = '" + memberInfo.getMi_email()	+ "', " +
			" mi_zip = '"	+ memberInfo.getMi_zip()	+ "', " +
			" mi_addr1 = '"	+ memberInfo.getMi_addr1()	+ "', " +
			" mi_addr2 = '"	+ memberInfo.getMi_addr2()	+ "' " +
			" where mi_id = '" + memberInfo.getMi_id()	+ "' ";
			System.out.println(sql);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);			
		} catch (Exception e) {
			System.out.println("MemberProcDao 클래스의 memberProcUp() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return result;
	}

	public int changePwProc(MemberInfo memberInfo) {
		Statement stmt = null;
		int result = 0;
		
		try {
			String sql = "update t_member_info set " + 
			" mi_pw = '" + memberInfo.getMi_pw() + "' " +
			" where mi_id = '" + memberInfo.getMi_id()	+ "' ";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);			
		} catch (Exception e) {
			System.out.println("MemberProcDao 클래스의 changePwProc() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return result;

	}

	public int memberOutProc(MemberInfo memberInfo) {
		Statement stmt = null;
		int result = 0;

		try {
			String sql = "update t_member_info set " +
			" mi_status = 'b' where mi_id = '" + memberInfo.getMi_id() +"' "; 
			System.out.println(sql);
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);			

		} catch (Exception e) {
			System.out.println("MemberProcDao 클래스의 memberOutProc() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return result;
		
	}

	public ArrayList<MemberPoint> getMemberPointList(String miid) {
		ArrayList<MemberPoint> memberPointList = new ArrayList<MemberPoint>();
		Statement stmt = null;
		ResultSet rs = null;
		MemberPoint memberPoint = null;
		
		try {
			String sql = "select * from t_member_point where mi_id = '" + miid + "' order by mp_date asc;";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				memberPoint = new MemberPoint();
				memberPoint.setMi_id(miid);
				memberPoint.setMp_su(rs.getString("mp_su"));
				memberPoint.setMp_desc(rs.getString("mp_desc"));
				memberPoint.setMp_point(rs.getInt("mp_point"));
				memberPoint.setMp_detail(rs.getString("mp_detail"));
				memberPointList.add(memberPoint);
			}

		} catch (Exception e) {
			System.out.println("MemberProcDao 클래스의 getMemberPointList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);	close(rs);
		}
		
		return memberPointList;
	}

}
