package q2.mak1g11;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;

public aspect RefinedDynamicCallGraph {

	// Use of HashSet to store values only once
	HashSet<String> nodes = new HashSet<String>();
	HashSet<String> edges = new HashSet<String>();

	// To check our call
	pointcut q1Call(): call(public int q1..*(int));

	// refined call which gives us a variable to use for our around advice
	pointcut refinedQ1Call(int i): call(public int q1..*(int)) && args(i);

	// For check if mj within mi
	pointcut parentCheck(): withincode(public int q1..*(int));

	// Main method execution
	pointcut mainMethod(): execution(public static * main(..));

	// adding the nodes
	before(): q1Call(){
		String node = thisJoinPoint.getSignature().toLongString();
		nodes.add(node);
	}

	// add the edges as they are
	before(): q1Call() && parentCheck(){
		// parent method
		String parent = thisEnclosingJoinPointStaticPart.getSignature()
				.toLongString();
		// current method
		String child = thisJoinPointStaticPart.getSignature().toLongString();
		edges.add(parent + "," + child);

	}

	// if exception is thrown - remove that specific edge
	after() throwing(java.lang.Exception e):q1Call() && parentCheck(){
		// parent method
		String parent = thisEnclosingJoinPointStaticPart.getSignature()
				.toLongString();
		// current method
		String child = thisJoinPointStaticPart.getSignature().toLongString();
		edges.remove(parent + "," + child);
	}

	// write to files
	after(): mainMethod(){
		PrintWriter out;
		try {
			// write nodes
			out = new PrintWriter(new BufferedWriter(new FileWriter(
					"q2-nodes.csv")));
			out.println("Nodes");

			for (String node : nodes) {
				out.println(node);
			}

			out.flush();
			out.close();

			// write edges
			out = new PrintWriter(new BufferedWriter(new FileWriter(
					"q2-edges.csv")));
			out.println("Source Method,Target Method");

			for (String edge : edges) {
				out.println(edge);
			}

			out.flush();
			out.close();

		} catch (IOException ioe) {
			ioe.printStackTrace();
		}
	}
}
