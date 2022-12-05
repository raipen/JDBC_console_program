/*jshint esversion: 6 */

import {ajax} from './utils.js';

export default class Map{
    constructor(mapNo){
        this.mapNo = mapNo;
        this.mapInfo = {};
        this.bases = [];
        this.hurdles = [];
    }

    async init(){
        // this.mapInfo={mapName:"테스트맵",backgroundIMG:"",width:150,height:35,goalx:149,goaly:32,difficulty:1};
        // this.bases=[{x:0,y:34,width:150,height:1},{x:30,y:30,width:5,height:1},{x:32,y:31,width:1,height:4},
        //             {x:45,y:29,width:5,height:1},{x:55,y:31,width:5,height:1},{x:65,y:28,width:5,height:1},{x:130,y:27,width:5,height:1}];
        // this.hurdles=[{x:10,y:33,width:1,height:1,damage:1},{x:20,y:33,width:1,height:1,damage:1},{x:40,y:33,width:1,height:1,damage:1}];

        await this.setMapInfo();
        await this.setBases();
        await this.setHurdles();
        this.bases.push({x:-1,y:-10,width:1,height:this.mapInfo.height+10});
        this.bases.push({x:0,y:-10,width:this.mapInfo.width+1,height:1});
        this.bases.push({x:this.mapInfo.width,y:-10,width:1,height:this.mapInfo.height+10});
    }

    async setMapInfo(){
        const url = '../apis/getMapInfo.jsp';
        const data = {mapNo:this.mapNo};
        this.mapInfo = await ajax(url,data);
    }

    async setBases(){
        const url = '../apis/getBases.jsp';
        const data = {mapNo:this.mapNo};
        this.bases = await ajax(url,data);
    }

    async setHurdles(){
        const url = '../apis/getHurdles.jsp';
        const data = {mapNo:this.mapNo};
        this.hurdles = await ajax(url,data);
    }
}

export const getMap = async (mapNo)=>{
    const map = new Map(mapNo);
    await map.init();
    return map;
}