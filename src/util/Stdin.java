package util;

import java.util.Scanner;

public class Stdin {
	private static Scanner sc = new Scanner(System.in);
	
	public static Scanner getScanner() {
		return sc;
	}
	
	public static void closeScanner() {
		sc.close();
	}
	
	public static int selectInt(int min,int max){
		int result = 0;
		while(true){
			try{
				result = Integer.parseInt(sc.nextLine());
				if(result<min || result>max){
					System.out.println("Please enter a number between "+min+" and "+max);
					continue;
				}
				break;
			}catch(Exception e){
				System.out.println("Please enter a number between "+min+" and "+max);
			}
		}
		return result;
	}
}
