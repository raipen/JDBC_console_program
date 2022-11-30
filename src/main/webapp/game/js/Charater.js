/*jshint esversion: 6 */

import { isOnBase, noInterruptMove, damageOfHurdle } from "./utils.js";

export default class Character{
    constructor({speed,life,cooldown}){
        this.width = 1;
        this.height = 2;
        this.x = 0;
        this.y = 31;
        this.gravity = 30;
        this.speed = 0;
        this.life = life;
        this.cooldown = cooldown;
        this.friction = 0.6;
        this.maxSpeed = 3+speed;
        this.bases = [];
        this.hurdles = [];
        this.safeMove;
        this.isBouncing = false;
        this.invincible = false;

        this.left = false;
        this.right = false;
    }

    getRect = () => { return { x: this.x, y: this.y, width: this.width, height: this.height }; }

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

    print(){
        console.log(this);
    }

    jump(){
        if(!isOnBase(this.bases)(this.getRect()))
            return;
        let ySpeed = -100;
        let jumpInterval = setInterval(()=>{
            let result = this.safeMove(this.getRect())(0,ySpeed);
            if((result.y>this.y+ySpeed/60)||(ySpeed>-this.gravity)){
                clearInterval(jumpInterval);
            }
            this.y = result.y;
            ySpeed *= 0.9;
        },1000/60);
    }

    bounce(damage){
        if(this.isBouncing)
            return;
        this.isBouncing = true;
        this.life -= damage;
        let speed = -60;
        if(this.left)
            speed = 60;
        let bounceInterval = setInterval(()=>{
            let result = this.safeMove(this.getRect())(speed,0);
            if((result.x>this.x+speed/60)||(speed<1&&speed>-1)){
                console.log("speed:"+speed);
                this.isBouncing = false;
                clearInterval(bounceInterval);
            }
            this.x = result.x;
            speed *= 0.6;
        },1000/60);
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
            let result = this.safeMove(this.getRect())(this.speed,gravity);
            this.x = result.x;
            this.y = result.y;
            if(this.invincible)
                return;
            let damage = damageOfHurdle(this.hurdles)(this.getRect());
            if(damage>0){
                this.invincible = true;
                setTimeout(() => {
                    this.invincible = false;
                }, 250);
                this.bounce(damage);
            }
        }
    }

}