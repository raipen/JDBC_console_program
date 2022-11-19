package DTO;

public class CharacterDTO {
    private String characterID;
    private String characterName;
    private int lv;
    private int exp;
    private String skillID;
    
    public CharacterDTO() {}
    
    public CharacterDTO(String characterID, String characterName, int lv, int exp, String skillID) {
        this.characterID = characterID;
        this.characterName = characterName;
        this.lv = lv;
        this.exp = exp;
        this.skillID = skillID;
    }

    public String getCharacterID() {
        return characterID;
    }

    public void setCharacterID(String characterID) {
        this.characterID = characterID;
    }

    public String getcharacterName() {
        return characterName;
    }

    public void setcharacterName(String characterName) {
        this.characterName = characterName;
    }

    public int getLv() {
        return lv;
    }

    public void setLv(int lv) {
        this.lv = lv;
    }

    public int getExp() {
        return exp;
    }

    public void setExp(int exp) {
        this.exp = exp;
    }

    public String getSkillID() {
        return skillID;
    }

    public void setSkillID(String skillID) {
        this.skillID = skillID;
    }
    public String toString(){
        return ": "+characterName  ;
    }
}