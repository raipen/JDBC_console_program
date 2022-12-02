
const items = [
    character=>character.maxSpeed++,
    character=>character.maxSpeed+=2,
    character=>character.maxSpeed+=3,
    character=>character.cooltime=character.cooltime-3*60>0?character.cooltime-3*60:0,
    character=>character.cooltime=character.cooltime-5*60>0?character.cooltime-5*60:0,
    character=>character.cooltime=character.cooltime-7*60>0?character.cooltime-7*60:0,
    character=>character.jumpPower*=1.2,
    character=>character.jumpPower*=1.5,
    character=>character.life++,
    character=>character.shild++,
]
export default (itemIndex,character) => {
    return items[itemIndex](character);
}