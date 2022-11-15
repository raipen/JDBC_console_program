package page;

import java.util.Scanner;

import DAO.UserDAO;
import DTO.UserDTO;
import util.*;

public class Main extends Page
{

	UserDAO userDAO = UserDAO.getInstance();

	public Main()
	{
		addMenu(new Menu("로그인")
		{
			public void execute()
			{
				login();
			};
		});

		addMenu(new Menu("회원가입")
		{
			public void execute()
			{
				signUp();
			};
		});

		addMenu(new Menu("종료", true)
		{
			public void execute()
			{
				System.out.println("게임 종료");
			};
		});
	}

	private void login()
	{
		System.out.print("ID(Enter QUIT to return to the main menu): ");
		Scanner scanner = Stdin.getScanner();
		String id = scanner.nextLine();
		if (id.equals("QUIT"))
		{
			return;
		}
		System.out.print("PW: ");
		String pw = scanner.nextLine();
		UserDTO user = userDAO.login(id, pw);
		if (user == null)
		{
			System.out.println("로그인 실패");
		}
		else if (user.getUserID().startsWith("gamemanager"))
		{
			new GameManager().start();
		}
		else
		{
			new Login(user).start();
		}
	}

	private void signUp()
	{
		Scanner scanner = Stdin.getScanner();
		String id;
		System.out.print("ID(메인 메뉴로 나가시려면 \"QUIT\"를 입력해주세요): ");
		id = scanner.nextLine();
		if (id.equals("QUIT"))
		{
			return;
		}
		while (userDAO.isExist(id))
		{
			System.out.println("이미 존재하는 ID입니다.");
			System.out.print("ID(메인 메뉴로 나가시려면 \"QUIT\"를 입력해주세요): ");
			id = scanner.nextLine();
			if (id.equals("QUIT"))
			{
				return;
			}
		}
		System.out.print("PW: ");
		String pw = scanner.nextLine();
		boolean signUpSuccess = userDAO.signUp(id, pw);
		if (signUpSuccess) System.out.println("회원가입 성공");
		else System.out.println("회원가입 실패");
	}
}