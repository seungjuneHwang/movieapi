package com.test.vo;

import java.util.ArrayList;

public class NaverApiVO {
	private String lastBuildData;
	private String total;
	private String start;
	private String display;
	
	// json 에서 가져온 영화 정보
	private ArrayList<MovieVO> items;
}
