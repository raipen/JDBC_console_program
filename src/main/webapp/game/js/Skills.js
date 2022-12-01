export default {smaller(character){

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