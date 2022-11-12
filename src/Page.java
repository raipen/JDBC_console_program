import java.util.Scanner;
import java.util.List;
import java.util.ArrayList;

public class Page {
	private List<Menu> menu = new ArrayList<Menu>();
	
	public void start() {
		int selected;
		do {
			printMenu();
			selected = selectMenu();			
		}while(menu.get(selected).execute());
	}
	
	private void printMenu() {
		for(int i = 0; i < menu.size(); i++) {
			System.out.println(i+1 + ". " + menu.get(i));
		}
	}

	private int selectMenu() {
		Scanner sc = Stdin.getScanner();
		int selected;
		while(true) {
			System.out.print("메뉴를 선택하세요 : ");
			selected = sc.nextInt();
			sc.nextLine();
			if(selected >= 1 && selected <= menu.size())
				break;
			System.out.println("잘못된 메뉴입니다.");
		}
		return selected -1;
	}
	
	protected void addMenu(Menu m) {
		menu.add(m);
	}	
}
