export default {smaller(character,duration){
    character.width = character.width/2;
    character.height = character.height/2;
    setTimeout(()=>{
        character.height = character.height*2;
        let result = character.safeMove(character.getRect())(0,1);
        character.y = result.y;
        character.width = character.width*2;
        result = character.safeMove(character.getRect())(1,0);
        character.x = result.x;
    },duration*1000);
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
 lowgravity(character,duration){
    console.log("lowgravity");
    character.gravity /= 6;
    character.jumpPower /= 2.3;
    setTimeout(()=>{
        character.gravity *= 6;
        character.jumpPower *= 2.3;
    },duration*1000);
},
 darksight(character,duration){
    console.log("darksight");
    character.color = "RGBA(0,255,0,0.5)";
    character.invincible = true;
    setTimeout(()=>{
        character.color = "green";
        character.invincible = false;
    },duration*1000);
},
 heal(character){
    character.life ++;
},
 shield(character,duration){
    console.log("shield");
    character.shield++;
    character.shieldTimeout = setTimeout(()=>{
        character.shield--;
    },duration*1000);

}}