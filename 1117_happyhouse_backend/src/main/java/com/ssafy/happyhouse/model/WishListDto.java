package com.ssafy.happyhouse.model;

public class WishListDto {
   private String userid;
   private String aptno;

   public WishListDto() {
      // TODO Auto-generated constructor stub
   }

   public WishListDto(String userid, String aptno) {
      super();
      this.userid = userid;
      this.aptno = aptno;
   }

   public String getUserid() {
      return userid;
   }

   public void setUserid(String userid) {
      this.userid = userid;
   }

   public String getAptno() {
      return aptno;
   }

   public void setAptno(String aptno) {
      this.aptno = aptno;
   }

}