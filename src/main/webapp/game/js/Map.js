import {ajax} from './utils.js';

export default class Map{
    constructor(mapNo){
        this.mapNo = mapNo;
        this.mapInfo = {};
        this.bases = [];
        this.hurdles = [];
    }

    async init(){
        this.mapInfo={mapName:"테스트맵",backgroundIMG:"",width:150,height:35,goalx:149,goaly:32,difficulty:1};
        this.bases=[{x:0,y:34,width:150,height:1},{x:30,y:30,width:5,height:1},{x:32,y:31,width:1,height:4}];
        this.hurdles=[{x:10,y:33,width:1,height:1}];

        // await this.setMapInfo();
        // await this.setBases();
        // await this.setHurdles();
    }

    async setMapInfo(){
        const url = '../apis/getMapInfo.jps';
        const data = {mapNo:this.mapNo};
        this.mapInfo = await ajax(url,data);
    }

    async setBases(){
        const url = '../apis/getBases.jps';
        const data = {mapNo:this.mapNo};
        this.bases = await ajax(url,data);
    }

    async setHurdles(){
        const url = '../apis/getHurdles.jps';
        const data = {mapNo:this.mapNo};
        this.hurdles = await ajax(url,data);
    }
}

export const getMap = async (mapNo)=>{
    const map = new Map(mapNo);
    await map.init();
    return map;
}