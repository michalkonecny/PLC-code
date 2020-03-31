public class A<E>
{
    private E e;
    // private E e = new E(); // BAD

    public <T> void test(T t) { System.out.println("e = " + e + "; testIsE " + t ); }

    public static void main(String[] args){
      A<Integer> a = new A<>();
      a.e = 1;
      a.test("hi!");
    }
}
