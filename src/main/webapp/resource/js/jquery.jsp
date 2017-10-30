<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript">
		//window.addEventListener("load", function(){
		$(function() {
			// DOM 객체를
			// var _chButton = document.getElementById("ch-button");		
			// jQuery 객체로 바꾸는 방법 1 : jQuery 함수 이용
			// var chButton = jQuery(_chButton);
			// jQuery 객체로 바꾸는 방법 2 : $ 함수 이용
			// var chButton = $(_chButton);		
			// jQuery 객체로 바꾸는 방법 3 : CSS Selector 이용
			var chBtn = $("#ch-button");

			// 이벤트 바인딩 두가지 옵션 : 첫번째 범용 이벤트 바인딩 함수 on()
			/* chBtn.on("click", function() {
				alert("aa");
			}); */
			// 이벤트 바인딩 두가지 옵션 : 두번째 범용 이벤트 바인딩 함수 click/keydown...()
			chBtn.click(function() {
				// 여러 스타일 설정해야 할 경우 1
				/* $("#p").css("background", "orange");
				$("#p").css("font-size", "13px"); */

				// 여러 스타일 설정해야 할 경우 2
				$("#p").css({
					background : "orange",
					"font-size" : "13px"
				});
			});
		});

		//--------------- 속성 변경 ---------------
		$(function() {
			var chImgButn = $("#ch-img-button");
			var container = $("#img-container");
			var img = $("img");
			var imgSrc = $("#img-src");

			chImgButn.click(function() {
				img.attr("src", imgSrc.val());
			});
		});

		//--------------- 자식 노드 변경 ---------------
		$(function() {
			var chNodeBtn = $("#ch-node-button");
			var container = $("#ch-node-container");

			chNodeBtn.click(function() {
				// 1. 텍스트 노드 추가
				container.text("<h1>TEST-text</h1>");

				// 2. Element 노드 추가
				//container.html("<h1>TEST-html</h1>");
			});
		});

		//--------------- 텍스트 노드 추가 ---------------
		$(function() {
			var addTextNodeBtn = $("#add-text-node-button");
			var addImgNodeBtn = $("#add-img-node-button");
			var removeNodeBtn = $("#remove-node-button");
			var container = $("#node-container");

			var remove = function(e) {
				container.removeChild(this);
			}
			
			var idx = 0;
			addTextNodeBtn.click(function() {
				var span = $('<span />');
				var txt = '안녕하세여' + idx++;
				
				span.append(txt);
				container.append(span);

				span.click(remove);

			});
			
			addImgNodeBtn.click(function() {
				// How to 1(성능에 좋음)
				// 너무 DOM 사용 스타일
				/* var img = $('<img />');
				img.attr("src", "https://static.independent.co.uk/s3fs-public/styles/article_small/public/thumbnails/image/2017/07/02/17/teacup-puppy.jpg");				
				container.append(img);
				img.click(remove); */
				
				// jQuery 식 스타일
				$("<img src='http://www.telegraph.co.uk/content/dam/news/2017/06/16/TELEMMGLPICT000132082481-xlarge_trans_NvBQzQNjv4BqgsaO8O78rhmZrDxTlQBjdO0Jyi0jPPD6Zx1hiwTPhlc.jpeg' />")
				.appendTo(container/* 부모 */).click(remove);
				
				// How to 2 (성능에 좋지 않지만 편리함.-> 한두개 넣는 상황의 성능에 영향을 주지 않을 거라면 이를 사용)
				//container.html('<img onClick="remove()" src="http://www.telegraph.co.uk/content/dam/news/2017/06/16/TELEMMGLPICT000132082481-xlarge_trans_NvBQzQNjv4BqgsaO8O78rhmZrDxTlQBjdO0Jyi0jPPD6Zx1hiwTPhlc.jpeg');

			});
			
			removeNodeBtn.click(function() {
				// 1. 내정된 노드를 지우기
				if (container.hasChildNodes()) {
					container.removeChild(container.lastChild);
				}
				// 2. 선택된 노드를 지우기

			});
		});
	</script>

	<!--------------- 텍스트 노드 추가 --------------->
	<input id="add-text-node-button" type="button" value="텍스트노드 추가" />
	<input id="add-img-node-button" type="button" value="이미지노드 추가" />
	<input id="remove-node-button" type="button" value="노드 삭제" />
	<div id="node-container"></div>
	<hr />

	<!--------------- 자식 노드 변경 --------------->
	<input id="ch-node-button" type="button" value="자식노드 변경" />
	<div id="ch-node-container">hello</div>
	<hr />

	<!--------------- 속성 변경 --------------->
	<p>
	<hr />
	<input id="img-src" type="text" />
	<input id="ch-img-button" type="button" value="이미지 변경" />
	<p>
	<div id="img-container">
		<img
			src="http://www.travie.com/data/editor/1612/thumb-982933293_1480557706.03_640x427.jpg">
	</div>

	<!--------------- 노드 순회 --------------->
	<p>
	<hr />
	<input id="ch-button" type="button" value="배경색 변경" />
	<div>
		<div>1</div>
		<div id="p">
			<div>2</div>
		</div>
		<div>3</div>
	</div>
</body>
</html>