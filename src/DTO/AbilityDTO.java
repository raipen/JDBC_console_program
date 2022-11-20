package DTO;

public class AbilityDTO {
    private String characterID;
    private int speed;
    private int life;
    private int cooldown;
    private String Charactername;
    private String Skillname;
    
    public AbilityDTO() {}
    
    public AbilityDTO(String characterID,int speed,int life,int cooldown) {
        this.characterID = characterID;
        this.speed=speed;
        this.life=life;
        this.cooldown=cooldown;
    }
    
    public String getCharacterID() {
		return characterID;
	}

	public void setCharacterID(String characterID) {
		this.characterID = characterID;
	}

	public int getSpeed() {
		return speed;
	}

	public void setSpeed(int speed) {
		this.speed = speed;
	}

	public int getLife() {
		return life;
	}

	public void setLife(int life) {
		this.life = life;
	}

	public int getCooldown() {
		return cooldown;
	}

	public void setCooldown(int cooldown) {
		this.cooldown = cooldown;
	}

	
}