package DTO;

public class MapDTO {
	int mapno;
	String mapname;
	String backgroundimg;
	int mapsizex;
	int mapsizey;
	int goalx;
	int goaly;
	int difficulty;
	
	public MapDTO() {}
    public MapDTO(int mapno, String mapname, String backgroundimg, int mapsizex, int mapsizey, int goalx, int goaly, int difficulty) {
		this.mapno = mapno;
		this.mapname = mapname;
		this.backgroundimg = backgroundimg;
		this.mapsizex = mapsizex;
		this.mapsizey = mapsizey;
		this.goalx = goalx;
		this.goaly = goaly;
		this.difficulty = difficulty;
	}
	
	public int getMapno() {
		return mapno;
	}
	public void setMapno(int mapno) {
		this.mapno = mapno;
	}
	public String getMapname() {
		return mapname;
	}
	public void setMapname(String mapname) {
		this.mapname = mapname;
	}
	public String getBackgroundimg() {
		return backgroundimg;
	}
	public void setBackgroundimg(String backgroundimg) {
		this.backgroundimg = backgroundimg;
	}
	public int getMapsizex() {
		return mapsizex;
	}
	public void setMapsizex(int mapsizex) {
		this.mapsizex = mapsizex;
	}
	public int getMapsizey() {
		return mapsizey;
	}
	public void setMapsizey(int mapsizey) {
		this.mapsizey = mapsizey;
	}
	public int getGoalx() {
		return goalx;
	}
	public void setGoalx(int goalx) {
		this.goalx = goalx;
	}
	public int getGoaly() {
		return goaly;
	}
	public void setGoaly(int goaly) {
		this.goaly = goaly;
	}
	public int getDifficulty() {
		return difficulty;
	}
	public void setDifficulty(int difficulty) {
		this.difficulty = difficulty;
	}
}
