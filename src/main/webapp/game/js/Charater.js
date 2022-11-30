import { isCollision } from "./utils.js";

export default class Character{
    constructor({speed,life,cooldown}){
        this.width = 1;
        this.height = 2;
        this.x = 0;
        this.y = 31;
        this.gravity = 1;
        this.speed = 0;
        this.life = life;
        this.cooldown = cooldown;
        this.friction = 0.6;
        this.maxSpeed = 3+speed;

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

    move(){
        return (bases,hurdles)=>{
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
            for(let base of bases){
                let horizontalCollision = isCollision({x:this.x+this.speed/60,y:this.y,width:this.width,height:this.height},base);
                let verticalCollision = isCollision({x:this.x,y:this.y+gravity/60,width:this.width,height:this.height},base);
                if(horizontalCollision){
                    this.x -= this.speed/60;
                    this.speed = 0;
                }
                if(verticalCollision){
                    this.y -= gravity/60;
                    gravity = 0;
                }
            }

            this.x += this.speed/60;
            this.y += gravity/60;
            console.log(this.y);
        }
    }



}