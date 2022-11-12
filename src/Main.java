import java.util.Scanner;

public class Main extends Page {

	public Main() {
		addMenu(new Menu("로그인") {
			public void execute() {
				login();
			};
		});

		addMenu(new Menu("회원가입") {
			public void execute() {
				signUp();
			};
		});

		addMenu(new Menu("종료", true) {
			public void execute() {
				System.out.println("게임 종료");
			};
		});
	}

	private void login() {
		System.out.print("ID(Enter QUIT to return to the main menu): ");
		Scanner scanner = Stdin.getScanner();
		String id = scanner.nextLine();
		if (id.equals("QUIT")) {
			return;
		}
		System.out.print("PW: ");
		String pw = scanner.nextLine();
		UserDTO user = UserDAO.login(id, pw);
		if (user != null) {
			new Login(user).start();
		} else {
			System.out.println("로그인 실패");
		}
	}

	private void signUp() {
		Scanner scanner = Stdin.getScanner();
		String id = scanner.nextLine();
		do {
			System.out.print("ID(Enter QUIT to return to the main menu): ");
			if (id.equals("QUIT")) {
				return;
			}
		} while (UserDAO.isExist(id));
		System.out.print("PW: ");
		String pw = scanner.nextLine();
		UserDTO user = UserDAO.signUp(id, pw);
		if (user != null) {
			new Login(user).start();
		} else {
			System.out.println("회원가입 실패");
		}
	}
}