export default {smaller(character,duration){
    character.width = character.width/2;
    character.height = character.height/2;
    setTimeout(()=>{
        character.width = character.width*2;
        character.height = character.height*2;
    },duration*1000);
},
 timestop(character){

},
 dash(character){
    console.log("dash");
    character.maxSpeed *= 5;
    if(character.left)
        character.xSpeed -= character.maxSpeed;
    else
        character.xSpeed += character.maxSpeed;
    setTimeout(()=>{
        character.maxSpeed /= 5;
    },100);
},
 doublejump(character){
    console.log("doublejump");
    character.ySpeed = -character.jumpPower;
    let result = character.safeMove(character.getRect())(0,character.ySpeed);
    character.y = result.y;
},
 teleport(character){

},
 darksight(character){

},
 heal(character){

},
 shield(character){

},
 zombie(character){

}}