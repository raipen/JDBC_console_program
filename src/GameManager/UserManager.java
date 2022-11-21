package GameManager;

import page.*;

import java.util.*;

import DAO.*;
import DTO.*;
import util.*;

public class UserManager extends Page
{
	UserDAO_GM userDAO = UserDAO_GM.getInstance();

	public UserManager(UserDTO user)
	{
		addMenu(new Menu("보유 캐릭터 조회")
		{
			public void execute()
			{
				List<CharacterDTO_GM> characterList = userDAO
						.getCharacterList(user.getUserID());
				System.out.println("보유 캐릭터 조회 결과 : 총 " + characterList.size() + " 개");
				System.out.println("캐릭터 이름" + "\t\tLV	EXP	스킬");
				for (CharacterDTO_GM U : characterList)
					System.out.println(U.getCharacterName() + "\t\t" + U.getLv() + "\t"
							+ U.getExp() + "\t" + U.getSkillID());
			};
		});

		addMenu(new Menu("비밀번호 변경")
		{
			public void execute()
			{
				System.out.println("현재 비밀번호를 입력하세요.");
				String oldPassword = Stdin.getScanner().nextLine();
				if (oldPassword.equals(user.getPassword()))
				{
					System.out.println("새 비밀번호를 입력하세요.");
					String newPassword = Stdin.getScanner().nextLine();
					userDAO.changePassword(user.getUserID(), newPassword);
					System.out.println("비밀번호가 변경되었습니다.");
				}
				else
					System.out.println("비밀번호가 일치하지 않습니다.");
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
					userDAO.deleteAccount(user.getUserID());
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
}
