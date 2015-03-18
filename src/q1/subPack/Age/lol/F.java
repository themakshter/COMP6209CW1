package q1.subPack.Age.lol;

public class F {
	public int foo(int a) {
		bar(1);
		return 0;
	}

	public int bar(int b) {
		try{
			return baz(b);
		}catch(Exception e){
			return 0;
		}
		
	}

	public int baz(int a) throws Exception{
		throw new java.lang.Exception("random exception");
	}
}
