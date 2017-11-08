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
			};

			var idx = 0;
			addTextNodeBtn.click(function() {
				var span = $('<span />');
				var txt = '안녕하세여' + idx++;

				span.append(txt);
				container.append(span);

				span.click(remove);

			});

			addImgNodeBtn
					.click(function() {
						// How to 1(성능에 좋음)
						// 너무 DOM 사용 스타일
						/* var img = $('<img />');
						img.attr("src", "https://static.independent.co.uk/s3fs-public/styles/article_small/public/thumbnails/image/2017/07/02/17/teacup-puppy.jpg");				
						container.append(img);
						img.click(remove); */

						// jQuery 식 스타일
						$(
								"<img src='http://media3.giphy.com/media/kEKcOWl8RMLde/giphy.gif' />")
								.appendTo(container/* 부모 */).click(remove);

						// How to 2 (성능에 좋지 않지만 편리함.-> 한두개 넣는 상황의 성능에 영향을 주지 않을 거라면 이를 사용)
						//container.html('<img onClick="remove()" src="http://www.telegraph.co.uk/content/dam/news/2017/06/16/TELEMMGLPICT000132082481-xlarge_trans_NvBQzQNjv4BqgsaO8O78rhmZrDxTlQBjdO0Jyi0jPPD6Zx1hiwTPhlc.jpeg');

					});

			removeNodeBtn.click(function() {
				// 1. 내정된 노드를 지우기
				/* $("#node-container *:last-child").remove();	// css 형식 이용
				$("#node-container").children().last().remove();	// jQuery 객체 이용 */
				//$("#node-container img").eq(0).attr("src", "http://www.telegraph.co.uk/content/dam/news/2017/06/16/TELEMMGLPICT000132082481-xlarge_trans_NvBQzQNjv4BqgsaO8O78rhmZrDxTlQBjdO0Jyi0jPPD6Zx1hiwTPhlc.jpeg");
				//$("#node-container img").get(0).src="http://www.telegraph.co.uk/content/dam/news/2017/06/16/TELEMMGLPICT000132082481-xlarge_trans_NvBQzQNjv4BqgsaO8O78rhmZrDxTlQBjdO0Jyi0jPPD6Zx1hiwTPhlc.jpeg";
				//$("#node-container img").each(function(index){
				$(this).remove();

				// 2. 선택된 노드를 지우기

			});
		});

		//--------------- 노드 바꾸기 ---------------
		$(function() {
			var swapNodeButton = $("#swap-node-button");
			var container = $("#swap-node-container");

			swapNodeButton.click(function() {
				var nodes = container.find("img"); //	var nodes = ("#swap-node-container img"); 동일한 방법

				var node1 = nodes.eq(0);
				var node2 = nodes.eq(1);
				var node3 = nodes.eq(2);

				// DOM기능 이용 코드
				/* var oldNode = container.replaceChild(node1, node3);
				container.insertBefore(node3, container.firstChild); */
				// jQuery 기능 이용 코드
				/* var oldNode = node3.replaceWith(node2);
				node1.before(node3); */
				// jQuery 스러운 코드
				node3.replaceWith(node2).insertBefore(node2);
			});
		});

		//--------------- 노드 바꾸기2, 이벤트 심화 : 버블링&캡쳐링 ---------------
		$(function() {
			var moveUpBtn = $("#move-up-button");
			var container = $("#move-up-container");

			var checkedId = 0;

			var tbody = container.find("tbody");
			var td = tbody.children().first().children().last(); // var td = tbody.children().first().children().last();	
			var tr = null;

			td.click(function(e) {

				console.log("td");
				$(e.target).css("background", "green");

			});

			tbody.click(function(e) {

				if (e.target.nodeName == "INPUT") {

					tr = $(e.target).parent().parent();
				}
			});

			moveUpBtn.click(function() {

				if (tr == null)
					return;

				var container = tr.parent();

				var bf = tr.prev();
				var af = tr.next();

				if (bf == null)
					bf = container.children().first();

				bf.replaceWith(tr);

				if (af.length == 0)
					container.append(bf);
				else
					bf.insertBefore(af);
			});
		});

		//--------------- 엘리먼트의 기본 행위 막기 ---------------
		$(function() {
			var titleText = $("form input[name]");
			var submitBtn = $("form input[type='submit']");
			var cancelBtn = $("form a");

			submitBtn.click(function(e) {
				if (titleText.val() == "") {
					alert("제목을 입력하세요.");
					e.preventDefault();
				}
			});

			cancelBtn.click(function(e) {
				if (titleText.val() != "") {
					if (!confirm("작성중이던 입력을 취소하시겠습니까?"))
						e.preventDefault();
				}
			});
		});

		//--------------- 노드복제 예제 ---------------
		$(function() {
			var cloneButton = $("#ex-clone input[value='단순복제']");
			var tbody = $("#ex-clone tbody");

			cloneButton.click(function(e) {

				tbody.find("tr").clone(true).appendTo(tbody);
			});

		});

		//--------------- Template 태그를 이용한 노드복제 and Ajax 요청 예제 ---------------
		$(function() {
			var cloneBtn = $("#ex2-clone input[value='단순복제']");
			var ajaxBtn = $("#ex2-clone input[value='Ajax요청']");
			var tbody = $("#ex2-clone tbody");
			var template = $("#ex2-clone template");
			var container = $("#ex2-clone div:first-child");

			var data = [ {
				id : "1",
				title : "자바스크립트 야호~",
				writerId : "newlec"
			}, {
				id : "2",
				title : "자바도 야호~",
				writerId : "dragon"
			}, {
				id : "3",
				title : "둘다 ~",
				writerId : "wa~~~"
			} ];

			// 1. 복제하기
			cloneBtn.click(function(e) {

				// jQuery 객체의 필드와 속성
				/* 
				
							HTML <----------------------------> DOM =================================> jQuery
					<input checked="checked"/>				obj.checkd; // true/false 나옴		jobj.attr("checked");	// 문자그대로 원하면 선택
					<input checked />															jobj.prop("checked");	// DOM의 특성값 원하면 선택
					<input required="required"/>
					<input required />
						
				
				 */

				if ('content' in template.get(0)) { // 현 브라우저가 template 태그 지원하는지에 대한 확인

					for (var i = 0; i < data.length; i++) {
						var clone = $(document.importNode(template
								.prop("content"), true)); // jQuery가 지원해주지 않아 그대로 사용하고 jQuery로 만들어줌

						var tds = clone.find("td");
						//tds.eq(0).html(tds.eq(0).html() + data[i].id);		// get(0)은 DOM으로 내릴 때
						tds.eq(0).append(data[i].id); // 위의 방법과 동일
						tds.eq(1).text(data[i].title);
						tds.eq(2).text(data[i].writerId);

						tbody.append(clone);
					}

				}

			});

			/* ajaxBtn.click(function(e){
				
			var xhr = new XMLHttpRequest();
			
			xhr.load(function(){
				data = JSON.parse(xhr.responseText);
				container.removeChild(container.lastChild);
			});
			
			xhr.error(function(e){
				alert("예기치 못한 오류가 발생하였습니다.");
			});
			
			xhr.open("GET", "../../customer/notice-ajax", true);
			xhr.send();   

			var img = document.createElement("img");
			img.src = "../images/ajax-loader.gif";
			container.append(img);
			
			}); */

			// 2. Ajax 요청하기
			ajaxButton.click(function(e) {

				$.ajaxSetup({
					scriptCharset : "utf-8",
					contentType : "application/json; charset=utf-8"
				});
				//3. jquery.get()으로 문서를 요청한 방식 
				$.getJSON("../../customer/notice-ajax")
				.done(function(data) {
					alert(data);
					console.log("공통")
				}).fail(function() {
					//console.log("공통")
				}).always(function() {
					console.log("공통")
				})
			});
		});
	</script>

	<!--------------- Template 태그를 이용한 노드복제 and Ajax 요청 예제 --------------->
	<p>
	<hr />
	<div id="ex2-clone">
		<div>
			<input type="button" value="단순복제" /> <input type="button"
				value="Ajax요청" />
		</div>
		<div id="clone-container">
			<table border="1">
				<thead>
					<tr>
						<td></td>
						<td>코드</td>
						<td>제목</td>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
			<template>
			<tr>
				<td><input name="id" type="radio" value="1" /></td>
				<td></td>
				<td></td>
			</tr>
			</template>
		</div>
	</div>

	<!--------------- 노드복제 예제 --------------->
	<p>
	<hr />
	<div id="ex-clone">
		<div>
			<input type="button" value="단순복제" />
		</div>
		<div id="clone-container">
			<table border="1">
				<thead>
					<tr>
						<td></td>
						<td>코드</td>
						<td>제목</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input name="id" type="radio" value="1" /></td>
						<td>1</td>
						<td>아~ 괜히 하자고 했지?</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<!--------------- 엘리먼트의 기본 행위 막기 --------------->
	<p>
	<hr />
	<form>
		<input type="text" name="title" /><br /> <input type="submit"
			value="전송" /> <a href="">취소</a>
	</form>

	<!--------------- 노드 바꾸기2, 이벤트 심화 : 버블링&캡쳐링 --------------->
	<p>
	<hr />
	<input id="move-up-button" type="button" value="위로 옮기기" />
	<div id="move-up-container">
		<table border="1">
			<thead>
				<tr>
					<td></td>
					<td>코드</td>
					<td>제목</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input name="id" type="radio" value="1" /></td>
					<td>1</td>
					<td>아~ 괜히 하자고 했지?</td>
				</tr>
				<tr>
					<td><input name="id" type="radio" value="2" /></td>
					<td>2</td>
					<td>졸ㄹ려~~</td>
				</tr>
				<tr>
					<td><input name="id" type="radio" value="3" /></td>
					<td>3</td>
					<td>아~ 졸ㄹ려~~</td>
				</tr>
				<tr>
					<td><input name="id" type="radio" value="4" /></td>
					<td>4</td>
					<td>정말 졸ㄹ려~~</td>
				</tr>
				<tr>
					<td><input name="id" type="radio" value="5" /></td>
					<td>5</td>
					<td>미쳐버리게 졸ㄹ려~~</td>
				</tr>
			</tbody>
		</table>

		<!-- <img src="../img/a.jpg" /> <img src="../img/b.jpg" /> -->
	</div>

	<!--------------- 노드 바꾸기 --------------->
	<p>
	<hr />
	<input id="swap-node-button" type="button" value="노드 바꾸기" />

	<div id="swap-node-container">
		<img src="../img/a.jpg" /><img src="../img/b.jpg" /><img
			src="../img/c.jpg" />
	</div>

	<!--------------- 텍스트 노드 추가 --------------->
	<p>
	<hr />
	<input id="add-text-node-button" type="button" value="텍스트노드 추가" />
	<input id="add-img-node-button" type="button" value="이미지노드 추가" />
	<input id="remove-node-button" type="button" value="노드 삭제" />

	<div id="node-container"></div>

	<!--------------- 자식 노드 변경 --------------->
	<input id="ch-node-button" type="button" value="자식노드 변경" />
	<div id="ch-node-container">hello</div>

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