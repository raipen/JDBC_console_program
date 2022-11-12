
public class Login extends Page {
	public Login() {
		Menu[] menu = new Menu[3];
		menu[0] = new Menu("로그인") {
			public boolean execute() {
				System.out.println("로그인 기능 실행");
				return true;
			};
		};
		menu[1] = new Menu("회원가입") {
			public boolean execute() {
				System.out.println("회원가입 기능 실행");
				return true;
			};
		};
		menu[2] = new Menu("종료") {
			public boolean execute() {
				System.out.println("게임 종료");
				return false;
			};
		};

		this.setMenu(menu);
	}
}
