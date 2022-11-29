/* /hobanu_run_web_game/api/apis/getBases.jps
    /hobanu_run_web_game/api/apis/getMapInfo.jps
    /hobanu_run_web_game/api/apis/getHurdles.jps 를 비동기로 호출하여
    mapName에 해당하는 정보를 가져온다.
*/
export default class Map{
    constructor(mapNo){
        this.mapNo = mapNo;
        this.mapInfo = {};
        this.bases = [];
        this.hurdles = [];
        this.init();
    }

    init(){
        this.getMapInfo();
        this.getBases();
        this.getHurdles();
    }

    getMapInfo(){
        const url = '/hobanu_run_web_game/api/apis/getMapInfo.jps';
        const data = {mapNo:this.mapNo};
        const callback = (result)=>{
            this.mapInfo = result;
        }
        this.ajax(url,data,callback);
    }

    getBases(){
        const url = '/hobanu_run_web_game/api/apis/getBases.jps';
        const data = {mapNo:this.mapNo};
        const callback = (result)=>{
            this.bases = result;
        }
        this.ajax(url,data,callback);
    }

    getHurdles(){
        const url = '/hobanu_run_web_game/api/apis/getHurdles.jps';
        const data = {mapNo:this.mapNo};
        const callback = (result)=>{
            this.hurdles = result;
        }
        this.ajax(url,data,callback);
    }

    ajax(url,data,callback){
        const xhr = new XMLHttpRequest();
        xhr.open('POST',url);
        xhr.setRequestHeader('Content-Type','application/json');
        xhr.send(JSON.stringify(data));
        xhr.onload = ()=>{
            const result = JSON.parse(xhr.responseText);
            callback(result);
        }
    }

}