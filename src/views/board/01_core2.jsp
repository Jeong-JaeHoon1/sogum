<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, com.kh.model.vo.Person" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 
	prefix 는 Core Library 의 경우 관례상 c 로 지정한다. 
	uri 는 오타가 있으면 절대 안댐!! (연동이 되지 않음)
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>JSTL Core Library</h1>
	
	<h3>1. 변수 (Servlet Scope 내장객체와 관련된 구문들)</h3>
	
	<pre>
		* 변수 선언 (&lt;c:set var="변수명(키값)" value="리터럴(밸류값)" scope="스코프영역지정(생략가능)"&gt;)
		- 변수를 선언하고 초기값을 대입해두는 기능 제공
		- 해당 변수를 어떤 scope 에 담아둘건지 지정 가능함 (생략 시, 기본적으로 PageScope 에 담김)
		
		=> xxx.setAttribute("키값", 밸류값); 코드를 대체하는 태그임!!
			즉, 해당 scope 영역에 setAttribute() 메소드를 이용해서 key + value  세트 형태로 데이터를 담아두는 역할을 제공하는 태그
			
		=> c:set 을 통해 선언된 변수는 EL 로 접근해서 데이터를 꺼내서 사용 가능
		
		* 주의사항
		- 밸류값의 타입을 별도로 지정하지 않음 (실제로 setAttribute 로 밸류를 넣을 때 Object 로 취급되기 때문)
		- 반드시 해당 변수의 담아두고자 하는 초기값 (value) 속성을 무조건 셋팅해야함 (즉, key + value 로 선언과 동시에 초기화)
		- 실제 Servlet Scope 내장객체에 접근하는 개념임!!
	</pre>
	
	<!-- Unknown tag : taglib -->
	<c:set var="num1" value="10"/> <!-- pageScope 에 담김 -->
	<!-- pageContext.setAttribute("num1", 10); 와 같음 -->
	
	<c:set var="num2" value="20" scope="request"/> <!-- requestScope 에 담김 -->
	<!-- request.setAttribute("num2", 20); 와 같음 -->
	
	num1 변수값 : ${ num1 } <br>
	num2 변수값 : ${ num2 } <br>
	
	num1 변수값 : <%= pageContext.getAttribute("num1") %> <br>
	num2 변수값 : <%= request.getAttribute("num2") %> <br>
	
	<c:set var="result" value="${ num1 + num2 }" scope="session" /> <!-- sessionScope 에 담김 -->
	<!-- session.Attribute("result", (int)pageContext.getAttribute("num1") + (int)request.getAttribute("num2") -->
	
	result 변수값 : ${ result } <br><br>
	
	<!-- 
		변수명만 제시하면 공유범위가 가장 작은곳부터 찾아지게 됨
		=> 티가 나지는 않지만 속도가 좀 느려질 수 있다. (스코프영역.변수명 을 권장)
	-->
	
	${ pageScope.num1 } <br>
	${ requestScope.num2 } <br>
	${ sessionScope.result } <br>
	
	${ requestScope.result } <!-- 없는 키값을 제시한 경우 안출력되고 맘 (오류 발생 안함) -->
	
	<br><br>
	
	<!-- value 속성을 시작태그쪽에 기술하지 않고 시작태그와 종료태그 사이에 기술할 수 있다. -->
	<c:set var="result" scope="request">
		9999
	</c:set>
	<!-- request.setAttribute("result", 9999); 와 같음 -->
	
	${ requestScope.result }
	
	<br>
	<hr>
	
	<pre>
		* 변수 삭제 (&lt;c:remove var="제거하고자하는변수명(키값)" scope="스코프영역지정(생략가능)"&gt;)
		
		- 해당 변수를 scope 에서 찾아서 제거하는 태그
		- scope 지정 생략 시 모든 scope 에서 해당 변수를 찾아서 모두 제거함
		
		=> 해당 scope 에 .removeAttribute() 라는 메소드를 이용해서 key + value 세트를 제거하는 구문
	</pre>
	
	삭제 전 result : ${ result } <br><br>
	
	1) 특정 scope 를 지정해서 삭제 <br>
	<c:remove var="result" scope="request" />
	<!-- request.removeAttribute("result"); 와 같음 -->
	
	request 로 부터 삭제 후 result : ${ result } <br><br>
	
	2) 모든 scope 에서 삭제 <br>
	
	<c:remove var="result" />
	<!-- 
		pageContext.removeAtrribute("result");
		request.removeAttribute("result");
		session.removeAttribute("result");
		application.removeAtrribute("result"); 와 같음
	-->
	
	삭제 후 result : ${ result } <br><br>
	
	<br>
	<hr>
	
	<pre>
		* 변수 출력 (&lt;c:out value="출력하고자하는값" default="기본값(생략가능)" escapeXml="true/false"&gt;)
		
		- 데이터를 출력하고자 할 때 사용하는 태그
		- default : value 에 출력하고자 하는 값이 없을 경우 기본값으로 대체해서 출력할 내용물을 기술하는 속성 (생략 가능)
		- escapeXml : html 태그를 태그로써 해석해서 출력할지에 대한 여부 (생략가능, 생략 시 true 가 기본값 => 태그로 해석 안됨)
	</pre>
	
	result : ${ result } <br>
	result : <c:out value="${ result }"/> <br>
	default 설정한 result : <c:out value="${ result }" default="없음"/> <br>
	
	<!--  escapeXml 테스트 -->
	
	<c:set var="outTest" value="<b>출력테스트</b>"/>
	<!-- pageContext.setAttribute("outTest", "<b>출력테스트</b>"); 와 같음 -->
	
	<c:out value="${ outTest }" /> <br>
	<c:out value="${ outTest }" escapeXml="true" /> <br>
	<!-- escapeXml 속성 생략 시 기본값은 true -->
	<c:out value="${ outTest }" escapeXml="false" /> <br>
	<!-- escapeXml 속성값이 false 인 경우 문자열 내부에 html 태그가 있을 경우 실제 태그로써 해석되서 렌더링 -->
	
	<br>
	<hr>
	
	<h3>2. 조건문 - if (&lt;c:if test="조건식"&gt;)</h3>
	
	<pre>
		- JAVA 의 단일 if 문과 같은 역할을 하는 태그
		- 조건식은 test 라는 속성에 작성 (★★★ 중요!! 단, EL 구문으로 조건을 작성해야 함!!)
	</pre>
	
	<%-- 
	<%
		int num1 = (int)pageContext.getAttribute("num1");
		int num2 = (int)request.getAttribute("num2");
	%>
	
	num1 : <%= num1 %> <br>
	num2 : <%= num2 %> <br>
	--%>
	<!-- c:set 태그로 설정한 키-밸류 세트는 스크립틀릿 안에서 사용 불가함!! -->
	
	<!-- 기존 방식 예시 : 10 과 3을 이용해서 대소비교하는 조건식 제시 -->
	<% if(10 > 3) { %>
		<b>10 이 3보다 큽니다.</b>
	<% } %>
	
	<br>
	
	<!-- c:if 태그로 변환 -->
	<c:if test="${ num1 gt num2 }">
		<b>num1 이 num2보다 큽니다.</b>
	</c:if>
	
	<br>
	
	<c:if test="${ num1 le num2 }">
		<b>num1 이 num2 보다 작거나 같습니다.</b>
	</c:if>
	
	<br>
	
	<!-- 기존 방법 -->
	<%--
	<%
		String str = "안녕하세요";
	%>
	
	<% if(str.equals("안녕하세요")) { %>
		<mark>Hello World!</mark>
	<% } %>
	 --%>
	 
	<!-- c:if 태그를 이용한 방식 -->
	
	<c:set var="str" value="안녕하세요"/>
	 
	<c:if test="${ str eq '안녕하세요' }">
	<mark>Hello World!</mark>
	</c:if>
	
	<c:if test="${ str ne '안녕하세요' }">
		<mark>GoodBye!</mark>
	</c:if> 
	 
	<br>
	<hr>
	 
	<h3>3. 조건문 - choose, when, otherwise </h3>
	 
	<pre>
	 	[ 표현법 ]
	 	&lt;c:choose&gt;
	 		&lt;c:when test="조건식1"&gt;~~~&lt;/c:when&gt;
	 		&lt;c:when test="조건식2"&gt;~~~&lt;/c:when&gt;
	 		...
	 		&lt;c:otherwise>~~~&lt;/c:otherwise&gt;
	 		
	 	&lt;/c:choose&gt;
	 	
	 	- JAVA 의 if-else, if-else if 문 또는 switch 문의 역할을 해주는 태그들
	 	- 각 조건의 경우들을 c:choose 의 하위 요소로 c:when 을 통해서 작성
	 	- 이도저도 아닌 경우 (즉, else 일 경우 또는 default 일 경우) 는 c:otherwise 로 표현
	</pre>
	 
	<c:choose>
		<c:when test="${ num eq 20 }"> <!-- if(10 == 20) { -->
		<!-- if(10 == 20) { -->
			<b>처음 봽겠습니다.</b>
		<!-- } -->
		</c:when>
		<c:when test="${ num1 eq 10 }">
		<!-- else if(10 == 10) { -->
			<b>다시 봐서 반갑습니다.</b>
		<!-- } -->
		</c:when>
		<c:otherwise>
		<!-- else { -->
			<b>안녕하세요</b>
		<!-- } -->
		</c:otherwise>
	</c:choose>
	
	<br>
	<hr>
	
	<h3>4. 반복문 - forEach</h3>
	
	<pre>
		[ 표현법 ]
		- 일반 for loop 문
		&lt;c:forEach var="변수명" begin="초기값" end="끝값" step="증가시킬값(생략가능)"&gt;
			
		&lt;/c:forEach&gt;
		
		=> step 속성 생략 시 기본값은 1
		=> var, begin 속성은 기존의 "초기식" 역할
		=> end 속성은 기존의 "조건식" 역할
		=> step 속성은 기존의 "증감식" 역할
		
		- 향상된 for loop 문 (for each 문)
		&lt;c:forEach var="변수명" items="순차적으로접근할배열명또는컬렉션명" varStatus="현재접근된요소의상태값을보관할변수명(생략가능)"&gt;
			
		&lt;/c:forEach&gt;
	</pre>
	
	<!-- 기존 방식 -->
	<%-- 
	<% for(int i = 1; i <= 10; i++) { %>
		반복확인 : <%= i %> <br>
	<% } %>
	--%>
	
	<!-- c:forEach 태그를 이용한 방식 -->
	<c:forEach var="i" begin="1" end="10"> <!-- step 속성은 생략시 기본값이 1 -->
		반복확인 : ${ i } <br>
	</c:forEach>
	
	<br>
	
	<!-- 기존 방식 -->
	<%-- 
	<% for(int i = 1; i <= 10; i+=2) { %>
		반복확인 : <%= i %> <br>
	<% } %>
	--%>
	
	<!-- c:forEach 태그를 이용한 방식 -->
	<c:forEach var="i" begin="1" end="10" step="2">
		반복확인 : ${ i } <br>
	</c:forEach>
	
	<br>
	
	<!-- 초기식 값은 태그 내에서도 사용 가능함 -->
	<c:forEach var="i" begin="1" end="6" step="1"> <!-- i : 1, 2, 3, 4, 5, 6 -->
		<h${ i }>태그 안에서도 적용 가능함</h${ i }>
	</c:forEach>
	
	<br>
	
	<!-- 향상된 for 문 -->
	<c:set var="colors">
		red, yellow, green, pink
	</c:set> <!-- 배열과 같은 역할 -->
	
	colors 값 : ${ colors } <br>
	
	<ul>
		<c:forEach var="c" items="${ colors }">
			<li style="color : ${ c };">${ c }</li>
		</c:forEach>
	</ul>
	
	<br>
	
	<!-- 응용 -->
	
	<%
		// Servlet 으로 부터 다음과 같은 데이터를 넘겨받았다라는 가정 하에
		ArrayList<Person> list = new ArrayList<>();
		list.add(new Person("홍길동", 20, "남자"));
		list.add(new Person("김말순", 30, "여자"));
		list.add(new Person("박말똥", 40, "남자"));
		
		request.setAttribute("list", list);
	%>
	
	<table border="1">
		<thead>
			<tr>
				<th>순번</th>
				<th>이름</th>
				<th>나이</th>
				<th>성별</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${ empty list }">
					<!-- 조회된 회원이 없을 경우 -->
					<tr>
						<td colspan="4">
							조회 결과가 없습니다.
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<!-- 조회된 회원이 있을 경우 -->
					<c:forEach var="p" items="${ list }" varStatus="status">
						<tr>
							<td>${ status.count }</td> <!-- index : 0 부터 시작, count : 1 부터 시작  -->
							<td>${ p.name }</td>
							<td>${ p.age }</td>
							<td>${ p.gender }</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	
	<br>
	<hr>
	
	<h3>5. 반복문 - forTokens</h3>
	
	<pre>
		[ 표현법 ]
		
		&lt;c:forTokens var="각쪼개진값을보관할변수" items="분리시키고자하는문자열" delims="구분자"&gt;
		
		- JAVA 의 StringTokenizer 또는 split("구분자") 와 비슷한 역할
		- 구분자를 통해서 분리된 각각의 문자열에 순차적으로 접근하면서 반복 수행
	</pre>
	
	<c:set var="device" value="컴퓨터,휴대폰,TV,에어컨/냉장고.세탁기" />
	
	<ul>
		<c:forTokens var="d" items="${ device }" delims=",/."> <!-- delims 에 여러개의 구분자 제시 가능 -->
			<li>${ d }</li>
		</c:forTokens>
	</ul>
	
	<br>
	<hr>
	
	<h3>6. 쿼리스트링 관련 - url, param</h3>
	
	<pre>
		[ 표현법 ]
		<c:url var="변수명" value="요청할url">
			<c:param name="키값" value="밸류값" />
			<c:param name="키값" value="밸류값" />
			...
		</c:url>
		
		변수명 = "요청할url?키=밸류&키=밸류&.."
		
		- url 경로를 생성하고, 쿼리스트링을 정의할 수 있는 태그
		- 넘겨야 할 쿼리스트링이 길 경우 사용하면 편하다.
	</pre>
	
	<!-- 기존 방식 -->
	<a href="list.do?currentPage=1&num=2&keyword=안녕">기존 방식</a>
	
	<!-- c:url 를 이용한 방식 -->
	<c:url var="query" value="list.do">
		<c:param name="currentPage" value="1" />
		<c:param name="num" value="2" />
		<c:param name="keyword" value="안녕" />
	</c:url>
	
	<a href="${ query }">c:url 을 이용한 방식</a>
	
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
</body>
</html>













