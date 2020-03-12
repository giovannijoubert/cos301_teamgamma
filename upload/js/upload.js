// jquery
$(document).ready(function(){
    let mouthsToUpload = 0;
    let selectedFiles = null;
    let formData = []; // containts form data to be submitted to server
    
    $("#upload-mouths input").change(function(){
        selectedFiles = $("#upload-mouths input")[0].files;
        for(let i = 0; i < selectedFiles.length; i++){
            if(mouthsToUpload >= 12){
                continue;
            }
            let reader = new FileReader();
            mouthsToUpload++;
            let image = document.createElement("img");
            reader.onload = function(evt){
                image.src = evt.target.result;
                image.ondragstart = function(e){executeDragStart(e);}
                // image.ondrag = function(e){executeDrag(e);}; 
                image.ondragend = function(e){executeDragEnd(e);};
                image.setAttribute("draggable", true);
                $("#mouths-preview")[0].appendChild(image);
            }
            reader.readAsDataURL(selectedFiles[i]);
        }

        if(mouthsToUpload < 12){
            $("#upload-report").html("Please select <b>"+(12-mouthsToUpload)+"</b> more image(s)").addClass("text-danger");
            $("#upload-mouths").addClass("alert-warning");
            return;
        }
        if(mouthsToUpload == 12){
            $("#upload-report").html("Now drag each image below into corresponding alphabet above").addClass("text-success");
            $("#upload-mouths").addClass("alert-success");
        }
    })

    /**
     * Vanilla JS
     */
    // attach drop event to each .mouth-drop-target div
    document.querySelectorAll("div.mouth-drop-target").forEach( mouth=>{
        // mouth.style.borderColor = "red";
        mouth.ondragenter = function(e){executeDragEnter(e);};
        mouth.ondragover = function(e){executeDragOver(e);};
        mouth.ondragleave = function(e){executeDragLeave(e);};
        mouth.ondrop = function(e){executeDrop(e);};
    })

    //dragging
    function executeDragStart(evt){
        evt.dataTransfer.setData("mouthImageData", evt.target.src);
        evt.target.style.opacity = "0.4";
    }
    /* function executeDrag(evt){
        // console.log(evt.target.dataset.mouthimageindex);
    } */
    function executeDragEnd(evt){
        evt.target.style.opacity = "1";
    }

    // dropping
    function executeDragEnter(evt){
        evt.target.style.borderColor = "red";
    }
    function executeDragOver(evt){
        event.preventDefault();
        evt.target.style.borderColor = "red";
    }
    function executeDragLeave(evt){
        event.preventDefault();
        evt.target.style.borderColor = "#777";
    }
    function executeDrop(evt){
        if(evt.target.className == "mouth-drop-target"){
            let imageData = evt.dataTransfer.getData("mouthImageData");
            evt.target.style.borderColor = "#777";
            evt.target.style.background = "url('"+imageData+"')";
        }
    }
});