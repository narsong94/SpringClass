<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	/* 
	 애니메이션 구현 기술 3가지
	 1. 스크립트 절차 직접 이용한 애니메이션
	 2. jQuery같은 라이브러리 이용한 애니메이션
	 3. css3 애니메이션 기능 이용한 애니메이션
	 */
	
	// 1. 스크립트 절차 직접 이용한 애니메이션
	function animate(target, to){
		
		var timer = setInterval(function(){
			var width = parseInt(target.style.width);
				
			if(width >= to)
				clearInterval(timer);

			target.style.width = (width+2)+"px";
		}, 17);	// 1초 = 1000, 17하면 60프레임
	}
	
	window.addEventListener("load",function(event) {
	
		var widthBtn = document.querySelector("#ex1-tool input[value='너비늘리기']");
		var item = document.querySelector("#ex1-box .item1");
		
		widthBtn.onclick = function(e) {
			
			// 2) 애니메이션을 animate 함수로 리펙토링
			//animate(item, 250);
			
			// 1) 일일이 개별적으로 작성한 애니메이션
			/* if(timer == null)
				timer = setInterval(function(){
					var width = parseInt(item.style.width);
					
					if(width >= 500)
						clearInterval(timer);

					item.style.width = (width+2)+"px";
				}, 17);	// 1초 = 1000, 17하면 60프레임 */
				
			// CSS3에 추가된 변화 속성
		};
	});
	
	
	// 2. jQuery와 같은 라이브러리 이용한 애니메이션
	$(function() {
		
		var widthBtn = $("#ex1-tool input[value='너비늘리기']");
		var item = $("#ex1-box .item1");
		
		widthBtn.click(function(e) {
			
			// 1) 한번에 변화를 주는 방법
			//item.css({ width: "200px" });
			
			// 2) 기간(duration)을 두고 점진적으로 변화를 주는 방법
			/* item.animate({ 
				width: "250px" 
			}, 2000, "linear", function(){	// animate가 끝나고 나서 뭔가를 하고자 할 때
				alert("끝");				// complete 함수 만들어서 사용
			}); */
			
			// 3. css3 애니메이션 기능 이용한 애니메이션
			item.css({
				width: "200px"
			});
			
		});
	});
	
</script>
<!-- 3. css3 애니메이션 기능 이용한 애니메이션 -->
<style>
	.item1 {
		width: 100px; 
		height: 100px; 
		background: yellow;
		transition-duration: 1s;		/* transition-duration 적용 이밖에도 delay, property, timing-function 등 있음 */
		transition-property: width, opacity;		/* 여러 속성 중 해당 속성만 애니메이션 적용 */
		/* delay는 애니메이션 시작을 늦추는거고 timing은 애니메이션 실행 속도 조절 -> matthewlein.com/ceaser */
		transition-timing-function: cubic-bezier(1.000, 0.000, 0.000, 1.000);
	}

	/* .item1:hover {
		/* transform: rotate(45deg);  */
		opacity: 0.2;
		width: 499px;
		height: 200px;
	} */
</style>
</head>
<body>
	<!-- 1. 너비 변경 애니메이션 -->
	<div id="ex1-tool">
		<input type="button" value="너비늘리기" />
	</div>
	<div id="ex1-box" style="width: 500px; height: 300px; background: gray;">
		<div class="item1"></div>
	</div>
	<hr />
</body>
</html>