import java.util.Scanner;

public class Main extends Page {
    
    public Main() {
    	addMenu(new Menu("로그인") {
    		public boolean execute() {
    			System.out.print("ID(Enter QUIT to return to the main menu): ");
    			Scanner scanner = Stdin.getScanner();
				String id = scanner.nextLine();
				if (id.equals("QUIT")) {
					return true;
				}
				System.out.print("PW: ");
				String pw = scanner.nextLine();
				UserDTO user = UserDAO.login(id, pw);
				if (user != null) {
    				new Login(user).start();
				} else {
					System.out.println("로그인 실패");
				}
    			return true;
    		};
    	});
    	
    	addMenu(new Menu("회원가입") {
    		public boolean execute() {
    			System.out.println("회원가입 기능 실행");
    			return true;
    		};
    	});
    	
    	addMenu(new Menu("종료") {
    		public boolean execute() {
    			System.out.println("게임 종료");
    			return false;
    		};
    	});
    }
}