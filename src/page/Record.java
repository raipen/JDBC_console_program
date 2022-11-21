package page;

import DTO.*;
import util.*;
import DAO.*;
import java.util.List;

public class Record extends Page {
	UserDTO user;
	UserDAO userDAO = UserDAO.getInstance();
	CharacterDTO character;
	CharacterDAO characterDAO = CharacterDAO.getInstance();
	SkillDTO skill;
	SkillDAO skillDAO = SkillDAO.getInstance();
	RecordDTO record;
	RecordDAO recordDAO=RecordDAO.getInstance();
	public Record(UserDTO user) {
		this.user = user;
		System.out.println(user.getUserID() + "님의 record.");
		
		addMenu(new Menu("전체 record") {
			public void execute() {
			System.out.printf("     닉네임:     mapName:     기록(ms)\n");
				List<RecordDTO> RecordList = recordDAO.getRecordList(user.getUserID());
				for (RecordDTO record : RecordList) {
					record.printrecord();
				}	
			};
		});
		
		addMenu(new Menu("맵 별 클리어 횟수") {
			public void execute() {
				System.out.printf("맵이름       클리어횟수\n");
				recordDAO.getCountRecordList(user.getUserID());
			};
		});
		addMenu(new Menu("각 스킬을 사용한 클리어 횟수") {
			public void execute() {
				System.out.printf("스킬이름           클리어횟수\n");
				recordDAO.getSkillRecordList(user.getUserID());
			};
		});
		addMenu(new Menu("뒤로가기",true) {
			public void execute() {
				System.out.println("메인메뉴");
			};
		});
		
		
	}
}
