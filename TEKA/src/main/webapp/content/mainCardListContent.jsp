<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
.card-container {
	text-decoration: none;
	margin: auto;
	width: 640px;
	height: 300px;
	background-color:#d3d3d3;
	border-radius: 10px;
 	display: flex;
}

.card {
  background-color: transparent;
  width: 420px;
  height: 280px;
  perspective: 1000px; /* Remove this if you don't want the 3D effect */
  margin-top: 10px;
  margin-left: 10px;
}

/* This container is needed to position the front and back side */
.card-inner {
  position: relative;
  width: 100%;
  height: 100%;
  text-align: center;
  transition: transform 0.8s;
  transform-style: preserve-3d;
 
}
.card.flipped .card-inner {
	transform: rotateX(180deg);
}

/* Position the front and back side */
.card-front, .card-back {
  position: absolute;
  width: 100%;
  height: 100%;
  border-radius: 10px;
  box-shadow: 1px 1px 4px black;
  -webkit-backface-visibility: hidden; /* Safari */
  backface-visibility: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
}

/* Style the front side (fallback if image is missing) */
.card-front {
  background-color: white;
}

/* Style the back side */
.card-back {
  background-color: white;
  transform: rotateX(180deg);
}

#question, #answer{
	font-weight: bolder;
	font-size: 30px;
}

.side {
	padding: 10px;
	margin-left: 15px;
	margin-top: 20px;
	width: 180px;
	height: 280px;
}
.introduction{
	padding-top: 30px;
}

#grid_container{
	margin: auto;
	width: 1460px;
	padding-top: 15px;
	display: grid;
	grid-template-columns: 725px 725px;
	grid-template-rows: 300px 300px;
	row-gap: 50px;
	column-gap: 20px;
	border-radius: 20px;
}

#filter{
	margin: auto;
	padding-top: 10px;
	width: 1460px;
	height: 100px;
}

#title{
	margin: auto;
	width: 1460px;
	height: 100px;
	line-height: 100px;
	font-size: 45px;
}

.plusCard{
	text-align:center; 
	width: 100%; 
	height: 60px;
	margin-top: 40px;
}
</style>

<script type="text/javascript">
$(document).ready(function(){
	$(".card").click(function(){
		$(this).toggleClass("flipped");
	});	
	
	setTimeout(showMsg, 100);
	
});

function showMsg(){
	if("${param.reason eq 'exist'}" == "true"){
		if(confirm("이미 저장되어 있는 학습카드입니다.\n나의 학습카드로 이동하시겠습니까?") == false) return;
		
		location.href="myCardList.do";
	}
	
	if("${param.reason eq 'success'}" == "true"){
		if(confirm("선택한 카드를 나의 학습세트에 저장했습니다.\n나의 학습카드로 이동하시겠습니까?") == false) return;
		
		location.href="myCardList.do";
	}
}

function addToMyCards(c, s){
	var name = "${user.m_id}";
	
	if(name ==''){
		if(!confirm("로그인 후에 이용할 수 있습니다.\n로그인 하시겠습니까?")) {
			return;
		}
		
		location.href="../tekamember/loginForm.do";
		return;
	}
	
	location.href='myCardInsert.do?c_idx=' + c + '&s_idx=' + s;
}

function filter(){
	var order = $("#order").val();
	
	if(order!=''){
		location.href='mainList.do?subject=${subject}&order='+order;
	}
}
		
</script>
<script type="text/javascript">

	function previewPopup(c_idx){
		
		$.ajax({

			url:'popup.do?c_idx=' + c_idx, //c_idx를 쿼리로 전송
			dataType:'json',
			success : function(resData){
			
				//m_nickname 출력
				$("#m_nickname").html('madeBy' + ' ' + resData.m_nickname);
				$("#c_title").html(resData.c_title);
				$("#c_content").html(resData.c_content);
				
				
				var jsonDiv = {
								 table : "<table class=\"question\">",
								 q : "<tr><td id=\"q_question\"></td>",
								 a : "<td id=\"q_answer\"></td></tr>",
								 end : "</table>"
							  };
				
				var div = '';
				
				for(j in jsonDiv){
					
					div += jsonDiv[j];
				}
				
				$(".res").append(div);
				
				//popup.jsp파일에 동적으로 요소추가 (list만큼 반복하기 때문에 모든 요소 출력가능)
				for(i in resData.list){
					
					//i가 짝수 : q_question (i = 0 2 4...)
					if(i%2==0){

						$("#q_question").append(resData.list[i]).append("<br><br><br>");
					
					//아니면 홀수 : q_answer (i = 1 3 5...)					
					}else {
						
						$("#q_answer").append(resData.list[i]).append("<br><br><br>");
					}
				}
			}//success end
		});
		
		//append했던 데이터 지우기
		$("#q_question").remove();
		$("#q_answer").remove();
		$(".question").remove();

		centerBox();
		$("#popupBox").show();
	}
</script>
<!-- 좋아요 기능 자바스크립트 -->
<script type="text/javascript">
	
	var empty = "<span class=\"love\"> 🤍 </span>";
	var full  = "<span class=\"love\"> ❤️ </span>";
	
	function liked(c_idx, s_idx){
		
		//로그인하지 않았을 경우
		if(${empty user}){
			
			if(!confirm("로그인 후에 이용할 수 있습니다.\n로그인 하시겠습니까?")) return;
			location.href="../tekamember/loginForm.do";
			return;
		}
		
		//현재 m_idx와 c_idx로 조회했을 때, 좋아요를 누르지 않았을 경우 좋아요 누를 수 있음
		$.ajax({
			url:'../card/likeInsert.do',
			data:{"m_idx": "${user.m_idx}", "c_idx":c_idx},
			dataType:'json',
			success : function(resData){
				
				//좋아요+1 insert가 정상적으로 처리되었다면
				if(resData.res==1){

					//추가하면 내 학습세트페이지로 이동
					if(!confirm(c_idx + '번 카드를 추천합니다.\n내 학습세트에 추가하시겠습니까?')) {
						//결과 재요청
						location.href="../card/mainList.do";
					}
					//이미 학습세트에 추가되어있을 경우
					addToMyCards(c_idx, s_idx);
					showMsg();
				}
				//이미 좋아요를 눌러서 누를 수 없는 경우, 좋아요 취소
				if(resData.already==0){
					
					if(!confirm('이미 추천하는 카드입니다.\n추천을 취소하시겠습니까?')) return;
					
					$.ajax({
						url : '../card/deleteLiked.do',
						data : {"c_idx":c_idx, "m_idx": "${user.m_idx}"},
						dataType : 'json',
						success : function(resData){
							//결과 재요청
							location.href="../card/mainList.do";
						}
					});// inner ajax end
				}//if already end
			}
		});//ajax end
	}//liked end
</script>
</head>
<body id="box">
	<c:if test="${!empty subject }">
		<div id="title">
			<i class="fas fa-award" style="color: navy;"></i>&nbsp<b>${subject }</b>
		</div>
	
	</c:if>
	<div id="filter">
			<b>여기에서는 검색 필터를 지정할 수 있습니다.</b>
			<select id="order" style="height: 40px;">
				<option value="">검색조건</option>
				<option value="newest">최신순</option>
				<option value="mostLiked">추천순</option>
				<option value="oldest">오래된순</option>
			</select>
			<input type="button" value="검색" style="height: 40px; width: 80px;" onclick="filter();">
		<hr>
	</div>
	<div id="grid_container">
		<c:if test="${empty list}">
			<div style="color: red; text-align: center; line-height: 333px;">카드가 없습니다.</div>
		</c:if>
		
		<c:forEach var="card" items="${ list }">
		<!-- 미리보기팝업 -->
		<%@include file="previewPopup.jsp" %>	
			
			<div class="card-container">
				<div class="card">
					<div class="card-inner">
						<div class="card-front">
							<div id="question"><b>${ card.c_title }</b></div>
						</div>
						<div class="card-back">
							<div id="answer"><b>${card.c_content}</b></div>
						</div>
					</div>
				</div>
				
				<div class="side">
					<span class="label label-info">${card.s_name}</span>
					<button type="button" class="btn btn-xs btn-primary" onclick="liked(${card.c_idx},${card.s_idx });" id="likeBtn">
						추천 <span class="love"> 🤍 </span><span class="badge">${card.l_like}</span>
					</button><br>
					<span class="badge">${card.m_nickname }</span><br>
					
					<input type="button" class="plusCard" value="미리보기" onclick="previewPopup(${card.c_idx});">
					<input type="button" class="plusCard" value="내 학습세트에 추가하기" onclick="addToMyCards(${card.c_idx},${card.s_idx });">
				</div>
			</div>
		</c:forEach>
	
	</div>
</body>
</html>