package DTO;

public class CharacterDTO {
    private String characterID;
    private String characterName;
    private int lv;
    private int exp;
    private String skillID;
    private String userID;
    
    public CharacterDTO() {}
    
    public CharacterDTO(String characterID, String characterName, int lv, int exp, String skillID) {
        this.characterID = characterID;
        this.characterName = characterName;
        this.lv = lv;
        this.exp = exp;
        this.skillID = skillID;
    }
    
    public CharacterDTO(String userID, String characterID, String characterName, int lv, int exp, String skillID){
		this(characterID, characterName, lv, exp, skillID);
		this.userID = userID;
	}

    public CharacterDTO copy() {
        return new CharacterDTO(userID, characterID, characterName, lv, exp, skillID);
    }

    public String getCharacterID() {
        return characterID;
    }

    public void setCharacterID(String characterID) {
        this.characterID = characterID;
    }

    public String getCharacterName() {
        return characterName;
    }

    public void setCharacterName(String characterName) {
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

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String toString(){
        return ": "+characterName  ;
    }
    public void printinfo(){
       System.out.printf("\n닉네임:%10s lv:%3d exp:%4d\n",characterName,lv,exp);
    }
}