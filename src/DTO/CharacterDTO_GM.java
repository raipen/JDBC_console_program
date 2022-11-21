package DTO;

public class CharacterDTO_GM extends CharacterDTO
{
	private String userID;

	public CharacterDTO_GM()
	{
		super();
	}

	public CharacterDTO_GM(String userID, String characterID, String characterName,
			int lv, int exp, String skillID)
	{
		super(characterID, characterName, lv, exp, skillID);
		this.userID = userID;
	}

	public CharacterDTO_GM(CharacterDTO_GM c)
	{
		this(c.getUserID(), c.getCharacterID(), c.getCharacterName(), c.getLv(), c.getExp(), c.getSkillID());
	}

	public String getUserID()
	{
		return userID;
	}

	public void setUserID(String userID)
	{
		this.userID = userID;
	}
}
