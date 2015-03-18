package q3.mak1g11;

import java.util.ArrayList;
import java.util.HashMap;

public aspect RuntimeProfiling {

	public class MethodProfile{
		String methodName;
		HashMap<Integer,Integer> input;
		HashMap<Integer,Integer> output;
		ArrayList<Double> completionTimes;
		int failures;
		double average;
		double standardDeviation;
		
		public MethodProfile(String methodName){
			this.methodName = methodName;
			input = new HashMap<Integer, Integer>();
			output = new HashMap<Integer, Integer>();
			completionTimes = new ArrayList<Double>();
			failures = 0;
		}
		
		public double average(){
			double total = (double) 0;
			for(Double d:completionTimes){
				total+=d;
			}
			average = (double) (total/(double)completionTimes.size());
			return average;
		}
		
		public double standardDeviation(){
			double total = (double) 0;
			for(Double d: completionTimes){
				total += (d - average)*(d - average);
			}
			standardDeviation = (double) (total/(double)completionTimes.size());
			return standardDeviation;			
		}
		
		public double failureFrequency(){
			return failures/completionTimes.size() * 100;
		}
	}
	
	
	
	
}
