/*jshint esversion: 6 */

import { isOnBase, noInterruptMove, damageOfHurdle } from "./utils.js";

export default class Character{
    constructor({speed,life,cooldown}){
        this.width = 0.9;
        this.height = 1.8;
        this.x = 0;
        this.y = 31;
        this.gravity = 3;
        this.jumpPower = 45;
        this.xSpeed = 0;
        this.ySpeed = 0;
        this.life = life;
        this.cooldown = cooldown;
        this.friction = 0.6;
        this.maxSpeed = 2+speed;
        this.bases = [];
        this.hurdles = [];
        this.safeMove;
        this.isBouncing = false;
        this.invincible = false;
        this.cooltime=0;
        this.color = "green";

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
        this.ySpeed = -this.jumpPower;
        let result = this.safeMove(this.getRect())(0,this.ySpeed);
        this.y = result.y;
    }

    bounce(damage){
        if(this.isBouncing)
            return;
        this.isBouncing = true;
        this.life -= damage;
        if(this.life<=0)
            return;
        if(this.left)
            this.xSpeed += this.maxSpeed*2;
        else
            this.xSpeed -= this.maxSpeed*2;
        let result = this.safeMove(this.getRect())(this.xSpeed,0);
        this.x = result.x;
        this.isBouncing = false;
    }

    move(){
        return ()=>{
            if(this.cooltime>0)
                this.cooltime--;
            if((this.left&&this.right)||(!this.left&&!this.right))
                this.xSpeed *= this.friction;
            else if(this.left)
                this.xSpeed--;
            else if(this.right)
                this.xSpeed++;

            if(this.xSpeed > this.maxSpeed)
                this.xSpeed = this.maxSpeed;
            else if(this.xSpeed < -this.maxSpeed)
                this.xSpeed = -this.maxSpeed;

            if(isOnBase(this.bases)(this.getRect()))
                this.ySpeed = 0;
            else
                this.ySpeed += this.gravity;

            let result = this.safeMove(this.getRect())(this.xSpeed,this.ySpeed);
            if(result.y>this.y+this.ySpeed/60)
                this.ySpeed = 0;
            this.x = result.x;
            this.y = result.y;
            if(this.invincible)
                return;
            let damage = damageOfHurdle(this.hurdles)(this.getRect());
            if(damage>0){
                this.invincible = true;
                setTimeout(() => {
                    this.invincible = false;
                }, 500);
                this.bounce(damage);
            }
        }
    }

}