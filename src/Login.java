
public class Login extends Page {
	UserDTO user;
	public Login(UserDTO user) {
		this.user = user;
		System.out.println(user.getId() + "님 환영합니다.");
		addMenu(new Menu("캐릭터 선택하기") {
			public boolean execute() {
				System.out.println("로그인 기능 실행");
				return true;
			};
		});
		addMenu(new Menu("회원가입") {
			public boolean execute() {
				System.out.println("회원가입 기능 실행");
				return true;
			};
		});
		addMenu(new Menu("로그아웃") {
			public boolean execute() {
				System.out.println("로그아웃");
				return false;
			};
		});
	}
}
