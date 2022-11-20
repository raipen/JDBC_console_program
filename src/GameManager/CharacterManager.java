package GameManager;

import DAO.*;
import DTO.*;
import page.*;
import util.*;
import java.util.*;

public class CharacterManager extends Page
{
	CharacterDAO characterDAO = CharacterDAO.getInstance();

	public CharacterManager(CharacterDTO_GM charcater)
	{
		addMenu(new Menu("능력 조회")
		{
			public void execute()
			{
				AbilityDAO abilityDAO = AbilityDAO.getInstance();
				AbilityDTO ability = abilityDAO.getAbility(charcater);
				System.out.println("SPEED: " + ability.getSpeed() + "\tLIFE: "
						+ ability.getLife() + "\tCOOLDOWN: " + ability.getCoolDown());
			};
		});

		addMenu(new Menu("맵별 최고기록 등수")
		{
			public void execute()
			{
				RecordDAO recordDAO = RecordDAO.getInstance();
				List<String> rankList = recordDAO.getCharacterRankList(charcater);
				for (String r : rankList)
					System.out.println(r);
			};
		});

		addMenu(new Menu("수정")
		{
			public void execute()
			{
				System.out.print("1. 캐릭터명 변경\n2. LV 변경\n3. EXP 변경\n4. 취소\n메뉴를 선택하세요 : ");
				int selected = Stdin.getScanner().nextInt();
				Stdin.getScanner().nextLine();
//				if (selected == 1)
//				{
//					System.out.print("변경할 캐릭터명을 입력해주세요: ");
//					String answer = Stdin.getScanner().nextLine();
//					// userDAO.changeID(user.getUserID(), answer);
//					System.out.println("변경되었습니다.아직 미구현"); // 아직 미구현
//				}
				if (selected == 2)
				{
					System.out.print("변경할 LV를 입력해주세요: ");
					int answer = Stdin.getScanner().nextInt();
					Stdin.getScanner().nextLine();
					CharacterDTO_GM result = characterDAO.changeLV(charcater, answer);
					System.out.println("변경되었습니다.");
					System.out.println("캐릭터 이름" + "\t\tLV	EXP	스킬\t\t보유 계정");
					System.out.println(result.getcharacterName() + "\t\t" + result.getLv()
							+ "\t" + result.getExp() + "\t" + result.getSkillID() + "\t\t"
							+ result.getUserID());
				}
				if (selected == 3)
				{
					System.out.print("변경할 EXP를 입력해주세요: ");
					int answer = Stdin.getScanner().nextInt();
					Stdin.getScanner().nextLine();
					CharacterDTO_GM result = characterDAO.changeEXP(charcater, answer);
					System.out.println("변경되었습니다.");
					System.out.println("캐릭터 이름" + "\t\tLV	EXP	스킬\t\t보유 계정");
					System.out.println(result.getcharacterName() + "\t\t" + result.getLv()
							+ "\t" + result.getExp() + "\t" + result.getSkillID() + "\t\t"
							+ result.getUserID());
				}
			};
		});

		addMenu(new Menu("삭제")
		{
			public void execute()
			{
				System.out.print("정말 삭제 하시겠습니까? (y/n)");
				String answer = Stdin.getScanner().nextLine();

				if (answer.equals("y"))
				{
					characterDAO.deleteCharacter(charcater.getCharacterID());
					System.out.println("탈퇴되었습니다.");
					this.setIsExit(true);
				}
				else
				{
					System.out.println("탈퇴가 취소되었습니다.");
				}
			};
		});

		addMenu(new Menu("뒤로가기", true)
		{
			public void execute()
			{
				System.out.println("뒤로가기");
			};
		});
	}

	public CharacterManager()
	{
		addMenu(new Menu("즉발형 스킬을 가진 캐릭터")
		{
			public void execute()
			{
				List<String> characterList = characterDAO.directSkillCharacterList();
				for (String c : characterList)
					System.out.println(c);
			};
		});
		
		addMenu(new Menu("SPEED가 일정 수준 이상인 캐릭터")
		{
			public void execute()
			{
				System.out.print("최소 SPEED를 입력해주세요: ");
				int answer = Stdin.getScanner().nextInt();
				Stdin.getScanner().nextLine();
				
				List<String> characterList = characterDAO.getcharacterOverSpeedList(answer);
				for (String c : characterList)
					System.out.println(c);
			};
		});

		addMenu(new Menu("뒤로가기", true)
		{
			public void execute()
			{
				System.out.println("뒤로가기");
			};
		});
	}
}
