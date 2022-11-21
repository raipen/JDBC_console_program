package page;

import DTO.*;
import util.*;
import DAO.*;
import java.util.List;
import java.util.Random;

public class PlayCharacterPage extends Page {
    CharacterDTO character;
    CharacterDAO characterDAO = CharacterDAO.getInstance();
    MapDAO mapDAO = MapDAO.getInstance();
    
    public PlayCharacterPage(CharacterDTO character) {
        this.character = character;
        System.out.println(character.getCharacterName() + "님 환영합니다.");
        character.printinfo();
        
        List<MapDTO> mapList = mapDAO.getMapList();
        for(MapDTO map : mapList) {
            addMenu(new Menu(map.getMapname()){
                public void execute() {
                    System.out.println("게임 시작");
                    System.out.println("맵 이름:" + map.getMapname());
                    System.out.println("발판들");
                    List<String> baseList = mapDAO.getBaseOfMap(map.getMapno());
                    System.out.println("총 " + baseList.size() + " 개");
                    for (String r : baseList)
                        System.out.println(r);

                    System.out.println("장애물들");
                    List<String> hurdleList = mapDAO.getHurdleOfMap(map.getMapno());
                    System.out.println("총 " + hurdleList.size() + " 개");
                    for (String r : hurdleList)
                        System.out.println(r);

                    System.out.println("게임 종료");
                    int exp = new Random().nextInt(100);
                    if(character.getExp() + exp>100){
                        character.setLv(character.getLv()+1);
                        character.setExp(character.getExp()+exp-100);
                    }
                    else{
                        character.setExp(character.getExp()+exp);
                    }
                    characterDAO.updateCharacter(character);
                    System.out.println("경험치 " + exp + " 획득");
                    character.printinfo();
                }
            });
        }

        addMenu(new Menu("캐릭터 랭킹보기"){
            public void execute() {
                List<String> ranks = RecordDAO.getInstance().getCharacterRankList(character);
                System.out.println(character.getCharacterName() + "의 클리어 랭킹");
                for(String rank : ranks) {
                    System.out.println(rank);
                }
            }
        });

        addMenu(new Menu("어빌리티 강화하기"){
            public void execute() {
                int point = character.getLv()*3 - AbilityDAO.getInstance().getTotalAbility(character);
                AbilityDTO ability = AbilityDAO.getInstance().getAbility(character);
                System.out.println("현재 어빌리티");
                System.out.println(ability);
                System.out.println("남은 강화 포인트 : " + point);
                while(point > 0) {
                    System.out.println("1. 스피드");
                    System.out.println("2. 생명력");
                    System.out.println("3. 쿨타임");
                    System.out.println("4. 취소");
                    System.out.println("어떤 어빌리티를 강화하시겠습니까?");
                    int choice = Stdin.selectInt(1, 4);
                    if(choice == 4) break;
                    System.out.println("얼마나 강화하시겠습니까?");
                    int amount = Stdin.selectInt(1, point);
                    AbilityDAO.getInstance().updateAbility(ability, choice, amount);
                    point -= amount;
                    System.out.println("남은 강화 포인트 : " + point);
                }
                System.out.println("강화가 종료되었습니다.");
            }
        });


        addMenu(new Menu("뒤로가기",true) {
            public void execute() {
                System.out.println("뒤로가기");
            };
        });
    }
}
