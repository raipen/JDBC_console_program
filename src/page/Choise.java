package page;

import DTO.*;
import util.*;
import DAO.*;
import java.util.List;

public class Choise extends Page {
	UserDTO user;
	UserDAO userDAO = UserDAO.getInstance();
	public Choise(UserDTO user) {
		this.user = user;
		System.out.println(user.getUserID() + "님의 캐릭터창.");
		
		addMenu(new Menu("캐릭터 선택하기") {
			public void execute() {
				List<CharacterDTO> CharacterList = userDAO.getCharacterList(user.getUserID());
				int num=1;
				for (CharacterDTO character : CharacterList) {
					System.out.printf("%d",num++);
					System.out.println(character);
				}
			};
			
		});
		addMenu(new Menu("캐릭터 생성하기") {
			public void execute() {
				
				};
		});
		addMenu(new Menu("캐릭터 삭제하기") {
			public void execute() {
				
				};
		});
		addMenu(new Menu("뒤로가기",true) {
			public void execute() {
				System.out.println("로그아웃");
			};
		});
		
	}
}
