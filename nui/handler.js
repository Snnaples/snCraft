
let config = new Object()


$( () => {

    window.addEventListener('message', (event) => {
        if(event.data.type == 'open') {
            if (!config) return 
            $("#itemList").html('');
            $('body').fadeIn(500)    
            $.each(config.items, (name) => {
               $('#itemList').append(`<div style='background-image: url("nui://vrp/gui/items/${name}.png")' id='item-${name}' class="item">  <p class='item-name'>${config.items[name].name}</p> </div>`)
               $(`#item-${name}`).click( () => {
                $('body').fadeOut(500)
                
                    $.post('https://snCraft/closeWithItemSelection', JSON.stringify({name}))
               })
            })

            

        }
        if(event.data.type == 'loadConfig') {  config = event.data.config; return } 

     
 


    })

})


function closeHandler(e) {
    if(e.code == 'Escape') {
            $("#itemList").html('');
            $('body').fadeOut(500)
            $.post('https://snCraft/close')
    }
}

document.addEventListener('keyup', closeHandler);
