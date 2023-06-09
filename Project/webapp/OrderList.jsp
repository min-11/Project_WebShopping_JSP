<%@page import="orderdb.OrderDetailsVO"%>
<%@page import="orderdb.OrderDetailsDAO"%>
<%@page import="orderdb.OrderVO"%>
<%@page import="orderdb.OrderDAO"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="Header.jsp" %>
<%@ include file="Sidebar.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>

table{
	margin-left:auto;
	margin-right:auto;
	margin-bottom:20px;	
	padding-left:5px;
	border: 2px solid #dcdcdc;
	display:none;
}

.orderDate {caption-side: top;}

table th {
	padding-right:80px;
}

table td {
	
}

.state { 
	padding-left:350px;
	padding-right:40px; 
	text-align:right;
}

.detail { 
	padding-left:40px;
	padding-right:40px;
	text-align:right; 
}

#moreBtn { display:none; }

#minusBtn { display:none; }

</style>

</head>
<body>

	<%
		OrderDAO odao = new OrderDAO();
		ArrayList<OrderVO> ovArray = new ArrayList<>();
		
		ovArray = odao.getInfo(id);
		
		OrderDetailsDAO oddao = new OrderDetailsDAO();
		ArrayList<OrderDetailsVO> odvArray = new ArrayList<>();
		
	%>


<section>
	<article class="card-body" style="max-width:800px; margin: auto;">
		<br>
		<h1 style="text-align: center;">주문내역</h1>
		<hr>
		
		
		<% for (OrderVO imsi : ovArray) { %>
		<table style="width:800px;">
			<caption class="orderDate">주문내역 : <%=imsi.getOrder_date() %></caption>
			<tr>
				<th>상품명</th>
				<td colspan=3><%=oddao.select_listMainName(imsi.getOrder_num()) %> 등 <%=oddao.select_count(imsi.getOrder_num()) %>건</td>
			</tr>
			<tr>	
				<th>주문번호</th>
				<td><%=imsi.getOrder_num() %></td>
				<td class="state" style="text-align:right;"><b><%=imsi.getDelivery_state() %></b></td>
				<td class="detail" style="text-align:right;">
					<a href="OrderDetails.jsp?order_num=<%=imsi.getOrder_num() %>" class="btn btn-outline-primary btn-sm">상세보기</a>
				</td>
			</tr>
			<tr>	
				<th>결제방법</th><td colspan=3>카카오페이</td>
			</tr>
			<tr>	
				<th>결제금액</th><td colspan=3><%=oddao.select_refundPrice(imsi.getOrder_num(), imsi.getTotal_price()) %>원</td>
			</tr>	
		</table>
		<% } %>
	
		<div id="moreBtn" align="center"><a href='#' id='load'>더보기</a></div>
		<div id="minusBtn" align="center"><a href='#' id='mload'>접기</a></div>
	
	</article>
</section>	

<script> 

$(function(){
    $("table").slice(0, 3).show(); // select the first ten
  	if($("table").length >= 3) {
  		$("#moreBtn").show();
  	}
    $("#load").click(function(e){ // click event for load more
        e.preventDefault();
        $("table:hidden").slice(0, 3).show(); // select next 10 hidden divs and show them
        if($("table:hidden").length == 0){ // check if any hidden divs still exist
        	$("#moreBtn").hide(); // alert if there are none left
        	$('#minusBtn').show();
        }
    });
    
    $("#mload").click(function(e) {
    	e.preventDefault();
    	$('table').hide();
    	$('table').slice(0,3).show();
    	$('#minusBtn').hide();
    	if($("table").length >= 3) {
      		$("#moreBtn").show();
      	}
    });
    
});
</script>

</body>
</html>