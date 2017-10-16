package com.snr.aop.spring;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Program {

	public static void main(String[] args) {
		//Calculator origin = new NewlecCalculator();
		
		ApplicationContext context = new ClassPathXmlApplicationContext("com/snr/aop/spring/aop-context.xml");
		Calculator cal = (Calculator) context.getBean("proxy");		
		int data = cal.add(3, 0);
	
		//System.out.println(data);
		
	}

}
