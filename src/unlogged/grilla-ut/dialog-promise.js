"use strict";
/*jshint eqnull:true */
/*jshint browser:true */

var DialogPromise = {};

DialogPromise.messages={
    Ok: 'Ok',
    Cancel: 'Cancel',
    Yes: 'Yes',
    No: 'No'
};

DialogPromise.castellano={
    Ok: 'Aceptar',
    Cancel: 'Cancelar',
    Yes: 'Sí',
    No: 'No'
};

function dialogPromise(dialogConstructor, opts){
    opts = opts||{};
    opts.mainAttrs = opts.mainAttrs||{};
    return new Promise(function(resolve, reject){
        var modalBackground = document.createElement('div');
        modalBackground.className='dialog-promise-background';
        var dialogWindow = document.createElement('div');
        dialogWindow.className='dialog-promise';
        for(var attrName in opts.mainAttrs) if(opts.mainAttrs.hasOwnProperty(attrName)){
            dialogWindow[attrName] = opts.mainAttrs[attrName];
        }
        var body = document.body;
        var closeWindow = function closeWindow(senderAnswerFunction, answer){
            window.removeEventListener('keydown', interceptKey);
            dialogWindow.style.display = 'none';
            body.removeChild(modalBackground);
            body.removeChild(dialogWindow);
            senderAnswerFunction(answer);
        }
        var closeWindowWithEmptyAnswer = closeWindow.bind(null,opts.reject?reject:resolve,opts.closeValue);
        dialogPromise.addCloseButton[dialogPromise.withCloseButton](dialogWindow, closeWindowWithEmptyAnswer);
        dialogConstructor(dialogWindow, closeWindow.bind(null,resolve), closeWindow.bind(null,reject));
        body.appendChild(modalBackground);
        body.appendChild(dialogWindow);
        dialogWindow.style.display='block';
        modalBackground.style.display='block';
        modalBackground.addEventListener('click', closeWindowWithEmptyAnswer);
        var interceptKey = function interceptKey(event){
            if(event.target!==dialogWindow && !dialogWindow.contains(event.target)){
                event.preventDefault();
            }
        }
        window.addEventListener('keydown', interceptKey);
    });
}

dialogPromise.withCloseButton=true;
dialogPromise.addCloseButton={
    false:function(){},
    true:function(dialogWindow, done){
        var closeButton=document.createElement('button');
        closeButton.className='dialog-promise-close-button';
        dialogWindow.appendChild(closeButton);
        closeButton.addEventListener('click', done);
    }
};

function simpleFormPromise(elementsList){
    return dialogPromise(function(mainElement, done){
        elementsList.forEach(function(elementDefinition){
            if(typeof elementDefinition=='string'){
                var div=document.createElement('div');
                div.textContent=elementDefinition;
                mainElement.appendChild(div);
            }else if(elementDefinition instanceof HTMLElement){
                mainElement.appendChild(elementDefinition);
            }else{
                var button=document.createElement('button');
                button.textContent=elementDefinition.label;
                button.addEventListener('click', function(){
                    done(elementDefinition.value);
                });
                mainElement.appendChild(button);
            }
        });
    });
}

function alertPromise(message, buttonDef){
    return simpleFormPromise([message, buttonDef||{label:DialogPromise.messages.Ok, value:true}]);
}

function confirmPromise(message, buttonsDef){
    return simpleFormPromise([message].concat(
        buttonsDef||[
            {label:DialogPromise.messages.Yes, value:true}, 
            {label:DialogPromise.messages.No, value:false}
        ]
    ));
}

function promptPromise(message, buttonsDef){
    buttonsDef = buttonsDef||[
        {label:DialogPromise.messages.Ok, value:true}, 
        {label:DialogPromise.messages.Cancel, value:false}
    ];
    var input = document.createElement('input');
    buttonsDef.forEach(function(buttonDef){
        if(buttonDef.value===true){
            Object.defineProperty(buttonDef, 'value', { get: function(){ return input.value; }});
        }
    });
    return simpleFormPromise([
        message, 
        input, 
        document.createElement('br')
    ].concat(buttonsDef));
}

function miniMenuPromise(menu, opts){
    return dialogPromise(function(mainElement,done){
        var table=document.createElement('table');
        table.className='dialog-menu';
        menu.forEach(function(menuOption){
            var row=table.insertRow();
            var tdImage=row.insertCell();
            var imageElement=document.createElement('img');
            imageElement.src=menuOption.img;
            imageElement.addEventListener('click', function(){
                done(menuOption.value);
            });
            tdImage.appendChild(imageElement);
            var tdLabel=row.insertCell();
            var labelElement=document.createElement('label');
            labelElement.textContent=menuOption.label;
            tdLabel.addEventListener('click', function(){
                done(menuOption.value);
            });
            tdLabel.appendChild(labelElement);
        })
        mainElement.appendChild(table);
        mainElement.classList.add('dialog-0');
    })
}
