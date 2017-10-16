package com.snr.aop.spring;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.springframework.util.StopWatch;

public class LogHandler implements MethodInterceptor {

	@Override
	public Object invoke(MethodInvocation method) throws Throwable {
		
		System.out.println("�⺻ Around ����Ǵ� ����");
		
		StopWatch watch = new StopWatch();
		
		watch.start();
		Object result = method.proceed();
		watch.stop();
		
		long du = watch.getLastTaskTimeMillis();
		System.out.println(du);
		
		return result;
	}

}
