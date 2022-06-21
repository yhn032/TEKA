<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.card-container {
	text-decoration: none;
	margin: auto;
	width: 640px;
	height: 300px;
	border: 2px solid navy;
	border-radius: 10px;
 	box-shadow: 1px 1px 4px purple;
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
	width: 150px;
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
	border: 1px solid gray;
	border-radius: 20px;
	box-shadow: inset 3px 3px 5px 2px black;
}

#filter{
	margin: auto;
	width: 1460px;
	height: 100px;
}
</style>

<script type="text/javascript">
$(document).ready(function(){
	$(".card").click(function(){
		$(this).toggleClass("flipped");
	});	
});
</script>
</head>
<body>
	<div id="filter">
		<hr>
			<b>여기에서는 검색 필터를 지정할 수 있습니다.</b>
			<select name="category" style="height: 40px;">
				<option value="">검색조건</option>
				<option value="com001">인기순</option>
				<option value="ele002">추천순</option>
				<option value="sp003">최근순</option>
			</select>
			<input type="button" value="검색" style="height: 40px; width: 80px;">
		<hr>
	</div>
	<div id="grid_container">
		<c:forEach var="qna" items="${ list }">
			<div class="card-container">
				<div class="card">
					<div class="card-inner">
						<div class="card-front">
							<div id="question"><b>${ qna.c_name }</b></div>
						</div>
						<div class="card-back">
							<div id="answer"><b>소개하는 글입니다.</b></div>
						</div>
					</div>
				</div>
				
				<div class="side">
					<span class="badge">알고리즘</span>
					<button type="button" class="btn btn-xs btn-primary">
						추천 <span class="badge">${qna.c_prefer}</span>
					</button><br>
					<input type="button" value="미리보기" style="text-align:center; width: 100%; height: 60px; margin-top: 40px;">
					<input type="button" value="내 학습세트에 추가하기" style="text-align:center; width: 100%; height: 60px; margin-top: 40px;">
				</div>
			</div>
		</c:forEach>
	</div>
</body>
</html>