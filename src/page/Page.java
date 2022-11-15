package page;

import java.util.Scanner;
import java.util.List;
import java.util.ArrayList;
import util.*;

public class Page {
	private List<Menu> menu = new ArrayList<Menu>();

	public void start() {
		int selected;
		do {
			System.out.println("-----------------------------------");
			printMenu();
			selected = selectMenu();
			System.out.println("-----------------------------------");
			menu.get(selected).execute();
		} while (!menu.get(selected).isExit());
	}

	private void printMenu() {
		for (int i = 0; i < menu.size(); i++) {
			System.out.println(i + 1 + ". " + menu.get(i));
		}
	}

	private int selectMenu() {
		Scanner sc = Stdin.getScanner();
		int selected;
		while (true) {
			System.out.print("메뉴를 선택하세요 : ");
			selected = sc.nextInt();
			sc.nextLine(); //버퍼비우기
			if (selected >= 1 && selected <= menu.size())
				break;
			System.out.println("잘못된 메뉴입니다.");
		}
		return selected - 1;
	}

	protected void addMenu(Menu m) {
		menu.add(m);
	}
}
