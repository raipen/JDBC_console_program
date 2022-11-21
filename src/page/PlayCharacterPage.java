package page;

import DTO.*;
import util.*;
import DAO.*;
import java.util.List;

public class PlayCharacterPage extends Page {
    CharacterDTO character;
    CharacterDAO characterDAO = CharacterDAO.getInstance();
    MapDAO mapDAO = MapDAO.getInstance();
    
    public PlayCharacterPage(CharacterDTO character) {
        this.character = character;
        System.out.println(character.getCharacterName() + "님 환영합니다.");
        System.out.println(character);
        
        //맵 리스트 받아와서 각 맵 플레이 메뉴 추가하기
        List<MapDTO> mapList = mapDAO.getMapList();
        for(MapDTO map : mapList) {
            addMenu(new Menu(map.getMapname()){
                public void execute() {
                    //new PlayMapPage(character, map).show();
                }
            });
        }




        addMenu(new Menu("뒤로가기",true) {
            public void execute() {
                System.out.println("뒤로가기");
            };
        });
    }
}
