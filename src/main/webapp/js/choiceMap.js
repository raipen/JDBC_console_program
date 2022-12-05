import { get_cookie, ajax } from '../game/js/utils.js';

export const getMapList = async () => {
    const result = await ajax('apis/getMapList.jsp', {});
    console.log(result);
    const contents = document.querySelector('#contents');
    let html = '';
    for (let i = 0; i < result.length; i++)
    {
        html += `
        <div class="map" value="${result[i].no}">
            <div class="backgroundBox">
                <img src="./game/${result[i].backGround}">
            </div>
            <div class="InfoBox">
                <h2>맵이름:${result[i].name}</h2>
                <div class="difficulty ">난이도:${result[i].difficulty}</div>
                <button class="rank button" value="${result[i].no}" style="cursor:pointer;">랭킹</button>
                <a href="game/?=${result[i].no}"><button style="cursor:pointer;" class="button">플레이</button></a>
            </div>
        </div>`;
    }
    contents.innerHTML = html;
    console.log("asdf");
    const buttons = document.querySelectorAll(".rank");
    console.log(buttons);
    buttons.forEach(b => b.addEventListener('click', getRecordList));
    }
const getRecordList = async (e) => {
    console.log("isClick");
    const recordResult = await ajax('apis/getRecordList.jsp', { "id": "", "characterId": "", "mapNo": e.target.getAttribute("value") });
    console.log(e.target.getAttribute("value"));
    const rankModal = document.querySelector('#rank');
    rankModal.style.display = 'flex';
    let rankHtml = `
        <div class="modal-content">
            <div class="modal-header">
                ${e.target.getAttribute("value")}
            </div>
                <div class="modal-body">
                    로딩중
                    <div id="modal-button">
                    <button id="exit">나가기</button>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
            </div>
        </div>
    `;
    console.log('!!!');
    rankModal.innerHTML = rankHtml;
    console.log('!!!');

    console.log(recordResult);
    rankHtml = `
        <div class="modal-content">
            <div class="modal-header">
                <h1>랭킹</h1>
            </div>
            <div class="modal-body" style="overflow-x:hidden;overflow-y:auto; width:400px; height:250px;">
    `;

    const convertTime = (frame)=>{
        let min = Math.floor(frame / 3600);
        let sec = Math.floor((frame % 3600) / 60);
        let msec = Math.floor((frame % 3600) % 60);
        return `${min < 10 ? '0' + min : min}:${sec < 10 ? '0' + sec : sec}:${msec < 10 ? '0' + msec : msec}`;
    }   
    for (let i = 0; i < recordResult.length; i++) {
        rankHtml += `<div align="left" style="border: 1px solid #48BAE4; height: 100px;">순위:${i+1} 닉네임:${recordResult[i].characterName} <br> 걸린시간:${convertTime(recordResult[i].clearTime)}</div>
                    `
    }
    rankHtml += `<div id="modal-button">
                    
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="exit" style="float:right;"><h1>닫기</h1></button>
                    </div>
                </div>
            </div>`
    rankModal.innerHTML = rankHtml;
    const exit = document.getElementById('exit');
    exit.addEventListener('click',()=>{
    rankModal.style.display = 'none';
    }); 
}

export const loadHeader = async (characterId) => {
    console.log(characterId);
    let character = await ajax('apis/getCharacter.jsp', {characterId});
    character.ability = await ajax('apis/getAbility.jsp', {characterId});
    let skillPoint = character.level - character.ability.life - character.ability.speed - character.ability.cooldown + 3;
    let html = `
            <div class="characterName">${character.characterName}</div>
            <div class="characterLevel">LV.${character.level}(${character.exp}/100)</div>
            <div class="abilityBox">
                <div style="grid-column: 1/4;"> 남은 스탯 포인트: ${skillPoint}</div>
                <div>speed</div> <div style="text-align:center">${character.ability.speed}</div><button class="abilityUp" value="speed">▲</button>
                <div>life</div> <div style="text-align:center">${character.ability.life}</div><button class="abilityUp" value="life">▲</button>
                <div>coolDown</div> <div style="text-align:center">${character.ability.cooldown}</div><button class="abilityUp" value="coolDown">▲</button>
            </div>
            <a href="./apis/returnCharacterChoise.jsp">캐릭터 선택창으로 돌아가기</a>
            `;
    document.querySelector('header').innerHTML = html;
    const abilityUps = document.querySelectorAll('.abilityUp');
    abilityUps.forEach((abilityUp) => {
        abilityUp.addEventListener('click', abilityUpClick(character,characterId));
    });
}

const abilityUpClick = (character,characterId)=>async (e) => {
    const ability = e.target.getAttribute("value");
    e.disabled = true;
    let skillPoint = character.level - character.ability.life - character.ability.speed - character.ability.cooldown + 3;
    
    if(skillPoint <= 0){
        alert('스킬 포인트가 부족합니다.');
        return;
    }

    let result = await ajax('apis/upgradeAbility.jsp', {characterId, ability});
    
    if(result.message === 'success'){
        character.ability[ability]++;
        loadHeader(get_cookie('characterId'));
    }
    e.disabled = false;
}

loadHeader(get_cookie('characterId'));