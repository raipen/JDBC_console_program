package DTO;

public class SkillDTO {
	String skillID;
	String skillName;
	String skillImg;
	int duration;
	int cooltime;
	
    public SkillDTO() {}
	
    public SkillDTO(String skillid, String skillname,String skillimg,int duration,int cooltime) {
        this.skillID=skillid;
        this.skillName=skillname;
        this.skillImg=skillimg;
        this.duration=duration;
        this.cooltime=cooltime;
    }
    
	public String getSkillID() {
		return skillID;
	}
	public void setSkillID(String skillID) {
		this.skillID = skillID;
	}
	public String getSkillName() {
		return skillName;
	}
	public void setSkillName(String skillName) {
		this.skillName = skillName;
	}
	public String getSkillImg() {
		return skillImg;
	}
	public void setSkillImg(String skillImg) {
		this.skillImg = skillImg;
	}
	public int getDuration() {
		return duration;
	}
	public void setDuration(int duration) {
		this.duration = duration;
	}
	public int getCooltime() {
		return cooltime;
	}
	public void setCooltime(int cooltime) {
		this.cooltime = cooltime;
	}
	public void printskill(){
	       System.out.printf("%s30\n",skillName);
	    }

}
