class Timer {
    int current = 0;
    int total;
    Runnable onEnd;

    Timer (int time, Runnable onEnd) {
        total = time/10;
        this.onEnd = onEnd;


        Thread counter = new Thread(){
            public void run() {
                Loop:while (true) {
                    current++;
                    if (isDone()) break Loop;
                    try {
                        Thread.sleep(10);
                    } catch (InterruptedException e) {

                    }
                }
                onEnd.run();
            }
        };
        counter.start();
    }

    Boolean isDone () {
        return current >= total;
    }
}
