<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>

<section id="index_section">
	<div class="card col-sm-12 mt-1" style="min-height: 850px;">
			<div style="margin-left: 20px; margin-top: 10px;">
				아파트명 
				<input id="searchaptname" type="text"> 
				<input id="searchaptnamebtn" type="submit" value="검색">
    		<div id='autoMaker'></div>
		</div>
		<div class="card-body">
			시도 : <select id="sido"><option value="0">선택</option></select> 
			구군 : <select id="gugun"><option value="0">선택</option></select> 
			읍면동 : <select id="dong"><option value="0">선택</option></select>
			<button type="button" id="aptSearchBtn">검색</button>
			<table class="table mt-2">
				<colgroup>
					<col width="100">
					<col width="150">
					<col width="*">
					<col width="120">
					<col width="120">
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>아파트이름</th>
						<th class="text-center">주소</th>
						<th>건축연도</th>
						<th>최근거래금액</th>
					</tr>
				</thead>
				<tbody id="searchResult"></tbody>
			</table>
			<div id="map" style="width: 100%; height: 500px;"></div>
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24de0e18341d26d5ce7382a83a34fce2&libraries=services"></script>
			<script type="text/javascript" src="${root}/js/map.js"></script>
			<script type="text/javascript">
				var aptList = [];
				let colorArr = ['table-primary','table-success','table-danger'];
				$(document).ready(function(){					
					$.get(root + "/map/sido"
						,function(data, status){
							$.each(data, function(index, vo) {
								$("#sido").append("<option value='"+vo.sidoCode+"'>"+vo.sidoName+"</option>");
							});
						}
						, "json"
					);
				});
				$(document).on("change", "#sido", function() {
					$.get(root + "/map/gugun"
							,{sido: $("#sido").val()}
							,function(data, status){
								$("#gugun").empty();
								$("#gugun").append('<option value="0">선택</option>');
								$.each(data, function(index, vo) {
									$("#gugun").append("<option value='"+vo.gugunCode+"'>"+vo.gugunName+"</option>");
								});
							}
							, "json"
					);
				});
				$(document).on("change", "#gugun", function() {
					$.get(root + "/map/dong"
							,{gugun: $("#gugun").val()}
							,function(data, status){
								$("#dong").empty();
								$("#dong").append('<option value="0">선택</option>');
								$.each(data, function(index, vo) {
									$("#dong").append("<option value='"+vo.dongCode+"'>"+vo.dongName+"</option>");
								});
							}
							, "json"
					);
				});
				$(document).on("change", "#dong", function() {
					$.get(root + "/map/apt"
							,{dong: $("#dong").val()}
							,function(data, status){
								$("tbody").empty();
								
								//알고리즘 적용1
								data.sort(function(a, b){
									return a.aptName < b.aptName ? -1 : a.aptName < b.aptName ? 1 : 0;
								});
								
								$.each(data, function(index, vo) {
									console.log(vo);
									aptList.push({
										name: vo.aptName,
										key: index
										});
									let str = `
										<tr class="${colorArr[index%3]}">
											<td>`+vo.aptCode+`</td>
											<td>`+vo.aptName+`</td>
											<td>`+vo.sidoName +` `+ vo.gugunName +` `+ vo.dongName + ` ` + vo.jibun+`</td>
											<td>`+vo.buildYear+`</td>
											<td>`+vo.recentPrice+`</td>
										</tr>
									`;
									$("tbody").append(str);
								});
								displayMarkers(data);
							}
							, "json"
					);
				});
				$(document).on("click", "#aptSearchBtn", function() {
					var param = {
							serviceKey:'u44MPChIFRDby2KFIAjIZaKd2UzE5VLo0eStZUpzw80TOlqhr7JQpMVWNYTzWtnjyVodAPwD+81urU1N7DVv/Q==',
							pageNo:encodeURIComponent('1'),
							numOfRows:encodeURIComponent('10'),
							LAWD_CD:encodeURIComponent($("#gugun").val()),
							DEAL_YMD:encodeURIComponent('202110')
					};
					
					$.get('http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev'
							,param
							,function(data, status){
								$("tbody").empty();
								var items = $(data).find('item');
								var jsonArray = new Array();
									console.log(items)
								$("#recentPrice").html("거래금액");
								items.each(function() {
									var jsonObj	= new Object();
									jsonObj.aptCode = $(this).find('일련번호').text();
									jsonObj.aptName = $(this).find('아파트').text();
									jsonObj.dongCode = $(this).find('법정동읍면동코드').text();
									jsonObj.buildYear = $(this).find('건축년도').text();
									jsonObj.dongName = $(this).find('법정동').text();
									//jsonObj.sidoName = $(this).find('법정동시군구코드').text() + '00000';
									jsonObj.jibun = $(this).find('지번').text();
									jsonObj.recentPrice = $(this).find('거래금액').text().trim();
									
									jsonObj = JSON.stringify(jsonObj);
									//String 형태로 파싱한 객체를 다시 json으로 변환
									jsonArray.push(JSON.parse(jsonObj));
									
								})
								
								//알고리즘 적용2
								jsonArray.sort(function(a, b) {
									return a.buildYear < b.buildYear ? -1 : a.buildYear < b.buildYear ? 1 : 0;
								});
								
								for (var i = 0; i < jsonArray.length; i++){
									let str = `
										<tr class="${colorArr[index%3]}">
											<td>`+jsonArray[i].aptCode+`</td>
											<td>`+jsonArray[i].aptName+`</td>
											<td>`+jsonArray[i].dongName +` `+ jsonArray[i].jibun+`</td>
											<td>`+jsonArray[i].buildYear+`</td>
											<td>`+jsonArray[i].recentPrice+`</td>
										</tr>
									`;

									var address = jsonArray[i].dongName + " " + jsonArray[i].jibun;
									var geocoder = new kakao.maps.services.Geocoder();

									geocoder.addressSearch(address, function(result, status) {
										if (status === kakao.maps.services.Status.OK) {
											coords = new kakao.maps.LatLng(result[0].y, result[0].x);
											
											var marker = new kakao.maps.Marker({
									            map: map,
									            position: coords
									        });

									        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
									        map.setCenter(coords);
										}
									})
									$("tbody").append(str);
								}
								console.log(jsonArray);
								//displayMarkers(jsonArray);
							}
							, "xml"
					);
					
				});
				
				$(document).on("click", "#searchaptnamebtn", function() {
					$.get(root + "/map/aptSearch"
							,{name: $("#searchaptname").val(), dong: $("#dong").val()}
							,function(data, status){
								$("tbody").empty();
								$.each(data, function(index, apt) {
										let str = `
											<tr class="${colorArr[index%3]}">
											<td>`+apt.aptCode+`</td>
											<td>`+apt.aptName+`</td>
											<td>`+apt.sidoName +` `+ apt.gugunName +` `+ apt.dongName + ` ` + apt.jibun+`</td>
											<td>`+apt.buildYear+`</td>
											<td>`+apt.recentPrice+`</td>
											</tr>
										`;
									$("tbody").append(str);
								});
							}
							, "json"
					);
				});

				$(document).on("keyup", "#searchaptname", function() {
					var name = $("#searchaptname").val();
					 $('#autoMaker').children().remove();
					 console.log(aptList);
					if(name!=''){
						$("#autoMaker").children().remove();
						aptList.forEach(function(apt){
							console.log(apt)
							if((apt.name||'-').indexOf(name)>-1){
								$("#autoMaker").append(
									$('<div>').text(apt.name).attr({'key': apt.key})
								);
							}
						});
				        $('#autoMaker').children().each(function(){
				            $(this).click(function(){
				                $('#searchaptname').val($(this).text());
				                $('#autoMaker').children().remove();
				            });
				        });	
					}
				});
				</script>
		</div>
	</div>
</section>


<!-- 모달창 -->
<!-- Button to Open the Modal -->
<!-- The Modal -->
<div class="modal" id="signUpModal">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="form-block p-30 light-gray-bg border-clear">
				<h2 class="title">회원가입</h2>
			</div>

			<form id="registerForm" class="form-horizontal" action=""
				method="post">
				<input type="hidden" name="action" value="join" />
				<div class="form-group has-feedback row">
					<label for="inputName"
						class="col-md-3 control-label text-md-right col-form-label">아이디
						<span class="text-danger small">*</span>
					</label>
					<div class="col-md-8">
						<input type="text" class="form-control" id="juserId" name="userId"
							placeholder="아이디를 입력하세요" required name="userId">
					</div>
				</div>
				<div class="form-group has-feedback row">
					<label for="inputLastName"
						class="col-md-3 control-label text-md-right col-form-label">비밀번호
						<span class="text-danger small">*</span>
					</label>
					<div class="col-md-8">
						<input type="password" class="form-control" id="jpassword"
							name="password" placeholder="영문 숫자 포함 6자리 이상" required
							name="password">
					</div>
				</div>
				<div class="form-group has-feedback row">
					<label for="inputUserName"
						class="col-md-3 control-label text-md-right col-form-label">이름
						<span class="text-danger small">*</span>
					</label>
					<div class="col-md-8">
						<input type="text" class="form-control" id="jname" name="name"
							placeholder="이름을 입력하세요" required name="name">
					</div>
				</div>
				<div class="form-group has-feedback row">
					<label for="address"
						class="col-md-3 control-label text-md-right col-form-label">주소
						<span class="text-danger small">*</span>
					</label>
					<div class="col-md-8">
						<input type="text" class="form-control" id="jaddress"
							name="address" placeholder="주소를 입력하세요" required name="address">
					</div>
				</div>
				<div class="form-group has-feedback row">
					<label for="inputPassword"
						class="col-md-3 control-label text-md-right col-form-label">전화번호
						<span class="text-danger small">*</span>
					</label>
					<div class="col-md-8">
						<input type="text" class="form-control" id="jphone" name="phone"
							placeholder="010-xxx-xxxx" required name="phone">
					</div>
				</div>

				<div class="form-group row">
					<div class="ml-md-auto col-md-9">
						<!--  <button type="button"
                  class="btn btn-group btn-warning btn-animated">
                  등록 <i class="fa fa-check"></i>
                </button>  -->
						<Button type="button"
							class="btn btn-group btn-warning btn-animated" id="joinBtn">등록</Button>
					</div>
				</div>
			</form>


		</div>
	</div>
</div>


<!--     비밀번호 찾기 모달 -->
<div class="modal" id="findModal">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="form-block p-30 light-gray-bg border-clear">
				<h2 class="title">비밀번호 찾기</h2>
			</div>

			<form id="findForm" class="form-horizontal" action="" method="post">
				<input type="hidden" name="action" value="join" />
				<div class="form-group has-feedback row">
					<label for="inputName"
						class="col-md-3 control-label text-md-right col-form-label">아이디
						<span class="text-danger small">*</span>
					</label>
					<div class="col-md-8">
						<input type="text" class="form-control" id="fuserId" name="userId"
							placeholder="아이디를 입력하세요">
					</div>
				</div>
				<div class="form-group has-feedback row">
					<label for="inputUserName"
						class="col-md-3 control-label text-md-right col-form-label">이름
						<span class="text-danger small">*</span>
					</label>
					<div class="col-md-8">
						<input type="text" class="form-control" id="fname" name="name"
							placeholder="이름을 입력하세요" required name="name">
					</div>
					<div id="infoPassword"
						class="col-md-12 control-label text-md-center col-form-label">
					</div>
				</div>
				<div class="form-group row">
					<div class="ml-md-auto col-md-9">
						<Button type="button"
							class="btn btn-group btn-warning btn-animated" id="findBtn">찾기</Button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>

<!--     회원정보 확인 모달 -->
<div class="modal" id="infoModal">
	<div class="modal-dialog modal-dialog-centered modal-lg">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="form-block p-30 light-gray-bg border-clear">
				<h2 class="title">회원 정보 확인</h2>
			</div>

			<form id="updateForm" class="form-horizontal" action="" method="post">
				<input type="hidden" name="action" value="update" />
				<div class="form-group has-feedback row">
					<label for="inputName"
						class="col-md-3 control-label text-md-right col-form-label">아이디
						<span class="text-danger small">*</span>
					</label>
					<div class="col-md-8">
						<input type="hidden" id="uuserId" name="userId"
							value="${userinfo.userId}" /> <label>${userinfo.userId}</label>
					</div>
				</div>
				<div class="form-group has-feedback row">
					<label for="inputLastName"
						class="col-md-3 control-label text-md-right col-form-label">비밀번호
						<span class="text-danger small">*</span>
					</label>
					<div class="col-md-8">
						<label class="info_label" class="info_input">${userinfo.password}</label>
						<input type="text" class="info_input" id="upassword"
							name="password" value="${userinfo.password}" />
					</div>
				</div>
				<div class="form-group has-feedback row">
					<label for="inputUserName"
						class="col-md-3 control-label text-md-right col-form-label">이름
						<span class="text-danger small">*</span>
					</label>
					<div class="col-md-8">
						<label class="info_label" class="info_input">${userinfo.name}</label>
						<input type="text" class="info_input" id="uname" name="name"
							value="${userinfo.name}" />
					</div>
				</div>
				<div class="form-group has-feedback row">
					<label for="inputEmail"
						class="col-md-3 control-label text-md-right col-form-label">주소
						<span class="text-danger small">*</span>
					</label>
					<div class="col-md-8">
						<label class="info_label" class="info_input">${userinfo.address}</label>
						<input type="text" class="info_input" id="uaddress" name="address"
							value="${userinfo.address}" />
					</div>
				</div>
				<div class="form-group has-feedback row">
					<label for="inputPassword"
						class="col-md-3 control-label text-md-right col-form-label">전화번호
						<span class="text-danger small">*</span>
					</label>
					<div class="col-md-8">
						<label class="info_label">${userinfo.phone}</label> <input
							type="text" class="info_input" id="uphone" name="phone"
							value="${userinfo.phone}" />
					</div>
				</div>

				<div class="form-group row">
					<div class="ml-md-auto col-md-9">
						<!-- <button type="button" 
                  class="btn btn-group btn-warning btn-animated">
                  수정 <i class="fa fa-check"></i>
                </button> -->
						<input type="submit" value="수정" id="updateBtn"
							class="btn btn-group btn-warning btn-animated"
							style="display: none;" />
						<button type="button" id="beforeUpdate" onclick="update()"
							class="btn btn-group btn-warning btn-animated"
							data-target="#updateModal">
							수정 <i class="fa fa-check"></i>
						</button>
						<button type="button" id="delete"
							class="btn btn-group btn-warning btn-animated"
							style="display: inline;"
							onclick="location.href='${root}/user/delete/${userinfo.userId}'"
							value="${userinfo.userId}">삭제</button>
					</div>
				</div>
			</form>


		</div>
	</div>
</div>


<%@ include file="/WEB-INF/views/include/footer.jsp"%>

</body>

<script type="text/javascript">
   $(document).ready(function () {
        $("#registerBtn").click(function () {
        	 $("#writeform").attr("action", "${root}/SearchServlet").submit();
        });
    });
	

    
      var map, marker;
      $(document).ready(function () {
        // 초기 kakao map 설정 start
        var container = document.getElementById("map"); //지도를 담을 영역의 DOM 레퍼런스
        // var lat = 37.5012743;
        // var lng = 127.039585;
        var locPosition = new kakao.maps.LatLng(37.5012743, 127.039585); // (멀티캠퍼스)
        var options = {
          //지도를 생성할 때 필요한 기본 옵션
          center: locPosition, //지도의 중심좌표.
          level: 3, //지도의 레벨(확대, 축소 정도)
        };

        map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

        // HTML5의 geolocation으로 사용할 수 있는지 확인합니다
        if (navigator.geolocation) {
          // GeoLocation을 이용해서 접속 위치를 얻어옵니다
          navigator.geolocation.getCurrentPosition(function (position) {
            var lat = position.coords.latitude, // 위도
              lon = position.coords.longitude; // 경도

            locPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
            var message = '<div style="padding:5px;">현재위치인가요?!</div>'; // 인포윈도우에 표시될 내용입니다

            // 마커와 인포윈도우를 표시합니다
            displayMarker(locPosition, message);
          });
        } else {
          // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

          locPosition = new kakao.maps.LatLng(33.450701, 126.570667);
          var message = "geolocation을 사용할수 없어요..";

          displayMarker(locPosition, message);
        }
        // 초기 kakao map 설정 end

        var locations =[];
        locations = [
          ['도봉구'   ,   37.6658609   ,   127.0317674   ],
          ['은평구'   ,   37.6176125   ,   126.9227004   ],
          ['동대문구'   ,   37.5838012   ,   127.0507003   ],
          ['동작구'   ,   37.4965037   ,   126.9443073   ],
          ['금천구'   ,   37.4600969   ,   126.9001546   ],
          ['구로구'   ,   37.4954856   ,   126.858121   ],
          ['종로구'   ,   37.5990998   ,   126.9861493   ],
          ['강북구'   ,   37.6469954   ,   127.0147158   ],
          ['중랑구'   ,   37.5953795   ,   127.0939669   ],
          ['강남구'   ,   37.4959854   ,   127.0664091   ],
          ['강서구'   ,   37.5657617   ,   126.8226561   ],
          ['중구'   ,   37.5579452   ,   126.9941904   ],
          ['강동구'   ,   37.5492077   ,   127.1464824   ],
          ['광진구'   ,   37.5481445   ,   127.0857528   ],
          ['마포구'   ,   37.5622906   ,   126.9087803   ],
          ['서초구'   ,   37.4769528   ,   127.0378103   ],
          ['성북구'   ,   37.606991   ,   127.0232185   ],
          ['노원구'   ,   37.655264   ,   127.0771201   ],
          ['송파구'   ,   37.5048534   ,   127.1144822   ],
          ['서대문구'   ,   37.5820369   ,   126.9356665   ],
          ['양천구'   ,   37.5270616   ,   126.8561534   ],
          ['영등포구'   ,   37.520641   ,   126.9139242   ],
          ['관악구'   ,   37.4653993   ,   126.9438071   ],
          ['성동구'   ,   37.5506753   ,   127.0409622   ],
          ['용산구'   ,   37.5311008   ,   126.9810742   ]
        ];


       

        function searchByName(name){
          
          var select = $("#areaBtn").text();
          jQuery('#aptlist').show();
          $("#mapArea").removeClass();
          $("#mapArea").addClass("col-lg-8");
          getAptList(select, name);
          // displayArea(name);
        }
      });

      function displayArea(name) {

        // 장소 검색 객체를 생성합니다
        var ps = new kakao.maps.services.Places(); 

        // 키워드로 장소를 검색합니다
        ps.keywordSearch(name, placesSearchCB); 

        // 키워드 검색 완료 시 호출되는 콜백함수 입니다
        function placesSearchCB (data, status, pagination) {
            if (status === kakao.maps.services.Status.OK) {

                // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
                // LatLngBounds 객체에 좌표를 추가합니다
                var bounds = new kakao.maps.LatLngBounds();

                for (var i=0; i<data.length; i++) {
                    displayMarker(data[i]);    
                    bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
                }       

                // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
                map.setBounds(bounds);
            } 
        }

        // 지도에 마커를 표시하는 함수입니다
        function displayMarker(place) {
          if (marker) marker.setMap(null);
            // 마커를 생성하고 지도에 표시합니다
            var marker = new kakao.maps.Marker({
                map: map,
                position: new kakao.maps.LatLng(place.y, place.x),
                clickable: true
            });

          var iwContent = '<div style="padding:5px;">'+place.place_name+'</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
          iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

          // 인포윈도우를 생성합니다
          var infowindow = new kakao.maps.InfoWindow({
            content : iwContent,
            removable : iwRemoveable
          });

          // 마커에 클릭이벤트를 등록합니다
          kakao.maps.event.addListener(marker, 'click', function() {
                // 마커 위에 인포윈도우를 표시합니다
                infowindow.open(map, marker);  
          });
        }



        // if (marker) marker.setMap(null); // 기존 maker 제거

        // var imageSrc = "img/my_position.png", // 마커이미지의 주소입니다
        //   imageSize = new kakao.maps.Size(50, 70), // 마커이미지의 크기입니다
        //   imageOption = { offset: new kakao.maps.Point(27, 69) }; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

        // // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
        // var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

        // // 마커를 생성합니다
        // marker = new kakao.maps.Marker({
        //   map: map,
        //   position: locPosition,
        //   image: markerImage,
        // });

        // var iwContent = message, // 인포윈도우에 표시할 내용
        //   iwRemoveable = true;

        // // 인포윈도우를 생성합니다
        // var infowindow = new kakao.maps.InfoWindow({
        //   content: iwContent,
        //   removable: iwRemoveable,
        // });

        // // 인포윈도우를 마커위에 표시합니다
        // infowindow.open(map, marker);

        // // 지도 중심좌표를 접속위치로 변경합니다
        // map.setCenter(locPosition);
      }

      function getAptList(select, name){  
        var ServiceKey = 'J00wyHwtsglk/mHp5jGlkF4L0+ajlahqGt1MI9uvK45P9hLHQJJ2c7dRzAjIfDdR39oShBrCPqJlwEDema86Hg==';
        var pageNo = '1';
        var numOfRows = '30';
        var LAWD_CD = '11110';
        var DEAL_YMD = '202012';
        // server에서 넘어온 data
        $.ajax({
          url: 'http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev',
          type: 'GET',
          data: {
            "ServiceKey": ServiceKey,
            "pageNo": pageNo,
            "numOfRows": numOfRows,
            "LAWD_CD": LAWD_CD,
            "DEAL_YMD": DEAL_YMD
          },
          dataType: 'xml',
          success: function (response) {
            console.log(response);
            makeList(response, select, name);
          },
          error: function (xhr, status, msg) {
            console.log('상태값 : ' + status + ' Http에러메시지 : ' + msg);
          },
        });
        
      }

      function makeList(data, select, name) {
                var aptlist = `<h2>거래 정보</h2><br>`;
                $(data)
                    .find('item')
                    .each(function () {

                      var selectVal;
                      if(select == "아파트명"){
                        selectVal = $(this).find('아파트').text().trim()
                      }
                      else if (select == "동"){
                        selectVal = $(this).find('법정동').text().trim();
                      }

                      
                    });
                $('tr:first').css('background', 'darkgray').css('color', 'white');
                $('tr:even').css('background', 'lightgray');
      }

    </script>
<script type="text/javascript">
    $(document).ready(function () {
    	  // login
    	  var isLogin = localStorage.getItem("isLogin");
    	  localStorage.removeItem("isLogin");
    	  var login = document.getElementById("login");
    	  var logout = document.getElementById("logout");

    	  var stroragePoll = localStorage.getItem("poll");
    	  var pollContent;

    	  if (stroragePoll) {
    	    var vote = JSON.parse(stroragePoll);
    	    var sdate = vote.start_date;
    	    var edate = vote.end_date;
    	    var question = vote.question;
    	    var answers = vote.answers;
    	    pollContent = `
    	        <div class="text-center text-secondary mb-3"><h4>[ 당신의 선택 ]</h4></div>
    	        <div class="font-weight-bold text-info bg-light"><h3>${question}</h3></div>
    	        <div class="text-left p-3">
    	            <ul class="nav flex-column">
    	        `;
    	    for (var i = 0; i < answers.length; i++) {
    	      pollContent += `
    	                <li class="nav-item">
    	                    <label><input type="radio" name="vote-answer" value="${answers[i]}" /> ${answers[i]}</label>
    	                </li>
    	            `;
    	    }
    	    pollContent += `
    	            </ul>
    	        </div>
    	        <div class="text-right">
    	            <button class="btn btn-outline-primary btn-sm" id="btn-poll">투표하기</button>
    	            <button class="btn btn-outline-danger btn-sm">결과보기</button>
    	        </div>
    	        <div class="text-right text-secondary mt-1">투표기간 : ${sdate} ~ ${edate}</div>
    	        `;
    	    $("#vote-area").html(pollContent);
    	    $("#vote-btn-area").css("display", "none");
    	    $("#vote-area").css("display", "");
    	  } else {
    	    pollContent = `<h3>진행중인 투표가 없습니다.</h3>`;
    	    $("#vote-area").html(pollContent);
    	    $("#vote-btn-area").css("display", "");
    	    $("#vote-area").css("display", "");
    	  }

    	  $(document).on("click", "#btn-poll", function () {
    	    var selItem = $('input[name="vote-answer"]:checked').val();
    	    if (selItem) alert(selItem + "을 선택했습니다.");
    	    else alert("지역을 선택해 주세요.");
    	  });

    	  $("#btn-add").click(function () {
    	    var div = $('<div class="form-inline mb-1 poll-answer-item">')
    	      .append('   <input type="text" class="form-control col-lg-10 mr-3" name="answer">')
    	      .append(
    	        '   <button type="button" class="btn btn-outline-danger btn-sm btn-remove">삭제</button>'
    	      );
    	    $("#poll-answer-list").append(div);
    	  });

    	  $(document).on("click", ".btn-remove", function () {
    	    $(this).parent(".poll-answer-item").remove();
    	  });

    	  $("#btn-make").click(function () {
    	    var sdate = $("#start-date").val();
    	    var edate = $("#end-date").val();
    	    if (!sdate || !edate) {
    	      alert("설문 기간 입력!!!");
    	      return;
    	    }

    	    var question = $("#question").val();
    	    if (!question) {
    	      alert("질문 내용 입력!!");
    	      return;
    	    }

    	    var isValid = true;
    	    $('input[name="answer"]').each(function () {
    	      if (!$(this).val()) {
    	        alert("답변 항목 입력!!");
    	        isValid = false;
    	        return false; //break;
    	        // return true; // continue;
    	      }
    	    });

    	    if (!isValid) {
    	      return;
    	    }

    	    var answers = [];
    	    $('input[name="answer"]').each(function () {
    	      answers.push($(this).val());
    	    });

    	    var poll = {
    	      start_date: sdate,
    	      end_date: edate,
    	      question: question,
    	      answers: answers,
    	    };

    	    localStorage.setItem("poll", JSON.stringify(poll));

    	    alert("투표 생성합니다!!!");
    	    location.reload();
    	    $("#voteModal").modal("hide");
    	  });
    	});

    </script>
</html>

