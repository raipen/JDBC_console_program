
public abstract class Menu {
	
	private String name;
	
	public Menu(String str) {
		name = str;
	}
	
	public abstract boolean execute();
	
	public String toString() {
		return name;
	}
}
