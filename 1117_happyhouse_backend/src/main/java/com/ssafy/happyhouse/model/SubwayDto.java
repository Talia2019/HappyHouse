package com.ssafy.happyhouse.model;

public class SubwayDto {
	private String lineno;
	private String name;
	private String dongcode;
	private String sidoname;
	private String gugunname;
	private String dongname;
	private String guguncode;

	public SubwayDto() {
		// TODO Auto-generated constructor stub
	}

	public SubwayDto(String lineno, String name, String dongcode, String sidoname, String gugunname, String dongname,
			String guguncode) {
		super();
		this.lineno = lineno;
		this.name = name;
		this.dongcode = dongcode;
		this.sidoname = sidoname;
		this.gugunname = gugunname;
		this.dongname = dongname;
		this.guguncode = guguncode;
	}

	public String getLineno() {
		return lineno;
	}

	public void setLineno(String lineno) {
		this.lineno = lineno;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDongcode() {
		return dongcode;
	}

	public void setDongcode(String dongcode) {
		this.dongcode = dongcode;
	}

	public String getSidoname() {
		return sidoname;
	}

	public void setSidoname(String sidoname) {
		this.sidoname = sidoname;
	}

	public String getGugunname() {
		return gugunname;
	}

	public void setGugunname(String gugunname) {
		this.gugunname = gugunname;
	}

	public String getDongname() {
		return dongname;
	}

	public void setDongname(String dongname) {
		this.dongname = dongname;
	}

	public String getGuguncode() {
		return guguncode;
	}

	public void setGuguncode(String guguncode) {
		this.guguncode = guguncode;
	}

}
