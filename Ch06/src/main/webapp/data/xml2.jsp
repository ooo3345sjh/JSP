<%@page import="org.jdom2.output.Format"%>
<%@page import="org.jdom2.output.XMLOutputter"%>
<%@page import="org.jdom2.Element"%>
<%@page import="org.jdom2.Document"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="bean.UserBean"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.protocol.Resultset"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="config.DBCP"%>
<%@ page contentType="text/xml;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%> <%-- 공백제거 옵션 추가--%>
<%
	List<UserBean> users = new ArrayList<>();
	try{
		Connection con = DBCP.getConnection();
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT * FROM `user2`");
		
		while(rs.next()){
			UserBean ub = new UserBean();
			ub.setUid(rs.getString(1));
			ub.setName(rs.getString(2));
			ub.setHp(rs.getString(3));
			ub.setAge(rs.getInt(4));
			
			users.add(ub);
		}
		
		con.close();
		rs.close();
		stmt.close();
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	// List를 XML 문서로 생성
	Document doc = new Document();
	Element tagUsers = new Element("users");
	
	for(UserBean ub : users){
		Element tagUser = new Element("user");
		Element tagUid = new Element("uid");
		Element tagName = new Element("name");
		Element tagHp = new Element("hp");
		Element tagAge = new Element("age");
		
		tagUid.setText(ub.getUid());
		tagName.setText(ub.getName());
		tagHp.setText(ub.getHp());
		tagAge.setText(""+ub.getAge()); // age는 Integer형이므로 형변환을 해준다.
		
		tagUser.addContent(tagUid);
		tagUser.addContent(tagName);
		tagUser.addContent(tagHp);
		tagUser.addContent(tagAge);
		
		tagUsers.addContent(tagUser);
	}
	
	doc.setRootElement(tagUsers);
	
	// xml 풀력서식 지정
	XMLOutputter outputter = new XMLOutputter(Format.getPrettyFormat());
	String xml = outputter.outputString(doc);
	
	// xml 출력
	out.print(xml);

%>