package q3.mak1g11;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

public aspect RuntimeProfiling {

	public class Method {
		String methodName;
		HashMap<Integer, Integer> input;
		HashMap<Integer, Integer> output;
		ArrayList<Double> completionTimes;
		int failures;
		HashSet<Integer> ints;
		double average;
		double standardDeviation;

		public Method(String methodName) {
			this.methodName = methodName;
			input = new HashMap<Integer, Integer>();
			output = new HashMap<Integer, Integer>();
			completionTimes = new ArrayList<Double>();
			failures = 0;
			ints = new HashSet<Integer>();
		}

		public double average() {
			double total = (double) 0;
			for (Double d : completionTimes) {
				total += d;
			}
			average = (double) (total / (double) completionTimes.size());
			return average;
		}

		public double standardDeviation() {
			double total = (double) 0;
			for (Double d : completionTimes) {
				total += (d - average) * (d - average);
			}
			standardDeviation = (double) (total / (double) completionTimes
					.size());
			return standardDeviation;
		}

		public double failureFrequency() {
			return failures / completionTimes.size() * 100;
		}
	}

	
	HashMap<String, Method> methods = new HashMap<String, Method>();

	// To check our call
	pointcut q1Call(): call(public int q1..*(int));

	pointcut refinedQ1Call(int i): call(public int q1..*(int)) && args(i);

	// Main method execution
	pointcut mainMethod(): execution(public static * main(..));

	int around(int i):q1Call(i){
		//initialise variables
		long startTime, endTime;
		double duration;
		String methodName = thisJoinPoint.getSignature().toLongString();
		Method method;
		
		//check for method already existing in map
		if (methods.containsKey(methodName)) {
			method = methods.get(methodName);
		} else {
			method = new Method(methodName);
		}
		
		//start time
		startTime = System.nanoTime();
		
		//add as number
		method.ints.add(i);
				
		//add input
		if(method.input.containsKey(i)){
			int temp = method.input.get(i)+1;
			method.input.put(i,temp);
		}else{
			method.input.put(i, 1);
		}
		int output = -1;	
		try {
			output = proceed(i);
			
			//add as number
			method.ints.add(output);
			
			//add output
			if(method.output.containsKey(output)){
				int temp = method.output.get(output)+1;
				method.output.put(output,temp);
			}else{
				method.output.put(output, 1);
			}			
		} catch (Exception e) {
			method.failures+=1;
			output = -1;
		}
		endTime = System.nanoTime();
		duration = (double) (endTime - startTime) / 1000000000;
		method.completionTimes.add(duration);
		return output;
	}


	after():mainMethod(){
		PrintWriter out,runtimes,failures;
		try{
			failures = new PrintWriter(new BufferedWriter(new FileWriter(
					"failures.csv")));
			failures.println("Method Name,Failure Frequncy(%)");
			
			runtimes = new PrintWriter(new BufferedWriter(new FileWriter(
					"runtimes.csv")));
			runtimes.println("Method Name,Average runtime (s), Standard Deviation (s)");
			
			for(String s: methods.keySet()){
				Method m = methods.get(s);
				out = new PrintWriter(new BufferedWriter(new FileWriter(
						s+"-hist.csv")));
				
			}
			
			
			
		}catch(IOException ioe){
			
		}
	}

}
