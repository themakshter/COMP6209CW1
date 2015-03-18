package q1;

import q1.subPack.C;
import q1.subPack.Age.D;
import q1.subPack.Age.lol.E;
import q1.subPack.Age.lol.F;

public class Test {
	public static void main(String[] args) {
		A a = new A();
		B b = new B();
		C c = new C();
		D d = new D();
		E e = new E();
		F f = new F();
		for (int i = 0; i < 10; i++) {
			a.foo(i + i + 10);
			b.foo(i + i + 10);
			c.foo(i + i + 10);
			d.foo(i + i + 10);
			e.foo(i + i + 10);
			f.foo(i + i + 10);
		}
		System.out.println("done");
	}
}
