
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
export default (character,itemId) => {
    console.log(itemId);
    return items[itemId](character);
}