import Map from './Map.js';

export const main = (mapNo)=>{
    const canvas = document.getElementById('game');
    setCanvasSize(canvas);
    const ctx = canvas.getContext('2d');

    //const map = new Map(mapNo);
    const map = {mapNo:"00001",
        mapInfo:{mapName:"테스트맵",backgroundIMG:"",width:150,height:35,goalx:149,goaly:32,difficulty:1},
        bases:[{x:0,y:34,width:150,height:1},{x:30,y:30,width:5,height:1}],
        hurdles:[]};
    const stdPixel = canvas.height/map.mapInfo.height;

    let position = 0;
    const step = ()=>{
        ctx.clearRect(0,0,canvas.width,canvas.height);
        map.bases.forEach(b=>drawPixel(ctx,stdPixel,'black',b,position));
    }
    let gameLoop = setInterval(step, 1000/60);
}

const setCanvasSize = (canvas)=>{
    canvas.width = window.innerWidth-20;
    canvas.height = window.innerHeight
                    -document.getElementsByTagName('header')[0].clientHeight
                    -document.getElementsByTagName('footer')[0].clientHeight;
}

const drawPixel = (ctx,stdPixel,color,item,startPositon)=>{
    ctx.fillStyle = color;
    ctx.fillRect(item.x*stdPixel-startPositon,item.y*stdPixel,item.width*stdPixel,item.height*stdPixel);
}