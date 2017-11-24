<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
window.addEventListener("load", function(event){
	
	var conBtn = document.querySelector("#con-btn");
	var socket = null;
	
	conBtn.addEventListener("click", function(e){
		socket = new WebSocket("we://211.238.142.78/SpringWeb/chat-server");	// 서버 생성
		socket.onopen = function(evt){		// 시작 때 한번 호출
			alert("연결되었습니다.");
		};		
		socket.onmessage = function(){};	// 메세지 오갈 때마다 호출
		socket.oncloase = function(){};		// 끝낼 때 한번 호출
	});
});
</script>
</head>
<body>
	<div style="border: 1px solid #e9e9e9; width: 300px; height: 500px; padding: 10px; background: orange;">
		<div>
			<input id="con-btn" type="button" value="접속" />
		</div>
		<div id="chat-list" style="border: 1px solid #e9e9e9; background: white;  height: 430px">
			
		</div>
		<div style="border: 1px solid #e9e9e9; background: white; height: 50px;">
			<textarea id="chat-text" style="width:98.5%; height: 100%;"></textarea>
		</div>
	</div>
</body>
</html>