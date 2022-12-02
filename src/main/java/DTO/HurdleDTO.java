package DTO;

public class HurdleDTO {
	private String mapNo;
	private String hurdleId;
	private int positionX;
	private int positionY;
	private int objSizeX;
	private int objSizeY;
	private int damage;
	private String objImg;

	public HurdleDTO() {}
    
    public HurdleDTO(String mapNo,String hurdleId,int positionX,int positionY,int objSizeX,int objSizeY,int damage,String objImg) {
        this.mapNo=mapNo;
        this.hurdleId=hurdleId;
        this.positionX=positionX;
        this.positionY=positionY;
        this.objSizeX=objSizeX;
        this.objSizeY=objSizeY;
        this.damage=damage;
		this.objImg=objImg;
    }
    
    public int getDamage() {
    	return damage;
    }
    
    public void setDamage(int damage) {
    	this.damage = damage;
    }
    
	public String getMapNo() {
		return mapNo;
	}
	public void setMapNo(String mapNo) {
		this.mapNo = mapNo;
	}
	public String getHurdleId() {
		return hurdleId;
	}
	public void setHurdleId(String hurdleId) {
		this.hurdleId = hurdleId;
	}
	public int getPositionX() {
		return positionX;
	}
	public void setPositionX(int positionX) {
		this.positionX = positionX;
	}
	public int getPositionY() {
		return positionY;
	}
	public void setPositionY(int positionY) {
		this.positionY = positionY;
	}
	public int getObjSizeX() {
		return objSizeX;
	}
	public void setObjSizeX(int objSizeX) {
		this.objSizeX = objSizeX;
	}
	public int getObjSizeY() {
		return objSizeY;
	}
	public void setObjSizeY(int objSizeY) {
		this.objSizeY = objSizeY;
	}
	public String getObjImg() {
		return objImg;
	}
	public void setObjImg(String objImg) {
		this.objImg = objImg;
	}
}
