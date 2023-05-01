<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .login-area a {
        text-decoration: none;
        color: black;
        font-size: 12px;
    }

    .nav-area {
        background-color: black;
        color: white;
        height: 50px;
    }

    .menu {
        display: table-cell;
        width: 250px;
        height: 50px;
        vertical-align: middle;
        font-size: 20px;
        font-weight: bold;
        text-align: center;
    }

    .menu:hover {
        background-color: gray;
        cursor: pointer;
    }

    /* menubar.jsp 에 .outer 에 한번만 적용하고 다 include 해서 쓸 것 */
    .outer {
        width: 900px;
        background-color: black;
        color: white;
        margin: auto;
        margin-top: 50px;
    }
</style>
</head>
<body>

    <h1 align="center">Welcome To MyBatis World!</h1>

    <br>

    <div class="login-area" align="right">
        <!-- case1. 로그인 전에 보여져야 하는 폼 -->
        
        <form action="" method="post">
            <table>
                <tr>
                    <td>아이디</td>
                    <td>
                        <input type="text" name="" required>
                    </td>
                    <td rowspan="2">
                        <button type="submit" style="height: 50px;">
                            로그인
                        </button>
                    </td>
                </tr>
                <tr>
                    <td>비밀번호</td>
                    <td>
                        <input type="password" name="" required>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <a href="">회원가입</a> | 
                        <a href="">ID/PWD찾기</a>
                    </td>
                </tr>
            </table>
        </form>
        
        <!-- case2. 로그인 후 에 보여져야 하는 화면 -->
        <!--
        <div>
            <table>
                <tr>
                    <td colspan="2">
                        <h3>xxx 님 환영합니다^^</h3>
                    </td>
                </tr>
                <tr>
                    <td>
                        <a href="">마이페이지</a>
                    </td>
                    <td>
                        <a href="">로그아웃</a>
                    </td>
                </tr>
            </table>
        </div>
        -->
        
    </div>

    <br>

    <div class="nav-area" align="center">
        <div class="menu">HOME</div>
        <div class="menu">공지사항</div>
        <div class="menu">게시판</div>
        <div class="menu">ETC</div>
    </div>

</body>
</html>