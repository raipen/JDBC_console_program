package DTO;

public class UserDTO {
    private String userID;
    private String password;
    
    public UserDTO() {}
    
    public UserDTO(String userID, String password) {
        this.userID = userID;
        this.password = password;
    }

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

    
}