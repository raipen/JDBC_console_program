package DTO;

public class BaseDTO {
	private String mapNo;
	private String baseId;
	private int positionX;
	private int positionY;
	private int objSizeX;
	private int objSizeY;
	
	public BaseDTO() {}
    
    public BaseDTO(String mapNo,String baseId,int positionX,int positionY,int objSizeX,int objSizeY) {
        this.mapNo=mapNo;
        this.baseId=baseId;
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
	public String getBaseId() {
		return baseId;
	}
	public void setBaseId(String baseId) {
		this.baseId = baseId;
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
