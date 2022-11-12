import java.util.Scanner;

public class Stdin {
	private static Scanner sc = new Scanner(System.in);
	
	public static Scanner getScanner() {
		return sc;
	}
	
	public static void closeScanner() {
		sc.close();
	}
	
}
