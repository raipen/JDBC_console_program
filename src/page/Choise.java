package page;

import DTO.*;
import util.*;
import DAO.*;
import java.util.List;
import java.util.Scanner;
import java.util.Random;

public class Choise extends Page {
	UserDTO user;
	UserDAO userDAO = UserDAO.getInstance();
	CharacterDTO character;
	CharacterDAO characterDAO = CharacterDAO.getInstance();
	SkillDTO skill;
	SkillDAO skillDAO = SkillDAO.getInstance();
	
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
				
				Scanner sc = Stdin.getScanner();
				int selected;
				while (true) {
					System.out.print("캐릭터를 선택하세요 : ");
					selected = sc.nextInt();
					sc.nextLine(); //버퍼비우기
					if (selected >= 1 && selected <= CharacterList.size())
						break;
					System.out.println("잘못된 번호입니다.");
				}
				character=characterDAO.choise(CharacterList.get(selected-1).getcharacterName());
				System.out.printf("선택한 캐릭터의 정보: ");
				character.printinfo();
			};
			
		});
		addMenu(new Menu("캐릭터 생성하기") {
			public void execute() {	
				Random random = new Random(); //랜덤 객체 생성(디폴트 시드값 : 현재시간)
		        random.setSeed(System.currentTimeMillis()); 
				Scanner scanner = Stdin.getScanner();
				String charactername;
				String characterid;
				int randomid;
				System.out.print("닉네임(이전 메뉴로 나가시려면 \"QUIT\"를 입력해주세요): ");
				charactername = scanner.nextLine();
				if (charactername.equals("QUIT"))
				{
					return;
				}
				while (characterDAO.isExist(charactername))
				{
					System.out.println("이미 존재하는 닉네임입니다.");
					System.out.print("닉네임(이전 메뉴로 나가시려면 \"QUIT\"를 입력해주세요): ");
					charactername = scanner.nextLine();
					if (charactername.equals("QUIT"))
					{
						return;
					}
				}
				randomid=random.nextInt(1000000);
				characterid=String.valueOf(randomid);
				while(characterDAO.isExist_id(characterid))
				{
					randomid= random.nextInt(1000000);
					characterid=String.valueOf(randomid);
				}
				int num=1;

				System.out.println("스킬 목록");

				System.out.println("----------------------------");
				List<SkillDTO> SkillList = skillDAO.getSkillList();
				for (SkillDTO skill : SkillList) {
					System.out.printf("%d: ",num++);
					skill.printskill();
				}
				System.out.println("----------------------------");
				
				Scanner sc = Stdin.getScanner();
				int selected;
				while (true) {
					System.out.print("스킬을 선택하세요 : ");
					selected = sc.nextInt();
					sc.nextLine(); //버퍼비우기
					if (selected >= 1 && selected <= SkillList.size())
						break;
					System.out.println("잘못된 번호입니다.");
				}
				
				boolean makeSuccess = characterDAO.MakeCharacter(user.getUserID(), characterid, charactername, SkillList.get(selected-1).getSkillID());
				if (makeSuccess) System.out.println("캐릭터 생성 성공");
				else System.out.println("캐릭터 생성 실패");
				
				
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
