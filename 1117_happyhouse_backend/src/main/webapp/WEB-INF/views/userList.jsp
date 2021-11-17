<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<div style="margin: 100px 100px;">
<h2 style="margin-bottom: 20px;">회원 검색</h2>
	
	<!-- 	검색 -->
	<div style="border: 1px solid black;">
		<label for="searchid">아이디</label> <input type="text" id="searchid"
			name="searchid" placeholder="검색할 아이디">
		<button type="button" id="searchBtn">검색</button>
	</div>

	<!-- 	리스트 -->
	<table>
		<colgroup>
			<col width="200">
			<col width="200">
			<col width="200">
			<col width="200">
		</colgroup>
		<thead>
			<tr>
				<td>아이디</td>
				<td>이름</td>
				<td>주소</td>
				<td>번호</td>
			</tr>
		</thead>
		<tbody id="userlist"></tbody>
	</table>

</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>


<script type="text/javascript">
$(document).ready(function() {
	//회원 목록
	$.ajax({
		url:'${root}/user/userlist',  
		type:'GET',
		contentType:'application/json;charset=utf-8',
		dataType:'json',
		success:function(users) {
			makeList(users);
		},
		error:function(xhr, status, error){
			console.log("상태값 : " + xhr.status + "\tHttp 에러메시지 : " + xhr.responseText);
		},
		statusCode: {
			500: function() {
				alert("서버에러.");
				// location.href = "/error/e500";
			},
			404: function() {
				alert("페이지없다.");
				// location.href = "/error/e404";
			}
		}	
	});
	

	//키워드로 이름 검색
	$(document).on("click", "#searchBtn", function(){
		var searchName = $("#searchid").val();
		$.ajax({
		url:'${root}/user/userlist/' + searchName,  
		type:'GET',
		contentType:'application/json;charset=utf-8',
		dataType:'json',
		success:function(users) {
			makeList(users);
		},
		error:function(xhr, status, error){
			console.log("상태값 : " + xhr.status + "\tHttp 에러메시지 : " + xhr.responseText);
		},
		statusCode: {
			500: function() {
				alert("서버에러.");
				// location.href = "/error/e500";
			},
			404: function() {
				alert("페이지없다.");
				// location.href = "/error/e404";
			}
		}	
		});
	});
});

function makeList(users) {
	console.log("??");
	$("#userlist").empty();//한번 비움
	$(users).each(function(index, user) {
	let str = `
	<tr id="view_${'${user.userId}'}" class="view" data-id="${'${user.id}'}">
		<td>${'${user.userId}'}</td>
		<td>${'${user.name}'}</td>
		<td>${'${user.address}'}</td>
		<td>${'${user.phone}'}</td>
	</tr>
	`;
	$("#userlist").append(str);
	});
}
</script>

</html>