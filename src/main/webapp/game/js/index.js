/*jshint esversion: 6 */
import {getMap} from './Map.js';
import {getPlayer} from './Player.js';
import {sleep,isCollision} from './utils.js';
import Skills from './Skills.js';
import useItem from './useItem.js';

const canvasName=['game','skill','item','status'];
let canvas={};
let ctx={};
canvasName.forEach(name=>{
    canvas[name] = document.getElementById(name);
    ctx[name] = canvas[name].getContext('2d');
});
const modal = document.getElementById('modal');
const spacebar = document.getElementById('jump');
const left = document.getElementById('left');
const right = document.getElementById('right');
const up = document.getElementById('up');
const itemKeySetting = [{key: 'q',itemId:"speedUp"},
                        {key: 'w',itemId:"jumpUp20"},
                        {key: 'e',itemId:"jumpUp50"},
                        {key: 'a',itemId:"coolDown"},
                        {key: 's',itemId:"guard"},
                        {key: 'd',itemId:"lifeUp"}];
let stdPixel = 1;

export const main = async (mapNo,characterId)=>{
    setCanvasSize();
    window.addEventListener('resize',setCanvasSize);

    const player = await getPlayer(characterId);
    const character = player.getCharacter();
    const map = await getMap(mapNo);
    character.setMap(map);

    stdPixel = canvas.game.height/map.mapInfo.height;
    const bases = map.bases.map(b=>drawPixel(b.img)(b));
    const hurdles = map.hurdles.map(h=>drawPixel(h.img)(h));
    const goal = {x:map.mapInfo.goalx,y:map.mapInfo.goaly,width:1,height:2};
    const draws = draw({bases,hurdles,character,goal,map,player});
    await countDown(draws,3);
    
    let moveLoop = setInterval(character.move(), 1000/60);
    let playtime = 0;
    let drawLoop = setInterval(()=>{
        playtime++;
        draws(playtime);
        if(character.life<=0){
            clearInterval(drawLoop);
            clearInterval(moveLoop);
            drawResult("fail",playtime);
        }
        if(isCollision(character)(goal)){
            clearInterval(drawLoop);
            clearInterval(moveLoop);
            drawResult("success",playtime);
        }
    }, 1000/60);

    const keydownSetting = [{key:'ArrowLeft',action:()=>{character.moveLeft(); left.classList.add('active');}},
                        {key:'ArrowRight',action:()=>{character.moveRight(); right.classList.add('active');}},
                        {key:'ArrowUp',action:()=>{character.jump(); up.classList.add('active');}},
                        {key:' ',action:()=>{character.jump();spacebar.classList.add('active');}},
                        {key:'p',action:()=>character.print()},
                        {key:'b',action:()=>character.bounce(0)},
                        {key:'Shift',action:()=>{
                            console.log(character.cooltime);
                            if(character.cooltime>0)
                                return;
                            character.cooltime = player.skill.cooltime*60*(100-character.cooldown)/100;
                            if(player.skill.duration===0)
                                Skills[player.character.skillId](character);
                            else
                                Skills[player.character.skillId](character,player.skill.duration);
                        }}];
    const keyupSetting = [{key:'ArrowLeft',action:()=>{character.stopLeft(); left.classList.remove('active');}},
                        {key:'ArrowRight',action:()=>{character.stopRight(); right.classList.remove('active');}},
                        {key:'ArrowUp',action:()=>{up.classList.remove('active');}},
                        {key:' ',action:()=>{spacebar.classList.remove('active');}}];

    window.addEventListener('keydown',e=>{
        keydownSetting.forEach(k=>k.key===e.key?k.action():null);
        itemKeySetting.forEach(k=>k.key===e.key?useItem(player,character,k.itemId):null);
    });
    window.addEventListener('keyup',e=>{
        keyupSetting.forEach(k=>k.key===e.key?k.action():null);
    });

}

const countDown = async (drawGame,num)=>{
    for(let i=num;i>0;i--){
        drawGame(0);
        ctx.game.fillStyle = 'black';
        ctx.game.globalAlpha = 0.5;
        ctx.game.fillRect(0,0,canvas.game.width,canvas.game.height);
        ctx.game.font = '100px Noto Sans KR';
        ctx.game.textAlign = 'center';
        ctx.game.textBaseline = 'middle';
        ctx.game.globalAlpha = 1;
        ctx.game.fillText(i,canvas.game.width/2,canvas.game.height/2);
        await sleep(1000);
    }
}

const convertTime = (frame)=>{
    let min = Math.floor(frame/3600);
    let sec = Math.floor((frame%3600)/60);
    let msec = Math.floor((frame%3600)%60);
    return `${min<10?'0'+min:min}:${sec<10?'0'+sec:sec}:${msec<10?'0'+msec:msec}`;
}

const frameToExp = ({result,frame})=>{
    if(result==='success')
        return Math.floor(990/(frame/60)+10);
    else
        return 5;
}

const draw = (obj)=>(playtime)=>{
    drawGame(obj,playtime);
    drawSkill(obj);
    drawItem(obj);
    //drawStatus(obj);
}

const drawGame = ({bases,hurdles,character,goal,map},playtime)=>{
    ctx.game.clearRect(0,0,canvas.game.width,canvas.game.height);
    let startPositon = 0;
    if(character.x*stdPixel>canvas.game.width*0.3)
        startPositon = character.x*stdPixel-canvas.game.width*0.3;
    if(character.x*stdPixel>map.mapInfo.width*stdPixel-canvas.game.width*0.7)
        startPositon = map.mapInfo.width*stdPixel-canvas.game.width;
    drawPixel('yellow')(character.getShildRect())(startPositon);
    bases.forEach(b=>b(startPositon));
    hurdles.forEach(h=>h(startPositon));
    drawPixel(character.color)(character.getRect())(startPositon);
    for(let i=0;i<character.life;i++)
        drawPixel('red')({x:1+i*4,y:1,width:3,height:3})(0);
    drawPixel('blue')(goal)(startPositon);
    ctx.game.font = '20px Noto Sans KR';
    ctx.game.textAlign = 'right';
    ctx.game.textBaseline = 'top';
    ctx.game.fillText(`Playtime : ${convertTime(playtime)}`,canvas.game.width-10,10);
}

const drawSkill = ({character,player})=>{
    ctx.skill.clearRect(0,0,canvas.skill.width,canvas.skill.height);
    drawImg(ctx.skill,player.skill.img,0,0,canvas.skill.width,canvas.skill.height);

    let maxCooltime = player.skill.cooltime*60*(100-character.cooldown)/100;
    let cooltime = character.cooltime;
    ctx.skill.fillStyle = 'black';
    ctx.skill.globalAlpha = 0.5;
    ctx.skill.fillRect(0,canvas.skill.height*(1-cooltime/maxCooltime) ,canvas.skill.width,canvas.skill.height*cooltime/maxCooltime);
    ctx.skill.globalAlpha = 1;

    drawTextWithStroke(ctx.skill,`shift`,20,0,0);
}

const drawItem = ({player})=>{
    ctx.item.clearRect(0,0,canvas.item.width,canvas.item.height);
    itemKeySetting.forEach((k,i)=>{
        let item = player.items.find(item=>item.itemId===k.itemId);
        if(item){

            drawImg(ctx.item,item.itemImg,50*(i%3),50*Math.floor(i/3),50,50);
            drawTextWithStroke(ctx.item,k.key,20,50*(i%3),50*Math.floor(i/3));
            drawTextWithStroke(ctx.item,item.itemCount,20,50*(i%3)+50,50*Math.floor(i/3)+50,'right','bottom');
        }
    });
}

const drawStatus = ({character,player})=>{
    ctx.status.clearRect(0,0,canvas.status.width,canvas.status.height);
    ctx.status.font = '20px Noto Sans KR';
    ctx.status.textAlign = 'left';
    ctx.status.textBaseline = 'top';
    ctx.status.fillText(`Name : ${player.name}`,10,10);
    ctx.status.fillText(`Character : ${character.characterName}`,10,30);
    ctx.status.fillText(`Level : ${player.level}`,10,50);
    ctx.status.fillText(`Exp : ${player.exp}`,10,70);

    ctx.status.fillText(`Speed : ${character.speed}`,10,110);
    ctx.status.fillText(`Jump : ${character.jump}`,10,130);
    ctx.status.fillText(`Life : ${character.life}`,10,150);

    ctx.status.fillText(`Skill : ${character.skillName}`,10,190);
    ctx.status.fillText(`Cooltime : ${Math.floor(character.cooltime/60)}`,10,210);
    ctx.status.fillText(`Cooldown : ${character.cooldown}%`,10,230);
    ctx.status.fillText(`Duration : ${character.duration}`,10,250);

    ctx.status.fillText(`Item : ${character.itemName}`,10,290);
}

const drawResult = (result,playtime)=>{
    const resultString = {fail:'3/4이상 출석 실패',success:'출석 완료'};
    modal.style.display = 'flex';
    modal.innerHTML = `<div class="modal-content">
                        <div class="modal-header">
                            <div class="modal-title">${resultString[result]}</div>
                        </div>
                        <div class="modal-body">
                            <p>플레이 시간 : ${convertTime(playtime)}</p>
                            <p>exp : ${frameToExp({result,frame:playtime})}</p>
                        </div>
                        <div id="modal-footer">
                            <button id="restart">재수강하기</button>
                            <button id="exit">나가기</button>
                        </div>
                    </div>`;
    const restart = document.getElementById('restart');
    const exit = document.getElementById('exit');
    restart.addEventListener('click',()=>{
        location.reload();
    });
    exit.addEventListener('click',()=>{
        modal.style.display = 'none';
        window.location.href = '../';
    });
}

const setCanvasSize = ()=>{
    let canvasSize = {
        game: { width: window.innerWidth-20, height: window.innerHeight
            -document.getElementsByTagName('header')[0].clientHeight
            -document.getElementsByTagName('footer')[0].clientHeight },
        skill: { width: 50, height: 50 },
        item: { width: 150, height: 100 },
        status: { width: 200, height: 100 }
    };
    canvasName.forEach(name=>{
        canvas[name].width = canvasSize[name].width;
        canvas[name].height = canvasSize[name].height;
    });

}

const drawPixel = color=>item=>startPositon=>{
    ctx.game.fillStyle = color;
    ctx.game.fillRect(item.x*stdPixel-startPositon,item.y*stdPixel,item.width*stdPixel,item.height*stdPixel);
}

const drawTextWithStroke = (ctx,text,fontSize,x,y,align = 'left',baseline = 'top')=>{
    ctx.font = `${fontSize}px Noto Sans KR`;
    ctx.textAlign = align;
    ctx.textBaseline = baseline;
    ctx.strokeStyle = 'white';
    ctx.lineWidth = 2;
    ctx.strokeText(text,x,y);
    ctx.fillStyle = 'black';
    ctx.fillText(text,x,y);
}

const drawImg = (ctx,imgSrc,x,y,width,height)=>{
    let img = new Image();
    img.src = imgSrc;
    ctx.drawImage(img,x,y,width,height);
}