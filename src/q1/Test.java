package q1;

import q1.subPack.C;

public class Test {
	public static void main(String[] args) {
		A a = new A();
		a.foo(1);
		B b = new B();
		b.foo(2);
		C c = new C();
		c.foo(3);
		a.foo(4);
		b.foo(5);
		c.foo(6);
	}
}
