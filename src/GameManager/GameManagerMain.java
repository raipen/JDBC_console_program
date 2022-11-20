package GameManager;

import java.util.*;

import DAO.*;
import DTO.*;
import page.*;
import util.*;

public class GameManagerMain extends Page
{
	UserDAO_GM userDAO = UserDAO_GM.getInstance();
	CharacterDAO characterDAO = CharacterDAO.getInstance();
	RecordDAO recordDAO = RecordDAO.getInstance();

	public GameManagerMain()
	{
		System.out.println("관리자님 환영합니다.");

		addMenu(new Menu("전체 계정 조회")
		{
			public void execute()
			{
				List<UserDTO> userList = userDAO.getUserList(null);
				System.out.println("계정 전체 조회 결과: 총 " + userList.size() + " 개");
				System.out.println("ID              PW");
				for (UserDTO U : userList)
					System.out.println(U.getUserID() + "\t" + U.getPassword());
			};
		});

		addMenu(new Menu("계정 이름 검색")
		{
			public void execute()
			{
				System.out.print("계정 이름(%,_를 통한 다중 검색 가능): ");
				Scanner scanner = Stdin.getScanner();
				String id = scanner.nextLine();

				List<UserDTO> userList = userDAO.getUserList(id);
				System.out.println("계정 검색 결과: 총 " + userList.size() + " 개");
				System.out.println("ID              PW");
				for (UserDTO U : userList)
					System.out.println(U.getUserID() + "\t" + U.getPassword());

				if (userList.size() == 1) new UserManager(userList.get(0)).start();
			};
		});

		addMenu(new Menu("전체 캐릭터 조회")
		{
			public void execute()
			{
				List<CharacterDTO_GM> characterList = characterDAO.getCharacterList(null);
				System.out.println("전체 캐릭터 조회 결과 : 총 " + characterList.size() + " 개");
				System.out.println("캐릭터 이름" + "\t\tLV	EXP	스킬\t\t보유 계정");
				for (CharacterDTO_GM U : characterList)
					System.out.println(
							U.getcharacterName() + "\t\t" + U.getLv() + "\t" + U.getExp()
									+ "\t" + U.getSkillID() + "\t\t" + U.getUserID());
			};
		});

		addMenu(new Menu("캐릭터 이름 검색")
		{
			public void execute()
			{
				System.out.print("캐릭터 이름(%,_를 통한 다중 검색 가능): ");
				Scanner scanner = Stdin.getScanner();
				String id = scanner.nextLine();

				List<CharacterDTO_GM> characterList = characterDAO.getCharacterList(id);
				System.out.println("캐릭터 검색 결과 : 총 " + characterList.size() + " 개");
				System.out.println("캐릭터 이름" + "\t\tLV	EXP	스킬\t\t보유 계정");
				for (CharacterDTO_GM U : characterList)
					System.out.println(
							U.getcharacterName() + "\t\t" + U.getLv() + "\t" + U.getExp()
									+ "\t" + U.getSkillID() + "\t\t" + U.getUserID());

				if (characterList.size() == 1)
					new CharacterManager(characterList.get(0)).start();
			};
		});

		addMenu(new Menu("캐릭터 관련 조회")
		{
			public void execute()
			{
				new CharacterManager().start();
			}
		});

		addMenu(new Menu("기록 관련 조회")
		{
			public void execute()
			{
				new RecordManager().start();
			};
		});

		addMenu(new Menu("맵 관련 조회")
		{
			public void execute()
			{
				new MapManager().start();
			};
		});

		addMenu(new Menu("로그아웃", true)
		{
			public void execute()
			{
				System.out.println("로그아웃");
			};
		});
	}

}