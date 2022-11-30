export const get_cookie=name=> {
    var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
    return value? value[2] : null;
}

export const ajax=async (url,data)=>{
    const result = await fetch(url,{
        method:'POST',
        headers:{
            'Content-Type':'application/json',
            'X-CSRF-TOKEN':get_cookie('X-CSRF-TOKEN')
        },
        body:JSON.stringify(data)
    });
    return await result.json();
}

//check collision between two rectangles
export const isCollision=(rect1,rect2)=>{
    console.log(rect1);
    console.log(rect2);
    if(rect1.x+rect1.width < rect2.x || rect2.x+rect2.width < rect1.x){
        console.log("x축 충돌 하지 않음");
        return false;
    }
    if(rect1.y+rect1.height < rect2.y || rect2.y+rect2.height < rect1.y){
        console.log("y축 충돌 하지 않음");
        return false;
    }
    return true;
    return rect1.x < rect2.x + rect2.width &&
        rect1.x + rect1.width > rect2.x &&
        rect1.y < rect2.y + rect2.height &&
        rect1.y + rect1.height > rect2.y;
}