<template>
  <div id="map" class="map-canvas" style="height: 600px;"></div>
</template>

<script>
import { mapState, mapGetters} from 'vuex';

export default {
  name: "KakaoMap",
  data() {
    return {
      locations: [],
      map: null,
      geocoder: null,
      markers: [],
      infowindow: null,
    }
  },
  computed: {
    ...mapState(["sidos", "guguns", "dongs", "houses", "coords"]),
    ...mapGetters(["getLocation", "getAptList", "moveCenter"])
  },
  watch: {
    getLocation(val) {
      console.log("houses watch", val);
      if (val.length != 0){
        this.getLatLng(val);
      }
    },
    getAptList(val) {
      console.log("center watch", val);
      this.getLatLng(val);
    },
    moveCenter(val) {
      console.log("move watch", val);
      this.moveLatLng(val);
    }
  },
  mounted() {
    if (window.kakao && window.kakao.maps) {
      this.initMap();
    } else {
      const script = document.createElement("script");
      /* global kakao */
      script.onload = () => kakao.maps.load(this.initMap);
      script.src =
        "//dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=915cffed372954b7b44804ed422b9cf0&libraries=services";
      document.head.appendChild(script);
    }
  },
  methods: {
    test: function () {
      var _this = this;
      _this.getCategory();
    },
    moveLatLng(gudong) {
      const container = document.getElementById("map");
      const options = {
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 5,
      };
      var map = new kakao.maps.Map(container, options);
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
          var lat = position.coords.latitude;
          var lon = position.coords.longitude;

          var locPosition = new kakao.maps.LatLng(lat, lon);
          map.setCenter(locPosition);
        })
      }
      // 주소-좌표 변환 객체를 생성합니다
      this.geocoder = new kakao.maps.services.Geocoder();

      // 주소로 좌표를 검색합니다
        console.log(gudong);
        this.geocoder.addressSearch(gudong, function(result, status) {
            // 정상적으로 검색이 완료됐으면 
          if (status === kakao.maps.services.Status.OK) {  
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            map.setCenter(coords);
          } 
        });    
    },
    getLatLng: function(houses) {
      // var _this = this;

      const container = document.getElementById("map");
      const options = {
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 5,
      };
      
      var map = new kakao.maps.Map(container, options);
      

      // 주소-좌표 변환 객체를 생성합니다
      this.geocoder = new kakao.maps.services.Geocoder();

      // 주소로 좌표를 검색합니다
      houses.forEach(house => {
        this.geocoder.addressSearch(house["법정동"] + " " + house["지번"], function(result, status) {
            // 정상적으로 검색이 완료됐으면 
          if (status === kakao.maps.services.Status.OK) {  
            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
            // 결과값으로 받은 위치를 마커로 표시합니다
            var marker = new kakao.maps.Marker({
              map: map,
              position: coords,
              clickable: true
            });
    
            marker.setMap(map);

            let inputNumber = parseInt(house["거래금액"].replace(",", "")) * 10000
            let unitWords = ['', '만', '억', '조', '경'];
            let splitUnit = 10000;
            let splitCount = unitWords.length;
            let resultArray = [];
            let resultString = '';
            let pay = "";

            if (!inputNumber) return inputNumber;
            else {
              for (let i = 0; i < splitCount; i++) {
                let unitResult = (inputNumber % Math.pow(splitUnit, i+1)) / Math.pow(splitUnit, i);
                unitResult = Math.floor(unitResult);
                if (unitResult > 0) {
                  resultArray[i] = unitResult;
                }
              }

              for (let i = 0; i < resultArray.length; i++) {
                if(!resultArray[i]) continue;
                resultString = String(" " + resultArray[i]) + unitWords[i] + resultString;
              }
              pay = resultString;
            }

            var content =  
            '<div class="wrap">' + 
            '    <div class="info">' + 
            '        <div class="title">' + 
                        house['아파트'] + 
            '        </div>' + 
            '        <div class="body">' + 
            '            <div class="img">' +
            '                <img src="https://image.newdaily.co.kr/site/data/img/2021/01/22/2021012200134_0.png" width="73" height="70">' +
            '           </div>' + 
            '            <div class="desc">' + 
            '                <div class="ellipsis"> 최근거래금액 : ' + pay + '</div>' + 
            '                <div class="jibun ellipsis"> 전용면적 : ' + (parseFloat(house['전용면적']) * 0.3025).toFixed(2) + '평</div>' + 
            '                <div class="jibun ellipsis"> 법정동 : ' + house['법정동'] + '</div>' + 
            '            </div>' + 
            '        </div>' + 
            '    </div>' +    
            '</div>';
            
            var overlay = new kakao.maps.CustomOverlay({
              content : content,
              map: map,
              position: marker.getPosition(),
              clickable: true,
              });

            overlay.setMap(null);

            kakao.maps.event.addListener(marker, 'click', function() {
                overlay.setMap(null);
                overlay.setMap(map);
                // map.setCenter(coords);
            });

            kakao.maps.event.addListener(marker, 'rightclick', function() {
                overlay.setMap(null);
            });

            
            
            // _this.getCategory();
            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            map.setCenter(coords);
          } 
        });    
      })
    },
    initMap() {
      const container = document.getElementById("map");
      const options = {
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 5,
      };
      var map = new kakao.maps.Map(container, options);

      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
          var lat = position.coords.latitude;
          var lon = position.coords.longitude;

          var locPosition = new kakao.maps.LatLng(lat, lon);
          map.setCenter(locPosition);
        })
      }
    },
    changeSize(size) {
      const container = document.getElementById("map");
      container.style.width = `${size}px`;
      container.style.height = `${size}px`;
      this.map.relayout();
    },
  } 
}
</script>

<style>
    .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
    .wrap * {padding: 0;margin: 0;}
    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
    .info .close:hover {cursor: pointer;}
    .info .body {position: relative;overflow: hidden;}
    .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
    .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .info .link {color: #5085BB;}
    .map_wrap, .map_wrap * {margin:0; padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
    .map_wrap {position:relative;width:100%;height:350px;}
    #category {position:absolute;top:10px;left:10px;border-radius: 5px; border:1px solid #909090;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);background: #fff;overflow: hidden;z-index: 2;}
    #category col {float:left;list-style: none;width:50px;border-right:1px solid #acacac;padding:6px 0;text-align: center; cursor: pointer;}
    #category col.on {background: #eee;}
    #category col:hover {background: #ffe6e6;border-left:1px solid #acacac;margin-left: -1px;}
    #category col:last-child{margin-right:0;border-right:0;}
    #category col span {display: block;margin:0 auto 3px;width:27px;height: 28px;}
    #category col .bank {background-position: -10px 0;}
    #category col .mart {background-position: -10px -36px;}
    #category col .pharmacy {background-position: -10px -72px;}
    #category col .oil {background-position: -10px -108px;}
    #category col .cafe {background-position: -10px -144px;}
    #category col .store {background-position: -10px -180px;}
    #category col.on .category_bg {background-position-x:-46px;}
    .placeinfo_wrap {position:absolute;bottom:28px;left:-150px;width:300px;}
    .placeinfo {position:relative;width:100%;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;padding-bottom: 10px;background: #fff;}
    .placeinfo:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
    .placeinfo_wrap .after {content:'';position:relative;margin-left:-12px;left:50%;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
    .placeinfo a, .placeinfo a:hover, .placeinfo a:active{color:#fff;text-decoration: none;}
    .placeinfo a, .placeinfo span {display: block;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
    .placeinfo span {margin:5px 5px 0 5px;cursor: default;font-size:13px;}
    .placeinfo .title {font-weight: bold; font-size:14px;border-radius: 6px 6px 0 0;margin: -1px -1px 0 -1px;padding:10px; color: #fff;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
    .placeinfo .tel {color:#0f7833;}
    .placeinfo .jibun {color:#999;font-size:11px;margin-top:0;}
</style>
