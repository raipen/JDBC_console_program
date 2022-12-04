/*jshint esversion: 6 */
import {getMap} from './Map.js';
import {getPlayer} from './Player.js';
import {sleep,isCollision,ajax} from './utils.js';
import Skills from './Skills.js';
import useItem from './useItem.js';

const canvasName=['game','skill','item','status'];
let canvas={};
let ctx={};
canvasName.forEach(name=>{
    canvas[name] = document.getElementById(name);
    ctx[name] = canvas[name].getContext('2d');
});
const header = document.querySelector('header');
const modal = document.getElementById('modal');
const spacebar = document.getElementById('jump');
const left = document.getElementById('left');
const right = document.getElementById('right');
const up = document.getElementById('up');
const itemsInfo = [ {key: 'q',itemId:"speedUp", acqProbability: 0.2,using:false},
                    {key: 'w',itemId:"jumpUp20", acqProbability: 0.4,using:false},
                    {key: 'e',itemId:"jumpUp50", acqProbability: 0.1,using:false},
                    {key: 'a',itemId:"coolDown", acqProbability: 0.3,using:false},
                    {key: 's',itemId:"guard", acqProbability: 0.5,using:false},
                    {key: 'd',itemId:"lifeUp", acqProbability: 0.1,using:false}];
let stdPixel = 1;

export const main = async (mapNo,characterId)=>{
    setCanvasSize();
    window.addEventListener('resize',setCanvasSize);

    const player = await getPlayer(characterId);
    const character = player.getCharacter();
    const map = await getMap(mapNo);
    character.setMap(map);

    header.innerHTML=`<div id="mapTitle">${map.mapInfo.mapName}</div><div id="back"> 맵 선택으로 돌아가기 </div>`;
    document.getElementById('back').addEventListener('click',()=>location.href='../choiceMap.html');

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
        let drawResult = null;
        if(character.life<=0)
            drawResult = drawResultWithType('fail');
        if(isCollision(character)(goal))
            drawResult = drawResultWithType('success');
        if(drawResult===null)
            return;
        clearInterval(drawLoop);
        clearInterval(moveLoop);
        drawResult(playtime,map.mapInfo.difficulty,player.character.userId,player.characterId,map.mapNo);

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
        itemsInfo.forEach(k=>{
            if(k.key!==e.key)
                return;
            useItem(player,character,k.itemId);
            k.using = true;
            setTimeout(()=>k.using=false,300);
        });
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
    drawStatus(obj);
}

const drawGame = ({bases,hurdles,character,goal,map},playtime)=>{
    ctx.game.clearRect(0,0,canvas.game.width,canvas.game.height);
    drawImg(ctx.game,map.mapInfo.backgroundIMG,0,0,canvas.game.width,canvas.game.height);
    let startPositon = 0;
    if(character.x*stdPixel>canvas.game.width*0.3)
        startPositon = character.x*stdPixel-canvas.game.width*0.3;
    if(character.x*stdPixel>map.mapInfo.width*stdPixel-canvas.game.width*0.7)
        startPositon = map.mapInfo.width*stdPixel-canvas.game.width;
    drawPixel('yellow')(character.getShieldRect())(startPositon);
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
    itemsInfo.forEach((k,i)=>{
        let item = player.items.find(item=>item.itemId===k.itemId);
        if(item){
            drawImg(ctx.item,item.itemImg,50*(i%3),50*Math.floor(i/3),50,50);
            if(k.using){
                ctx.item.fillStyle = 'black';
                ctx.item.globalAlpha = 0.5;
                ctx.item.fillRect(50*(i%3),50*Math.floor(i/3),50,50);
                ctx.item.globalAlpha = 1;
            }
            drawTextWithStroke(ctx.item,k.key,20,50*(i%3),50*Math.floor(i/3));
            drawTextWithStroke(ctx.item,item.itemCount,20,50*(i%3)+50,50*Math.floor(i/3)+50,'right','bottom');
        }
    });
}

const drawStatus = ({character,player})=>{
    ctx.status.clearRect(0,0,canvas.status.width,canvas.status.height);
    drawTextWithStroke(ctx.status,player.character.characterName,30,100,0,'center','top');
    drawTextWithStroke(ctx.status,`Lv.${player.character.level}(${player.character.exp}/100)`,20,0,40,'left','top');
    drawTextWithStroke(ctx.status,` 속도 : +${character.maxSpeed-9} 점프력: ${Math.round(character.jumpPower*100/45)}% 쉴드 : ${character.shield}`,10,0,65,'left','top');
    drawTextWithStroke(ctx.status,` 스킬 쿨타임: ${Math.floor(player.skill.cooltime*(100-character.cooldown))/100}초 스킬 지속시간 : ${player.skill.duration}초`,10,0,80,'left','top');
}

const drawResultWithType = (result)=> async (playtime,difficulty=1,userId,characterId,mapNo)=>{
    const resultString = {fail:'출석 실패',success:'출석 완료'};
    let exp = frameToExp({result,frame:playtime});
    if(result==='success')
        exp *= difficulty;
    let clearTiem = convertTime(playtime);
    modal.innerHTML = `<div class="modal-content">
                            <div class="modal-header">
                                <div class="modal-title">${resultString[result]}</div>
                            </div>
                            <canvas class="modal-body"> </canvas>
                            <div id="modal-footer">
                                <button id="restart">재수강하기</button>
                                <button id="exit">나가기</button>
                            </div>
                        </div>`;
    modal.style.display = 'flex';
    let modalCanvas = modal.querySelector('.modal-body');
    let modalCtx = modalCanvas.getContext('2d');
    modalCanvas.width = 400;
    modalCanvas.height = 400;

    drawTextWithStroke(modalCtx,`플레이 시간 : ${clearTiem}`,20,200,0,'center');
    drawTextWithStroke(modalCtx,`획득 경험치 : ${exp}`,15,200,25,'center');
    drawTextWithStroke(modalCtx,`경험치 적용 중`,20,200,50,'center');
    drawTextWithStroke(modalCtx,`획득한 아이템 정리중`,20,200,75,'center');

    let items = [];
    let prob = 0.5;
    if(result==='success')
        prob = 1;
    itemsInfo.forEach(k=>{
        
        if(Math.random()<k.acqProbability*prob)
            items.push(k.itemId);
    });
    //userId에 경험치 반영=>결과 레벨과 경험치 modal에 표시하기
    let resultLevel = await ajax('../apis/addExp.jsp',{characterId,exp});
    //items에 있는 아이템들 addItems 하기=>결과 modal에 표시하기
    let resultItems = await ajax('../apis/addItems.jsp',{userId,items});
    //userId와 mapId와 클리어타임을 record에 추가하기
    if(result==='success')
        await ajax('../apis/addRecord.jsp',{characterId,mapNo,playtime});

    modalCtx.clearRect(0,0,modalCanvas.width,modalCanvas.height);
    drawTextWithStroke(modalCtx,`플레이 시간 : ${clearTiem}`,20,200,0,'center');
    drawTextWithStroke(modalCtx,`획득 경험치 : ${exp}`,15,200,25,'center');
    drawTextWithStroke(modalCtx,`Lv. ${resultLevel.lv} (${resultLevel.exp}/100)`,15,200,45,'center');
    drawTextWithStroke(modalCtx,`획득한 아이템`,15,10,65);
    setInterval(()=>{
    resultItems.forEach(async (k,i)=>{
        await drawImg(modalCtx,k.itemImg,30,85+50*i,50,50);
        drawTextWithStroke(modalCtx,k.itemName,30,135,100+50*i);
    })},1000/60);

    modal.querySelector('#modal-footer').innerHTML = `<button id="restart">재수강하기</button>
                                                        <button id="exit">나가기</button>`;
    const restart = document.getElementById('restart');
    const exit = document.getElementById('exit');
    restart.addEventListener('click',()=>{
        location.reload();
    });
    exit.addEventListener('click',()=>{
        modal.style.display = 'none';
        window.location.href = '../choiceMap.html';
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

const drawImg = async(ctx,imgSrc,x,y,width,height)=>{
    let img = new Image();
    img.src = imgSrc;
    await ctx.drawImage(img,x,y,width,height);
}