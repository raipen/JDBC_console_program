import { isCollision, noInterruptMove } from "./utils.js";

export default class Character{
    constructor({speed,life,cooldown}){
        this.width = 1;
        this.height = 2;
        this.x = 0;
        this.y = 31;
        this.gravity = 10;
        this.speed = 0;
        this.life = life;
        this.cooldown = cooldown;
        this.friction = 0.6;
        this.maxSpeed = 3+speed;
        this.bases = [];
        this.hurdles = [];
        this.safeMove;

        this.left = false;
        this.right = false;
    }

    moveLeft(){
        this.left = true;
    }

    moveRight(){
        this.right = true;
    }

    stopLeft(){
        this.left = false;
    }

    stopRight(){
        this.right = false;
    }

    setMap({bases,hurdles}){
        this.bases = bases;
        this.hurdles = hurdles;
        this.safeMove = noInterruptMove(this.bases,this.hurdles);
    }

    jump(){
        let jumpInterval = setInterval(()=>{
            this.y -= this.gravity/30;
        },1000/60);
        setTimeout(()=>{
            console.log("jump end");
            clearInterval(jumpInterval);
        },500);
    }

    move(){
        return ()=>{
            if((this.left&&this.right)||(!this.left&&!this.right))
                this.speed *= this.friction;
            else if(this.left)
                this.speed--;
            else if(this.right)
                this.speed++;

            if(this.speed > this.maxSpeed)
                this.speed = this.maxSpeed;
            else if(this.speed < -this.maxSpeed)
                this.speed = -this.maxSpeed;

            let gravity = this.gravity;
            //check collision with bases
            let rect = {x:this.x,y:this.y,width:this.width,height:this.height};
            let result = this.safeMove(rect)(this.speed,gravity);

            this.x = result.x;
            this.y = result.y;
            //console.log(this.y);
        }
    }




}