package page;

import DTO.*;
import util.*;
import DAO.*;
import java.util.List;

public class Login extends Page {
	UserDTO user;
	UserDAO userDAO = UserDAO.getInstance();
	RecordDTO record;
	RecordDAO recordDAO=RecordDAO.getInstance();
	public Login(UserDTO user) {
		this.user = user;
		System.out.println(user.getUserID() + "님 환영합니다.");
		
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
		addMenu(new Menu("보유 아이템 조회") {
			public void execute() {
				List<ItemDTO> itemList = userDAO.getItemList(user.getUserID());
				for (ItemDTO item : itemList) {
					System.out.println(item);
				}
			};
		});
		addMenu(new Menu("기록 보기") {
			public void execute() {
				System.out.printf("  닉네임:      mapNo:     기록(ms)\n");
				List<RecordDTO> RecordList = recordDAO.getRecordList(user.getUserID());
				for (RecordDTO record : RecordList) {
					record.printrecord();
				}	
			};
		});
		addMenu(new Menu("비밀번호 변경") {
			public void execute() {
				System.out.println("변경할 비밀번호를 입력하세요.");
				String newPassword = Stdin.getScanner().nextLine();
				userDAO.changePassword(user.getUserID(), newPassword);
				System.out.println("비밀번호가 변경되었습니다.");
			};
		});
		addMenu(new Menu("탈퇴") {
			public void execute() {
				System.out.println("정말 탈퇴하시겠습니까? (y/n)");
				String answer = Stdin.getScanner().nextLine();
				if (answer.equals("y")) {
					userDAO.deleteAccount(user.getUserID());
					System.out.println("탈퇴되었습니다.");
					this.setIsExit(true);
				} else {
					System.out.println("탈퇴가 취소되었습니다.");
				}
			};
		});
		addMenu(new Menu("로그아웃",true) {
			public void execute() {
				System.out.println("로그아웃");
			};
		});
	}
}
