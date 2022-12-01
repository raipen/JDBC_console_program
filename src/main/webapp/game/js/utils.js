/*jshint esversion: 6 */

export const sleep = ms => new Promise(r => setTimeout(r, ms));

export const get_cookie = name => {
    var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
    return value ? value[2] : null;
}

export const ajax = async (url, data) => {
    const result = await fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-TOKEN': get_cookie('X-CSRF-TOKEN')
        },
        body: JSON.stringify(data)
    });
    return await result.json();
}

//check collision between two rectangles
export const isCollision = rect1 => rect2 => {
    //console.log(rect1.x < rect2.x + rect2.width, rect1.x + rect1.width > rect2.x, rect1.y < rect2.y + rect2.height, rect1.y + rect1.height > rect2.y);
    return rect1.x < rect2.x + rect2.width &&
        rect1.x + rect1.width > rect2.x &&
        rect1.y < rect2.y + rect2.height &&
        rect1.y + rect1.height > rect2.y;
}

export const isOnBase = bases => rect => {
    rect.y+=1/60;
    for (let base of bases) {
        if (isCollision(rect)(base)){
            return true;
        }
    }
    return false;
}

export const noInterruptMove = (bases) => ({ x, y, width, height }) => (xSpeed, ySpeed) => {
    let rect = { x, y, width, height };
    let horizontalRect = { ...rect, x: x + xSpeed / 60 };
    let verticalRect = { ...rect, y: y + ySpeed / 60 };
    for (let base of bases) {
        let isCollisionWithBase = isCollision(base);
        if (xSpeed!==0&&isCollisionWithBase(horizontalRect)) {
            horizontalRect.x = Math.ceil(horizontalRect.x);
            while (isCollisionWithBase(horizontalRect))
                horizontalRect.x -= Math.sign(xSpeed);
            rect.x = horizontalRect.x;
            xSpeed = 0;
        }
        if (ySpeed!==0&&isCollisionWithBase(verticalRect)) {
            verticalRect.y = Math.ceil(verticalRect.y);
            while (isCollisionWithBase(verticalRect))
                verticalRect.y -= Math.sign(ySpeed);
            rect.y = verticalRect.y;
            ySpeed = 0;
        }
    }
    return { x: rect.x + xSpeed / 60, y: rect.y + ySpeed / 60 };
}

export const damageOfHurdle = (hurdles) => ({ x, y, width, height }) =>{
    let rect = { x, y, width, height };
    for (let hurdle of hurdles) {
        if(isCollision(hurdle)(rect)){
            return hurdle.damage;
        }
    }
    return 0;
}