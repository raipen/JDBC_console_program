package util;

public abstract class Menu {
	
	private String name;
	private boolean isExit;
	
	public Menu() {}
	
	public Menu(String str) {
		this(str, false);
	}
	
	public Menu(String str, boolean isExit) {
		name = str;
		this.isExit = isExit;
	}
	
	public abstract void execute();
	
	public void setIsExit(boolean t) {
		this.isExit = t;
	}
	
	public boolean isExit() {
		return isExit;
	}

	public String toString() {
		return name;
	}
}
