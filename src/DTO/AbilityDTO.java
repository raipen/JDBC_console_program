package DTO;

public class AbilityDTO
{
	private int speed;
	private int life;
	private int coolDown;
	
	public AbilityDTO() {};
	
	public AbilityDTO(int speed, int life, int coolDown)
	{
		this.speed = speed;
		this.life = life;
		this.coolDown = coolDown;
	}
	
	public AbilityDTO(AbilityDTO a)
	{
		this(a.speed, a.life, a.coolDown);
	}

	public int getSpeed()
	{
		return speed;
	}

	public void setSpeed(int speed)
	{
		this.speed = speed;
	}

	public int getLife()
	{
		return life;
	}

	public void setLife(int life)
	{
		this.life = life;
	}

	public int getCoolDown()
	{
		return coolDown;
	}

	public void setCoolDown(int coolDown)
	{
		this.coolDown = coolDown;
	}

	
}
