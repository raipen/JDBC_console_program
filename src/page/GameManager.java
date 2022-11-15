package page;

import DTO.UserDTO;
import util.*;

public class GameManager extends Page{
    public GameManager() {
        System.out.println("관리자님 환영합니다.");
        
        addMenu(new Menu("회원 관리") {
            public void execute() {
                
            };
        });
        
    }
}