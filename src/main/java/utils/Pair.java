package utils;

public class Pair<T,U> {
	    private T x;
	    private U y;

	    public Pair(T x, U y) {
	        this.x = x;
	        this.y = y;
	    }

	    public T getKey(){
	        return x;
	    }

	    public U getValue(){
	        return y;
	    }
}
