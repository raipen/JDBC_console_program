/*jshint esversion: 6 */
import { ajax } from "./utils.js";

const items = {
    lifeUp(character){character.life++},
    speedUp(character){character.maxSpeed+=3},
    jumpUp20(character){character.jumpPower*=1.2},
    jumpUp50(character){character.jumpPower*=1.5},
    coolDown(character){
        character.cooldown+=10;
        character.cooltime*=0.9},
    guard(character){character.shild++}
}
export default (player,character,itemId) => {
    //player.items에 itemId가 일치하는 아이템이 있으면 itemCount를 1 감소시키고 setItem.jsp로 전송
    //player.items에 itemId가 일치하는 아이템이 없거나 itemCount가 0이면 return
    //items[itemId](character) 실행
    console.log(itemId);
    const item = player.items.find(item => item.itemId == itemId);
    if(!item || item.itemCount == 0) return c=>{};
    item.itemCount--;
    const url = '../apis/useItem.jsp';
    const data = {id:player.userId,itemId:itemId};
    ajax(url,data);
    items[itemId](character);
}