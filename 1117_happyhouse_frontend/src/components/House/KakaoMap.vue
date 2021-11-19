<template>
  <div id="map" class="map-canvas" style="height: 600px;"></div>
</template>

<script>
import { mapState, mapGetters } from 'vuex';

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
    ...mapState(["sidos", "guguns", "dongs", "houses"]),
    ...mapGetters(["getLocation"])
  },
  watch: {
    getLocation(val) {
      console.log("houses watch", val);
      if (val.length != 0){
        this.getLatLng(val);
      }
    },
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
    getLatLng(houses) {
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
            '                <div class="ellipsis"> 거래금액 : ' + house['거래금액'] + '</div>' + 
            '                <div class="jibun ellipsis"> 전용면적 : ' + house['전용면적'] + '</div>' + 
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
                map.setCenter(coords);
            });

            kakao.maps.event.addListener(marker, 'rightclick', function() {
                overlay.setMap(null);
            });

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
</style>