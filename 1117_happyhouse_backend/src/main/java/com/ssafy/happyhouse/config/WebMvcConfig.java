package com.ssafy.happyhouse.config;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.ssafy.happyhouse.interceptor.ConfirmInterceptor;

public class WebMvcConfig implements WebMvcConfigurer {
	private final List<String> patterns = Arrays.asList("/*", "/admin", "/user/list");

	@Autowired
	private ConfirmInterceptor confirmInterceptor;
	
	@Override
	public void addCorsMappings(CorsRegistry registry) {
		// TODO Auto-generated method stub
		registry.addMapping("/**")
		.allowedOrigins("*")
//		.allowedOrigins("http://localhost:8080", "http://localhost:8081")
		.allowedMethods("GET", "POST", "PUT", "DELETE")
		.maxAge(6000);
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(confirmInterceptor).addPathPatterns(patterns);
	}
}
