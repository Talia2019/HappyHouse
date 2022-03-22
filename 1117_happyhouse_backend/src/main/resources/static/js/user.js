$(document).ready(function () {
	// 회원가입
    $("#joinBtn").click(function () {
        if (!$("#juserId").val()) {
            alert("아이디 입력!!!");
            return;
        } else if (!$("#jpassword").val()) {
            alert("비밀번호 입력!!!");
            return;
        } else if (!$("#jname").val()) {
            alert("이름 입력!!!");
            return;
        } else if (!$("#jaddress").val()) {
            alert("주소 확인!!!");
            return;  
        } else if (!$("#jphone").val()) {
            alert("전화번호 확인!!!");
            return;  
        } else {
            $("#registerForm").attr("action", "http://localhost/user/register").submit();
        }
    });
    
    //로그인
    $("#loginBtn").click(function () {
        if (!$("#userId").val()) {
            alert("아이디 입력!!!");
            return;
        } else if (!$("#password").val()) {
            alert("비밀번호 입력!!!");
            return;
        } else {
            $("#loginForm").attr("action", "http://localhost/user/login").submit();
        }
    });
    
    //회원정보 수정
    $("#updateBtn").click(function () {
    	if (!$("#upassword").val()) {
            alert("비밀번호 입력");
            return;
        } else if (!$("#uname").val()) {
            alert("이름 입력");
            return;
        } else if (!$("#uaddress").val()) {
            alert("주소 입력");
            return;
        } else if (!$("#uphone").val()) {
            alert("전화번호 입력");
            return;
        } else {
            $("#updateForm").attr("action", "http://localhost/user/update").submit();
        }
    });
	
  //비밀번호 찾기
    $("#findBtn").click(function () {
//    	if (!$("#fuserId").val()) {
//            alert("비밀번호 입력");
//            return;
//        } else if (!$("#fname").val()) {
//            alert("이름 입력");
//            return;
//        } else {
//            $("#findForm").attr("action", "http://localhost/user/find").submit();
//        }
		var id = $("#fuserId").val();
		var name = $("#fname").val();
        $.ajax({
        	url: 'http://localhost/user/find',
        	data: {'id': id, 'name':name},
          	type: 'GET',
          	dataType: 'json',
          	success: function (response) {
          		console.log(response);
//            	var cnt = response.idcount;
            	var msg = response.msg;
        		$("#infoPassword").text(msg).removeClass('text-dark').removeClass('text-primary').addClass('text-danger');
//            	if(cnt == 0) {
//            		$("#infoPassword").text(msg).removeClass('text-dark').removeClass('text-danger').addClass('text-primary');
//            	} else {
//            		$("#infoPassword").text(msg).removeClass('text-dark').removeClass('text-primary').addClass('text-danger');
//            	}
          	}, 
          	error: function(request, status, error) {
          		console.log("status : " + request.status + "\tmsg : " + error);
          	}
		});
    });
})