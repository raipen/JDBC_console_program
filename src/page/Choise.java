package page;

import DTO.*;
import util.*;
import DAO.*;
import java.util.List;

public class Choise extends Page {
	UserDTO user;
	UserDAO userDAO = UserDAO.getInstance();
	CharacterDTO character;
	CharacterDAO characterDAO = CharacterDAO.getInstance();
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
				System.out.printf("선택할 캐릭터의 닉네임을 적어주세요: ");
				String charactername=Stdin.getScanner().nextLine();
				character=characterDAO.choise(charactername);
				System.out.printf("선택한 캐릭터의 정보: ");
				character.printinfo();
			};
			
		});
		addMenu(new Menu("캐릭터 생성하기") {
			public void execute() {
				
					System.out.println("변경할 비밀번호를 입력하세요.");
					String newPassword = Stdin.getScanner().nextLine();
					userDAO.changePassword(user.getUserID(), newPassword);
					System.out.println("비밀번호가 변경되었습니다.");
				};
				
		});
		addMenu(new Menu("캐릭터 삭제하기") {
			public void execute() {
				
				};
		});
		addMenu(new Menu("뒤로가기",true) {
			public void execute() {
				System.out.println("메인메뉴");
			};
		});
		
	}
}
