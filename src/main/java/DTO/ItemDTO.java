package DTO;

public class ItemDTO {
    private String id;
    private String itemID;
    private String itemName;
    private String itemImg;
    private int itemCount;

    public ItemDTO() {}

    public ItemDTO(String userID, String itemID, int itemCount) {
        this.id = userID;
        this.itemID = itemID;
        this.itemCount = itemCount;
    }

    public ItemDTO(String userID, String itemID, String itemCount) {
        this.id = userID;
        this.itemID = itemID;
        this.itemCount = Integer.parseInt(itemCount);
    }

    public ItemDTO(String itemID, String itemName, String itemImg, int itemCount) {
        this.itemID = itemID;
        this.itemName = itemName;
        this.itemImg = itemImg;
        this.itemCount = itemCount;
    }

    public ItemDTO(String itemID, String itemName, String itemImg,  String itemCount) {
        this.itemID = itemID;
        this.itemName = itemName;
        this.itemImg = itemImg;
        this.itemCount = Integer.parseInt(itemCount);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getItemID() {
        return itemID;
    }

    public void setItemID(String itemID) {
        this.itemID = itemID;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getItemImg() {
        return itemImg;
    }

    public void setItemImg(String itemImg) {
        this.itemImg = itemImg;
    }

    public int getItemCount() {
        return itemCount;
    }

    public void setItemCount(String itemCount) {
        this.itemCount = Integer.parseInt(itemCount);
    }

    public void setItemCount(int itemCount) {
        this.itemCount = itemCount;
    }

    public String toString(){
        return itemName + ": " + itemCount +"개";
    }
}