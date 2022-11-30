import Map from './Map.js';
import { get_cookie } from './utils.js';

const canvas = document.getElementById('game');
const ctx = canvas.getContext('2d');
let stdPixel = 1;

export const main = (mapNo)=>{
    setCanvasSize(canvas);

    //const map = new Map(mapNo);
    const map = {mapNo:"00001",
        mapInfo:{mapName:"테스트맵",backgroundIMG:"",width:150,height:35,goalx:149,goaly:32,difficulty:1},
        bases:[{x:0,y:34,width:150,height:1},{x:30,y:30,width:5,height:1}],
        hurdles:[]};
    stdPixel = canvas.height/map.mapInfo.height;

    //cookie에 있는 chracterNo를 가져와서 캐릭터를 생성한다.
    //const player = new Player(get_cookie('characterNo'));
    const player = {characterNo:"00001",position:0};

    let gameLoop = setInterval(draw(map)(player), 1000/60);
}

const draw = map=>player=>()=>{
    ctx.clearRect(0,0,canvas.width,canvas.height);
    map.bases.forEach(b=>drawPixel('black',b,player.position));
}

const setCanvasSize = (canvas)=>{
    canvas.width = window.innerWidth-20;
    canvas.height = window.innerHeight
                    -document.getElementsByTagName('header')[0].clientHeight
                    -document.getElementsByTagName('footer')[0].clientHeight;
}

const drawPixel = (color,item,startPositon)=>{
    ctx.fillStyle = color;
    ctx.fillRect(item.x*stdPixel-startPositon,item.y*stdPixel,item.width*stdPixel,item.height*stdPixel);
}