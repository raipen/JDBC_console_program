import java.util.Scanner;

public class Page {
	protected String[] menuDescription;
	protected Menu[] menu;
	
	public void start() {
		while(true) {
			printMenu();
			int selected = selectMenu();
			if(selected == menu.length) {
				break;
			}
			menu[selected].execute();
		}
	}
	
	private void printMenu() {
		for(int i=0;i<menuDescription.length;i++) {
			System.out.println(i+1 + ". " + menuDescription[i]);
		}
	}

	private int selectMenu() {
		Scanner sc = new Scanner(System.in);
		int selected;
		while(true) {
			System.out.print("메뉴를 선택하세요 : ");
			selected = sc.nextInt();
			if(selected >= 1 && selected <= menuDescription.length)
				break;
			System.out.println("잘못된 메뉴입니다.");
		}
		return selected -1;
	}
	
}
