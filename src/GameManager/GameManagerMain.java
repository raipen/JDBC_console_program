package GameManager;

import java.util.*;

import DTO.*;
import page.*;
import util.*;

public class GameManagerMain extends Page
{
	UserDAO_GM gmDAO = UserDAO_GM.getInstance();

	public GameManagerMain()
	{
		System.out.println("관리자님 환영합니다.");

		addMenu(new Menu("전체 계정 조회")
		{
			public void execute()
			{
				List<UserDTO> userList = gmDAO.getUserList(null);
				System.out.println("----------전체 계정 조회 결과-----------");
				System.out.println("ID              PW");
				for (UserDTO U : userList)
					System.out.println(U.getUserID() + "\t" + U.getPassword());
			};
		});

		addMenu(new Menu("전체 캐릭터 조회")
		{
			public void execute()
			{
				List<CharacterDTO> characterList = gmDAO.getCharacterList(null);
				System.out.println("----------전체 캐릭터 조회 결과----------");
				System.out.println("캐릭터 이름"+"\tLV	EXP	스킬");
				for (CharacterDTO U : characterList)
					System.out.println(U.getcharacterName() + "\t\t" + U.getLv() + "\t"
							+ U.getExp() + "\t" + U.getSkillID());
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