package DTO;

public class AbilityDTO {
    private String characterID;
    private int speed;
    private int life;
    private int coolDown;
    
    public AbilityDTO() {}

	public AbilityDTO(int speed, int life, int coolDown)
	{
		this.speed = speed;
		this.life = life;
		this.coolDown = coolDown;
	}
    
    public AbilityDTO(String characterID,int speed,int life,int cooldown) {
        this.characterID = characterID;
        this.speed=speed;
        this.life=life;
        this.coolDown=cooldown;
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

	public int getCoolDown() {
		return coolDown;
	}

	public void setCoolDown(int cooldown) {
		this.coolDown = cooldown;
	}

	
}
