<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QuizTIS : 카드만들기</title>
<!-- BootStrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- css연결 -->
<link rel="stylesheet" href="css/test.css">
<!-- 스크립트 -->
<script type="text/javascript">
	$(document).ready(function(){
		$(".card").click(function(){
			$(this).toggleClass("flipped");
		});
	});
	function make_card(){
		var q_text = $("#q_text").val().trim();
		var a_text = $("#a_text").val().trim();
		
		$("#q").html(q_text);
		$("#a").html(a_text);
	}
	
	function send(){
		
		if(!confirm('아쉽네요... 다음번엔 QuizTIS와 함께해주세요')) return;
		
		location.href="main.do";
	}
</script>

</head>
<body>
<!-- header -->
<div id="header">
	<%@include file="header/mainmenu.jsp" %>

	<div id="card_view" style="background-color: #222222;">
		<div class="text">
			<p style="color:white; font-weight:500;">QuizTIS 학습세트를 직접 만들어보세요.<br><br>
									카드를 클릭해보세요!</p><br><br>
		</div>

		<div class="card">
			<div class="card-inner">
				<div class="card-front">Click here!</div>
				<div class="card-back">Welcome QuizTIS!</div>
			</div>
		</div>
		<div style="clear: both;"></div>
	</div><!-- card_view end -->
	
	
	<div id="subject_view">
		<div class="text">
			<p class="count">&nbsp;하나.</p><br>
			<p class="ment">원하는 주제별로 카테고리를 설정해요.</p><br>
     		 <select multiple class="form-control" id="sel2">
		        <option>네트워크</option>
		        <option>운영체제</option>
		        <option>자료구조</option>
		        <option>알고리즘</option>
		        <option>Spring Framework</option>
		        <option>Java</option>
	     	 </select><br><br><br>
			<p class="count">&nbsp;둘.</p><br>
			<p class="ment">내용을 입력하세요. 카드를 클릭하면 뜻을 볼 수 있어요.&#128161;</p><br>
			<div id="text_area">
				<div class="card" id="card_box">
					<div class="card-inner" style="color:black;">
						<div class="card-front" id="q"></div>
						<div class="card-back" id="a"></div>
					</div>
				</div>
				
				<div id="text_insert">
					<label for="sel2" style="color:black; font-size: 17px; color:#696969;">카드앞면</label>
						<textarea id="q_text" class="form-control" placeholder="카드앞면을 입력하세요."></textarea>
					<label for="sel2" style="color:black; font-size: 17px; color:#696969;">카드뒷면</label>
						<textarea id="a_text" class="form-control" placeholder="카드뒷면을 입력하세요."></textarea>
					<div id="btn_insert">
						<input type="button" value="카드만들기" class="btn btn-default btn-lg" onclick="make_card();">
						<div style="clear:both;"></div>
					</div>
				</div><!-- text_insert -->
			</div>
		</div><!-- text_area end -->
	
		<div class="text" style="margin-top:150px;">
			<p class="count">&nbsp;셋.</p><br>
			<p class="ment">다른 사람의 학습세트를 공부할 수 있어요.</p><br>
			<!-- 사진 수정예정 -->
			<input type="image" src="image/will_modify.png" style="width:70%; margin:auto;">
		</div>

		<div class="text" style="margin-top:380px;">
			<p style="font-weight:550;">자, 이제 QuizTIS에서 학습할 준비가 끝났어요.<br><br>
										멋진 학습세트를 만들어보세요!</p><br><br>
			<div id="last_btn">
				<input type="button" value="홈화면으로 돌아가기" class="btn btn-default btn-lg"
														onclick="send();">
				<input type="button" value="회원가입" class="btn btn-default btn-lg"
														onclick="location.href='signUpForm.do'">
			</div>			
		</div>
	</div><!-- subject_view end -->
</div><!-- header end -->

</body>
</html>