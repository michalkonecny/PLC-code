public class Bubble
{
    /**
     * A monitor for keeping the four numbers a,b,c,d
     * and for synchronising the swapping of neighbours
     * and detection when the numbers are sorted.
     */
    private static class State
    {
        private int a, b, c, d;

        /**
         * Set the numbers a, b, c, d to be sorted.
         */
        public synchronized void set_all(int a, int b, int c, int d)
        {
            this.a = a;
            this.b = b;
            this.c = c;
            this.d = d;

            // tell any thread waiting for a change in the state
            // that it has just changed:
            this.notifyAll();

            print();
        }

        /**
         * A simple entity class for holding 4 integers.
         */
        public static class ABCD
        {
            public int a, b, c, d;
        }

        /**
         * Block until a, b, c, d are sorted and then return them all.
         */
        public synchronized ABCD wait_until_sorted()
        {
            // wait until the numbers a, b, c, d are sorted:
            while ( ! (a <= b && b <= c && c <= d) )
            {
                try { this.wait(); } catch (InterruptedException e) { }
            }

            //construct the result:
            ABCD result = new ABCD();
            result.a = a;
            result.b = b;
            result.c = c;
            result.d = d;

            return result;
        }

        /**
         * Wait until B is smaller than A and then swap the value of A and B.
         */
        public synchronized void bubble_ab()
        {
            /* TASK 9.2.(c) - part 1 */




            int temp = a;
            a = b;
            b = temp;

            print();
            /* TASK 9.2.(c) - part 2 */

        }

        /**
         * Wait until C is smaller than B and then swap the value of B and C.
         */
        public synchronized void bubble_bc()
        {
            /* TASK 9.2.(c) - part 1 */




            int temp = b;
            b = c;
            c = temp;

            print();
            /* TASK 9.2.(c) - part 2 */

        }

        /**
         * Wait until D is smaller than C and then swap the value of C and D.
         */
        public synchronized void bubble_cd()
        {
            /* TASK 9.2.(c) - part 1 */





            int temp = c;
            c = d;
            d = temp;

            print();
            /* TASK 9.2.(c) - part 2 */

        }

        /*
         * the following does not need to be synchronized
         * because it is only ever called from a synchronized
         * method in this class.
         */
        private void print()
        {
            System.out.printf("a = %d, b = %d, c = %d, d = %d\n", a, b, c, d);
        }
    }

    /**
     * A global variable pointing at an instance of State.
     * This serves to synchronise all threads in the system.
     */
    private static State state = new State();

    /**
     * A class of threads that periodically calls state.bubble_ab().
     */
    private static class Bubble_ab implements Runnable
    {
        public void run()
        {
            while ( true ) { state.bubble_ab(); }
        }
    }

    /**
     * A class of threads that periodically calls state.bubble_bc().
     */
    private static class Bubble_bc implements Runnable
    {
        public void run()
        {
            while ( true ) { state.bubble_bc(); }
        }
    }

    /**
     * A class of threads that periodically calls state.bubble_bc().
     */
    private static class Bubble_cd implements Runnable
    {
        public void run()
        {
            while ( true ) { state.bubble_cd(); }
        }
    }

    /**
     * Wrapper around Thread.sleep which ignores any InterruptedException.
     *
     * @param millis = number of milliseconds to sleep for
     */
    public static void sleep(int millis)
    {
        try
        {
            Thread.sleep(millis);
        }
        catch (InterruptedException e) {}
    }

    public static void main(String[] args)
    {
        // start the bubble threads:
        /* TASK 9.2.(b) */




        // set a task to the sorter:
        System.out.println("Starting");
        state.set_all(5,1,3,1);
        state.wait_until_sorted();
        System.out.println("Finishing");
    }

}
