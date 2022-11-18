package dao;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import db.DBHelper;
import vo.BookVO;
import vo.CustomerVO;

public class CustomerDAO extends DBHelper {
	
	private static CustomerDAO instance = new CustomerDAO();
	
	public static CustomerDAO getInstance () {
		return instance;
	}
	private CustomerDAO () {}
	
	public List<CustomerVO> selectCustomers() {
		List<CustomerVO> lists = null;
		
		try {
			logger.info("selectCustomers...");
			con = getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery("SELECT * FROM `customer`");
			
			lists = new ArrayList<>();
			
			while(rs.next()) {
				CustomerVO vo = new CustomerVO();
				vo.setCustID(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setAddress(rs.getString(3));
				vo.setPhone(rs.getString(4));
				
				lists.add(vo);
			}
			
			close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("lists : " + lists);
		return lists;
	}
	
	public CustomerVO selectCustomer(String custID) {
		CustomerVO vo = null;
		
		try {
			logger.info("selectCustomer...");
			con = getConnection();
			psmt = con.prepareStatement("SELECT * FROM `customer` WHERE `custId`=?");
			psmt.setString(1, custID);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				vo = new CustomerVO();
				vo.setCustID(rs.getInt(1));
				vo.setName(rs.getString(2));
				vo.setAddress(rs.getString(3));
				vo.setPhone(rs.getString(4));
			}
			
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
		logger.debug("vo : " + vo);
		return vo;
	}
	public void updateCustomer(CustomerVO vo) {
		try {
			logger.info("updateCustomer...");
			con = getConnection();
			String sql = "UPDATE `customer` SET "
					   + " `name`=?,"
					   + " `address`=?,"
					   + " `phone`=? "
					   + " WHERE `custId`=? ";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, vo.getName());
			psmt.setString(2, vo.getAddress());
			psmt.setString(3, vo.getPhone());
			psmt.setInt(4, vo.getCustID());
			
			psmt.executeUpdate();
			
			close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
	}
	public void insertCustomer(CustomerVO vo) {
		try {
			logger.info("insertCustomer...");
			con = getConnection();
			String sql = "INSERT INTO `customer` SET "
					   + " `name`=?,"
					   + " `address`=?,"
					   + " `phone`=? ";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, vo.getName());
			psmt.setString(2, vo.getAddress());
			psmt.setString(3, vo.getPhone());
			
			psmt.executeUpdate();
			
			close();
			
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
	}
	
	public void deleteCustomer(String custID) {
		try {
			logger.info("deleteCustomer...");
			con = getConnection();
			psmt = con.prepareStatement("DELETE FROM `customer` WHERE `custId`=?");
			psmt.setString(1, custID);
			
			psmt.executeUpdate();
			
			close();
		} catch (Exception e) {
			logger.error(e.getMessage());
		}
	}
}
