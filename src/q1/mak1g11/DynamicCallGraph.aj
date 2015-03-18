package q1.mak1g11;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;

public aspect DynamicCallGraph {

	// Use of HashSet to store values only once
	HashSet<String> nodes = new HashSet<String>();
	HashSet<String> edges = new HashSet<String>();

	// To check our call
	pointcut q1Call(): call(public int q1..*(int));

	// For check if mj within mi
	pointcut parentCheck(): withincode(public int q1..*(int));

	// Main method execution
	pointcut mainMethod(): execution(public static * main(..));

	// adding the nodes
	before(): q1Call(){
		String node = thisJoinPoint.getSignature().toLongString();
		// System.out.println(node);
		nodes.add(node);
	}

	// adding the edges
	before(): q1Call() && parentCheck(){
		// parent method
		String parent = thisEnclosingJoinPointStaticPart.getSignature()
				.toLongString();
		// current method
		String child = thisJoinPointStaticPart.getSignature().toLongString();
		edges.add(parent + "," + child);
		
	}

	// write to files
	after(): mainMethod(){
		PrintWriter out;
		try {
			// write nodes
			out = new PrintWriter(new BufferedWriter(new FileWriter(
					"q1-nodes.csv")));
			out.println("Nodes");
			
			for (String node : nodes) {
				out.println(node);
			}

			out.flush();
			out.close();

			// write edges
			out = new PrintWriter(new BufferedWriter(new FileWriter(
					"q1-edges.csv")));
			out.println("Source Method,Target Method");

			for (String edge : edges) {
				out.println(edge);
			}

			out.flush();
			out.close();

		} catch (IOException ioe) {

		}
	}

}
