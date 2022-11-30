/*jshint esversion: 6 */

import {getMap} from './Map.js';
import {getPlayer} from './Player.js';

const canvas = document.getElementById('game');
const ctx = canvas.getContext('2d');
let stdPixel = 1;

export const main = async (mapNo,characterId)=>{
    setCanvasSize(canvas);
    
    const player = await getPlayer(characterId);
    const character = player.getCharacter();
    const map = await getMap(mapNo);
    character.setMap(map);

    stdPixel = canvas.height/map.mapInfo.height;
    const bases = map.bases.map(b=>drawPixel('black')(b));
    const hurdles = map.hurdles.map(h=>drawPixel('red')(h));
    const goal = drawPixel('blue')({x:map.mapInfo.goalx,y:map.mapInfo.goaly,width:1,height:2});

    let drawLoop = setInterval(draw({bases,hurdles,character,goal,map}), 1000/60);
    let moveLoop = setInterval(character.move(), 1000/60);

    const keydownSetting = [{key:'ArrowLeft',action:()=>character.moveLeft()},
                        {key:'ArrowRight',action:()=>character.moveRight()},
                        {key:' ',action:()=>character.jump()},
                        {key:'p',action:()=>character.print()},
                        {key:'b',action:()=>character.bounce(0)}];
    const keyupSetting = [{key:'ArrowLeft',action:()=>character.stopLeft()},
                        {key:'ArrowRight',action:()=>character.stopRight()}];

    window.addEventListener('keydown',e=>{
        keydownSetting.forEach(k=>k.key===e.key?k.action():null);
    });
    window.addEventListener('keyup',e=>{
        keyupSetting.forEach(k=>k.key===e.key?k.action():null);
    });
}

const draw = ({bases,hurdles,character,goal,map})=>()=>{
    ctx.clearRect(0,0,canvas.width,canvas.height);
    let startPositon = 0;
    if(character.x*stdPixel>canvas.width*0.3)
        startPositon = character.x*stdPixel-canvas.width*0.3;
    if(character.x*stdPixel>map.mapInfo.width*stdPixel-canvas.width*0.7)
        startPositon = map.mapInfo.width*stdPixel-canvas.width;
    bases.forEach(b=>b(startPositon));
    hurdles.forEach(h=>h(startPositon));
    drawPixel('green')(character)(startPositon);
    for(let i=0;i<character.life;i++)
        drawPixel('red')({x:1+i*4,y:1,width:3,height:3})(0);
    goal(startPositon);
}

const setCanvasSize = (canvas)=>{
    canvas.width = window.innerWidth-20;
    canvas.height = window.innerHeight
                    -document.getElementsByTagName('header')[0].clientHeight
                    -document.getElementsByTagName('footer')[0].clientHeight;
}

const drawPixel = color=>item=>startPositon=>{
    ctx.fillStyle = color;
    ctx.fillRect(item.x*stdPixel-startPositon,item.y*stdPixel,item.width*stdPixel,item.height*stdPixel);
}