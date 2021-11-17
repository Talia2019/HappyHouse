<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String root = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Kakao Map</title>
    <link rel="shortcut icon" href="${root}/img/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="${root}/css/style.css">
    <link rel="stylesheet" href="${root}/css/apt.css">
    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
    />
    <link
      rel="stylesheet"
      href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
      integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
      crossorigin="anonymous"
    />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=25fdf682e8691d8145d06898a8ffa361&libraries=services"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=25fdf682e8691d8145d06898a8ffa361&libraries=LIBRARY"></script>
    
    <script type="text/javascript" src="${root}/js/main.js"></script>
    <script type="text/javascript" src="${root}/js/user.js"></script>
  </head>

  <body>
    <!-- 네비 위 로그인과 회원정보-->
    <div class="header-container">
      <!-- header-top start -->
      <!-- classes:  -->
      <!-- "dark": dark version of header top e.g. class="header-top dark" -->
      <!-- "colored": colored version of header top e.g. class="header-top colored" -->
      <!-- ================ -->
      <div class="header-top dark">
        <div class="container">
          <div class="row">
            <div class="col-3 col-sm-6 col-lg-9">
              <!-- header-top-first start -->
              <!-- ================ -->
              <div class="header-top-first clearfix"></div>
              <!-- header-top-first end -->
            </div>
            <div class="col-9 col-sm-6 col-lg-3">
    
              <!-- header-top-second start -->
              <!-- ================ -->
              <div id="header-top-second" class="clearfix">
    
                <!-- header top dropdowns start -->
                <!-- ================ -->
                <div class="header-top-dropdown text-right">
                <c:if test="${!empty userinfo}"> 
                  <div class="btn-group" id="info">
                    <a href="${root}/user/logout" class="btn btn-default btn-sm" style="color: #ffffff;"><i
                      class="fa fa-user pr-2" style="color: #ffffff;"></i> logout</a>
                  </div>
                 
                  <div class="btn-group" id="logout">
                    <a href="/signupForm.do" class="btn btn-default btn-sm mustLogin" style="color: #ffffff;" data-toggle="modal"
                    data-target="#infoModal"
                    ><i
                      class="fa fa-user pr-2" style="color: #ffffff;"></i> 회원정보</a>
                  </div>
                  </c:if>
                <c:if test="${empty userinfo}"> 
                      <div class="btn-group" id="signup">
                        <a href="/signupForm.do" class="btn btn-default btn-sm" style="color: #ffffff;" data-toggle="modal"
                        data-target="#signUpModal"
                        ><i
                          class="fa fa-user pr-2" style="color: #ffffff;"></i> Sign Up</a>
                      </div>
                      <div class="btn-group" id="login">
                        <button id="header-top-drop-2" type="button"
                          class="btn dropdown-toggle btn-default btn-sm dropdown-toggle--no-caret"
                          data-toggle="dropdown" aria-haspopup="true"
                          aria-expanded="false" style="color: #ffffff;">
                          <i class="fa fa-lock pr-2"></i> Login
                        </button>
                        <ul
                          class="dropdown-menu dropdown-menu-right dropdown-animation" 
                          aria-labelledby="header-top-drop-2" style="background-color: #212529;">
                          <li>
                            <form class="login-form margin-clear" action="" method="POST" id="loginForm" style="width: 260px; padding: 0;">
                              <div class="form-group has-feedback" style="width: 258;">
                                <label class="control-label" style="color: #ffffff;">아이디</label> <input
                                  type="text" class="form-control" placeholder="" name="userId" id="userId">
                                <i class="fa fa-user form-control-feedback"></i>
                              </div>
                              <div class="form-group has-feedback">
                                <label class="control-label" style="color: #ffffff;">비밀번호</label> <input
                                  type="password" class="form-control" placeholder="" name="password" id="password"> 
                                  <i class="fa fa-lock form-control-feedback"></i>
                              </div>
                              <!-- <button type="button" class="btn btn-gray btn-sm" style = "background-color: #e1e1e1;" onclick="login()">
                                로 그 인</button> -->
                               <input type="submit" class="btn btn-gray btn-sm" style = "background-color: #e1e1e1;" value="로그인" id="loginBtn"/>
                               <button type="button" id="findPwdBtn" class="btn btn-group btn-warning btn-sm" data-target="#findModal" data-toggle="modal">비밀번호 찾기</button>
<!--                               <ul class='pagination'> -->
<!--                                
<!--                                 <li><a href="#" class="btn btn-default btn-sm">아이디 -->
<!--                                     찾기</a></li> -->
<!--                                 -->       -->
                                
<%-- <%--                                 <li><a href="${root}/user/findPassword" class="btn btn-default btn-sm" style=" color: #ffffff; background-color: #00000033;">비밀번호 찾기</a></li> --%> --%>
<!--                               </ul> -->
                            </form>
                          </li>
                        </ul>
                      </div>
                    </c:if>  
                    
                    
                  
                </div>
                <!--  header top dropdowns end -->
              </div>
              <!-- header-top-second end -->
            </div>
          </div>
        </div>
      </div>
      </div>
      <header class="header fixed fixed-desktop clearfix">
        <div class="container">
          <div class="row">
            <div class="col-md-auto hidden-md-down">
              <!-- header-first start -->
              <!-- ================ -->
              <div class="header-first clearfix">
    
                <!-- logo -->
                <div id="logo" class="logo">
                  <a href="#"><img id="logo_img" src="${root}/img/logo.jpg" width='150'
                    alt="The SSAFY"></a>
                </div>
              </div>
            </div>
            <div class="col-lg-10 ml-auto">
    
              <!-- header-second start -->
              <!-- ================ -->
              <div class="header-second clearfix">
    
                <!-- main-navigation start -->
                <!-- classes: -->
                <!-- "onclick": Makes the dropdowns open on click, this the default bootstrap behavior e.g. class="main-navigation onclick" -->
                <!-- "animated": Enables animations on dropdowns opening e.g. class="main-navigation animated" -->
                <!-- ================ -->
                <div class="main-navigation main-navigation--mega-menu  animated">
                  <nav class="navbar navbar-expand-lg navbar-light p-0">
                    <div class="navbar-brand clearfix hidden-lg-up">
    
                      
                        
                    </div>
    
                    <!-- header dropdown buttons -->
                    <div
                      class="header-dropdown-buttons hidden-lg-up p-0 ml-auto mr-3">
                      <div class="btn-group">
                        
                        <ul
                          class="dropdown-menu dropdown-menu-right dropdown-animation"
                          aria-labelledby="header-drop-3">
                          <li>
                            <form role="search" class="search-box margin-clear">
                              <div class="form-group has-feedback">
                                <input type="text" class="form-control"
                                  placeholder="Search"> <i
                                  class="fa fa-search form-control-feedback"></i>
                              </div>
                            </form>
                          </li>
                        </ul>
                        
                      </div>
                    </div>
                    <!-- header dropdown buttons end -->
    
                    <button class="navbar-toggler" type="button"
                      data-toggle="collapse" data-target="#navbar-collapse-1"
                      aria-controls="navbar-collapse-1" aria-expanded="false"
                      aria-label="Toggle navigation">
                      <span class="navbar-toggler-icon"></span>
                    </button>
    
                    <div class="collapse navbar-collapse" id="navbar-collapse-1">
                          <ul class="navbar-nav ml-xl-auto">
                            <li class="nav-item dropdown  mega-menu mega-menu--wide">
                              <a href="#" class="nav-link "
                              id="first-dropdown" aria-haspopup="true"
                              aria-expanded="false">공지사항</a>
                            </li>
                            <li
                              class="nav-item dropdown mega-menu mega-menu--wide">
                              <!-- <a href="foodBestList.do?id=n" class="nav-link dropdown-toggle" id="second-dropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">영양 정보</a> -->
                              <a href="#" class="nav-link"
                              id="second-dropdown" 
                              aria-haspopup="true" aria-expanded="false">오늘의 뉴스</a>
                            </li>
                            
					      	<c:if test="${userinfo.userId eq 'admin'}">
                            <li
                              class="nav-item dropdown mega-menu mega-menu--wide">
                              <!-- <a href="foodBestList.do?id=n" class="nav-link dropdown-toggle" id="second-dropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">영양 정보</a> -->
                              <a href="${root}/user/list" class="nav-link"
                              id="second-dropdown" 
                              aria-haspopup="true" aria-expanded="false">회원 검색</a>
                            </li>
					      	</c:if>
                            
                            <li class="mustLogin nav-item dropdown  mega-menu mega-menu--wide">
                              <a href="#" class="nav-link "
                              id="first-dropdown" aria-haspopup="true"
                              aria-expanded="false">주변 탐방</a>
                            </li>
                            <li class="mustLogin nav-item dropdown  mega-menu mega-menu--wide">
                              <a href="#" class="nav-link "
                              id="first-dropdown" aria-haspopup="true"
                              aria-expanded="false">관심 지역 설정</a>
                            </li>
                            <li class="mustLogin nav-item dropdown  mega-menu mega-menu--wide">
                              <a href="#" class="nav-link "
                              id="first-dropdown" aria-haspopup="true"
                              aria-expanded="false">관심 지역 둘러보기</a>
                            </li>
                            
                          </ul>
                          <!-- 돋보기 아이콘 -->
                        <button type="button"
                          class="btn dropdown-toggle dropdown-toggle--no-caret"
                          id="header-drop-3" data-toggle="dropdown"
                          aria-haspopup="true" aria-expanded="false">
                          <i class="fa fa-search"></i>
                        </button>
                      <!-- main-menu end -->
                    </div>
                  </nav>
                </div>
              </div>
            </div>
          </div>
        </div>
      </header>
      <!-- header end -->
    <!-- <nav class="navbar navbar-expand-sm bg-white">
      
      <a class="navbar-brand" href="#"
        ><img src="./img/logo.jpg" alt="" srcset="" width="150"/></a
      >

      <button
        class="navbar-toggler"
        type="button"
        data-toggle="collapse"
        data-target="#collapsibleNavbar"
      >
        <span class="navbar-toggler-icon"></span>
      </button>

      
      <div class="collapse navbar-collapse justify-content-end" id="collapsibleNavbar">
        <ul class="navbar-nav col-lg-10 ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="#">공지사항</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">오늘의 뉴스</a>
          </li>
          <li class="nav-item mustLogin">
            <a class="nav-link" href="#">주변 탐방</a>
          </li>
          <li class="nav-item mustLogin">
            <a class="nav-link" href="#">관심지역 설정</a>
          </li>
          <li class="nav-item mustLogin">
            <a class="nav-link" href="#">관심지역 둘러보기</a>
          </li>
        </ul>
      </div>
    </nav> -->
    <div style="width: 100%; height: 300px; background-color: lightgray; padding: 0;"><img src="${root}/img/happyhouse.JPG">
    </div>