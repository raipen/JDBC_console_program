package DTO;

public class RecordDTO {

	private String characterid;
    private String mapno;
    private int recordno;
    private int cleartime;
    private String charactername;
    private String mapname;
    
   
	public RecordDTO() {}
    
    public RecordDTO(String characterid, String mapno, int cleartime){
        this.characterid = characterid;
        this.mapno = mapno;
        this.cleartime = cleartime;
    }

    public RecordDTO(String Characterid, String mapno,int recordno,int cleartime,String charactername,String mapname) {
        this.characterid=Characterid;
        this.mapno=mapno;
        this.recordno=recordno;
        this.cleartime=cleartime;
        this.charactername=charactername;
        this.mapname=mapname;
    }

	
    public String getCharacterid() {
    	return characterid;
    }
    
    public void setCharacterid(String characterid) {
    	this.characterid = characterid;
    }
    
    public String getMapno() {
    	return mapno;
    }
    
    public void setMapno(String mapno) {
    	this.mapno = mapno;
    }
    
    public int getRecordno() {
    	return recordno;
    }
    
    public void setRecordno(int recordno) {
    	this.recordno = recordno;
    }
    
    public int getCleartime() {
    	return cleartime;
    }
    
    public void setCleartime(int cleartime) {
    	this.cleartime = cleartime;
    }
    public String getCharactername() {
    	return charactername;
    }
    
    public void setCharactername(String charactername) {
    	this.charactername = charactername;
    }

    public String getMapname() {
		return mapname;
	}

	public void setMapname(String mapname) {
		this.mapname = mapname;
	}

    public void printrecord(){
    	System.out.printf("%10s:%10s: %10d\n",charactername,mapname,cleartime);
    }
    
}