public class Main extends Page {
    
    public Main() {
    	menuDescription = new String[] {"로그인", "회원가입", "종료"};
        menu = new Menu[menuDescription.length-1];
        menu[0] = () -> {
            System.out.println("로그인");
        };
        menu[1] = () -> {
            System.out.println("회원가입");
        };
    }
}
