<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<!-- BootStrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- css -->
<link rel="stylesheet" href="css/slideCard.css">
<!-- 스크립트 -->
<script type="text/javascript">
var timer = null;
var index = 1;
var card = 0;
$(document).ready(function(){
	
	
	$(".card").click(function(){
		$(this).toggleClass("flipped");
	});
	
	card = $("input[name=slide]").length;
	/* 삽질의 흔적,,,1 */
	//전체 라디오 버튼의 개수
	//card = $("input[name=slide]").length;
	//alert(card);
	//alert(-100*4+'%');
	
	/* var temp =0;
	for(var i = 1; i <= card; i++){
		if($("input[id=slide"+i+"]:checked")){
			temp = i;
			alert(temp);
			break;
		}	
	}	
	temp = (i-1)* -100;
	 */
	
	$("input:radio[name='slide']").change(function(){
		//1번 슬라이드 : 0, 2번 슬라이드 : 1 ,,, n번 슬라이드 : n-1
		var temp = $(this).val() - 1;
		//alert(temp);
		var cnt = temp * -100;
		$(".slideBox .slideList > li").css("transform", "translateX("+cnt +"%)");
		
	});
	 
	
	$("#playCard").click(function(){
		location.href='?timer=use';//자기 자신에게 파라미터를 전달해주기
	});
	
	$("#stopCard").click(function(){
		stop();
	});
	
	/* $("#plusCard").click(function(){
		plus();
	}); */
	
	if('${ param.timer == "use"}'=='true'){
		play();
	}
});
/* 삽질의 흔적,,,2 */
/* let cnt = 1;
function next(){
	cnt = cnt + 1;
	temp = (cnt-1) * -100;
	$(".slideBox .slideList > li").css("margin-letf", temp);
	
}

function prev(){
	
} */

function play(){
	if(timer == null){
		timer = setInterval(playCard, 6000);
		$("#msg").text("자동 재생이 켜져있습니다.");
	}
}

function stop(){
	clearInterval(timer);
	timer = null;
	index=1;
	$("#msg").text("자동 재생이 종료되었습니다.");
}

function playCard() {
	var flip  = setTimeout(flipCard, 0);
}

function flipCard() {
	if(index > card){
		stop();
		return;
	}
	$(".card").toggleClass('flipped');
	var re = setTimeout(function(){
		$(".card").toggleClass('flipped');
	},2500);
	var slide = setTimeout(slideCard, 3000);
}

function slideCard(){
	index++;
	if(index > card){
		alert("모든 카드를 학습했습니다!");
		stop();
		return;
	}
	console.log(index);
	var cnt = (index-1) * -100;
	$("#slide" + index).prop("checked", true);
	$(".slideBox .slideList > li").css("transform", "translateX("+cnt +"%)");
}

//test
/* function plus(){
	index++;
	if(index > card){
		index = card;
	}
	console.log(index);
	var cnt = (index-1) * -100;
	$("#slide" + index).prop("checked", true);
	$(".slideBox .slideList > li").css("transform", "translateX("+cnt +"%)");
	
} */
</script>

</head>
<body>

<div id="header">
	<%@include file="header/mainmenu.jsp" %>
</div>

<div class="section" style="background-color: pink;">
	<!-- 카드 개수 : input -->
	<input type="radio" name="slide" value="1" id="slide1" checked>
	<c:forEach begin="2" end="${fn:length(list) }" varStatus="i">
		<!-- i.count begin과 관계없이 1부터 시작 -->
		<input type="radio" name="slide" value="${i.count+1 }" id="slide${i.count + 1 }">
	</c:forEach>

	<div class="slideBox" style="background-color: orange;">
		<ul class="slideList" style="background-color: red;">
		
		<!-- 슬라이드 영역 -->
		<c:forEach var="qna" items="${list }" begin="0" end="${fn:length(list)-1 }" varStatus="i">
			<li>
				<!-- 이전 페이지로 이동한다.  -->
				<label for="slide${i.index}" class="left">◀</label>
				<div class="card">
					<div class="card-inner">
						<div class="card-front">${qna.q_question }</div>
						<div class="card-back">${qna.q_answer }</div>
					</div>
				</div>
				<label for="slide${i.count+1 }" class="right">▶</label>
			</li>
		</c:forEach>
		<!-- 슬라이드 영역 종료 -->	

		</ul>
	</div>
</div><!-- section end -->
<div>
	<input type="button" value="재생" id="playCard">
	<input type="button" value="정지" id="stopCard">
	<span id="msg"></span>
	<!-- <input type="button" value="증가" id="plusCard"> -->
</div>

</body>
</html>