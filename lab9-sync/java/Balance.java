public class Balance
{
    /**
     * A monitor for keeping the four numbers a,b,c,d
     * and for synchronising the swapping of neighbours
     * and detection when the numbers are balanced.
     */
    private static class State
    {
        private int a, b, c, d;
        
        /**
         * Set the numbers a, b, c, d to be balanced.
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
         * Block until a, b, c, d are balanced and then return them all.
         */
        public synchronized ABCD wait_until_all_balanced()
        {
            // wait until the numbers a, b, c, d are balanced:
            while ( ! (balanced(a,b) && balanced(b,c) && balanced(c,d)) )
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

        private static boolean balanced(int i, int j)
        {
            return Math.abs(j-i) <= 1;
        }

        /**
         * Wait until A and B are not balanced and then bring their values nearer each other
         */
        public synchronized void balanceAB()
        {
            /* TASK 9.2.(c) - part 1 */




            if(a < b - 1)
            {
                a++; b--;
            }
            else if(b < a - 1)
            {
                b++; a--;
            }

            print();
            /* TASK 9.2.(c) - part 2 */


        }

        /**
         * Wait until B and C are not balanced and then bring their values nearer each other
         */
        public synchronized void balanceBC()
        {
            /* TASK 9.2.(c) - part 1 */




            if(b < c - 1)
            {
                b++; c--;
            }
            else if(c < b - 1)
            {
                c++; b--;
            }

            print();
            /* TASK 9.2.(c) - part 2 */

        }

        /**
         * Wait until C and D are not balanced and then bring their values nearer each other
         */
        public synchronized void balanceCD()
        {
            /* TASK 9.2.(c) - part 1 */




            if(c < d - 1)
            {
                c++; d--;
            }
            else if(d < c - 1)
            {
                d++; c--;
            }

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
     * A class of threads that periodically calls state.balanceAB().
     */
    private static class BalanceAB implements Runnable
    {
        public void run()
        {
            while ( true ) { state.balanceAB(); }
        }
    }

    /**
     * A class of threads that periodically calls state.balanceBC().
     */
    private static class BalanceBC implements Runnable
    {
        public void run()
        {
            while ( true ) { state.balanceBC(); }
        }
    }

    /**
     * A class of threads that periodically calls state.balanceBC().
     */
    private static class BalanceCD implements Runnable
    {
        public void run()
        {
            while ( true ) { state.balanceCD(); }
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
        // start the balance threads:
        /* TASK 9.2.(b) */




        // set a task to the balancer:
        System.out.println("Starting");
        state.set_all(5,1,3,10);
        state.wait_until_all_balanced();
        System.out.println("Finishing");
    }

}
