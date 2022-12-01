/*jshint esversion: 6 */

import Character from './Charater.js';
import {ajax} from './utils.js';

export default class Player{
    constructor (characterId){
        this.characterId = characterId;
        this.userId;
        this.character = {};
        this.skill = {};
        this.ability = {};
        this.item = [];
    }

    async init(){
        this.character = {characterName:"테스트캐릭터",level:1,exp:0,skillId:"03000015"};
        this.skill = {skillName:"dash",img:"",duration:0,cooltime:5};
        this.ability = {speed:10,life:3,cooldown:0};
        this.item = [{itemName:"테스트아이템",itemId:1,img:"",count:5}];

        // await this.setCharacter();
        // await this.setSkill();
        // await this.setAbility();
        // await this.setItem();
    }

    getCharacter(){
        return new Character(this.ability);
    }

    async setCharacter(){
        const url = '../apis/getCharacter.jsp';
        const data = {characterId:this.characterId};
        this.character = await ajax(url,data);
        this.userId = this.character.userId;
    }

    async setSkill(){
        const url = '../apis/getSkill.jsp';
        const data = {skillId:this.character.skillId};
        this.skill = await ajax(url,data);
    }

    async setAbility(){
        const url = '../apis/getAbility.jsp';
        const data = {characterId:this.characterId};
        this.ability = await ajax(url,data);
    }

    async setItem(){
        const url = '../apis/getItem.jsp';
        const data = {userId:this.userId};
        this.item = await ajax(url,data);
    }

    
}

export const getPlayer = async (characterId)=>{
    const player = new Player(characterId);
    await player.init();
    return player;
}