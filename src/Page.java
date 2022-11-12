import java.util.Scanner;

public class Page {
	private Menu[] menu;
	
	public void start() {
		int selected;
		do {
			printMenu();
			selected = selectMenu();			
		}while(menu[selected].execute());
	}
	
	private void printMenu() {
		for(int i=0;i<menu.length;i++) {
			System.out.println(i+1 + ". " + menu[i]);
		}
	}

	private int selectMenu() {
		Scanner sc = Stdin.getScanner();
		int selected;
		while(true) {
			System.out.print("메뉴를 선택하세요 : ");
			selected = sc.nextInt();
			if(selected >= 1 && selected <= menu.length)
				break;
			System.out.println("잘못된 메뉴입니다.");
		}
		return selected -1;
	}
	
	public void setMenu(Menu[] m) {
		menu = m;
	}
	
}
