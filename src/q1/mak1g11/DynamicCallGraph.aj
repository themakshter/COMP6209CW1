package q1.mak1g11;

import java.util.HashSet;


public aspect DynamicCallGraph {

	//Use of HashSet to store values only once
	HashSet<String> nodes = new HashSet<String>();
	HashSet<String> edges = new HashSet<String>();
	
	pointcut q1Call(): call(public int q1..*(int));
	pointcut parentCheck(): withincode(public int q1..*(int));
	
	//adding the nodes
	before(): q1Call(){
		String node = thisJoinPoint.getSignature().toLongString();
		//System.out.println(node);
		nodes.add(node);
	}
	
	//adding the edges
	before(): q1Call() && parentCheck(){
		String edge1 = thisEnclosingJoinPointStaticPart.getSignature().toLongString();
		String edge2 = thisJoinPointStaticPart.getSignature().toLongString();
		edges.add(edge1 + " -> " + edge2);
	}
	
	
	
	
}
