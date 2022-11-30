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

    stdPixel = canvas.height/map.mapInfo.height;
    const bases = map.bases.map(b=>drawPixel('black')(b));
    const hurdles = map.hurdles.map(h=>drawPixel('red')(h));

    let drawLoop = setInterval(draw(bases)(hurdles)(character), 1000/60);
    let moveLoop = setInterval(character.move(), 1000/60, map.bases, map.hurdles);

    const keydownSetting = [{key:'ArrowLeft',action:()=>character.moveLeft()},
                        {key:'ArrowRight',action:()=>character.moveRight()},
                        {key:' ',action:()=>{}}];
    const keyupSetting = [{key:'ArrowLeft',action:()=>character.stopLeft()},
                        {key:'ArrowRight',action:()=>character.stopRight()}];

    window.addEventListener('keydown',e=>{
        keydownSetting.forEach(k=>k.key===e.key?k.action():null);
    });
    window.addEventListener('keyup',e=>{
        keyupSetting.forEach(k=>k.key===e.key?k.action():null);
    });
}

const draw = bases=>hurdles=>character=>()=>{
    ctx.clearRect(0,0,canvas.width,canvas.height);
    bases.forEach(b=>b(0));
    hurdles.forEach(h=>h(0));
    drawPixel('green')(character)(0);
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