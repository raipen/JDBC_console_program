package DTO;

public class HurdleDTO {
	private String mapNo;
	private String hurdleId;
	private int positionX;
	private int positionY;
	private int objSizeX;
	private int objSizeY;
	
	public HurdleDTO() {}
    
    public HurdleDTO(String mapNo,String hurdleId,int positionX,int positionY,int objSizeX,int objSizeY) {
        this.mapNo=mapNo;
        this.hurdleId=hurdleId;
        this.positionX=positionX;
        this.positionY=positionY;
        this.objSizeX=objSizeX;
        this.objSizeY=objSizeY;
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
	
}
