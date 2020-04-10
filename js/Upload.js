/* upload.html JS */
// global variable
let mouthImages = new Array(12); // 12 is the number of formant letter groups

// jquery
$(document).ready(function(){
    /**
     * Vanilla JS
     */
    document.querySelectorAll("input[type='file']").forEach( (inp, inpIndex) => {
        inp.onchange = function(evt){
            if(inp.value == ""){
                document.getElementById("div-"+evt.target.id.split("-")[1]).style.background = "none";
                return;
            }
            let selectedFile = this.files[0];
            let reader = new FileReader();
            reader.onload = function(ev){
                document.getElementById("div-"+evt.target.id.split("-")[1]).style.background = "url('"+ev.target.result+"')";
                /*
                    store images in an object for use when the form is submitted
                    {
                        formantLetters: aei,
                        imageData: base64Data
                    }
                */
               
                mouthImages[inpIndex] = {"imageData":ev.target.result, "formantLetters":evt.target.id.split("-")[1]};
            }
            reader.readAsDataURL(selectedFile);
        }
    });

    document.getElementById("upload-form").onsubmit = function(evt){
        uplaodMouthPack(evt);
    }
});

function uplaodMouthPack(evt){
    evt.preventDefault();
    let formData = {};
    /**
     * collect the rest of the data: title and category
     * from the upload form and submit
    */
   formData.requestType = "upload";
   formData.description = "Description...";
   formData.title = document.getElementById("mouth-pack-title").value;
   formData.category = document.getElementById("mouth-pack-category").value;
   formData.mouthImages = mouthImages;
   // send request to sharing api, I will update code soon to include authentication api key
   fetch(
       "http://teamgamma.ga/api/sharingapi.php",
       {
           method: "POST",
           body: JSON.stringify(formData),
       }
   ).then(res=>{
       console.log(res);
   }).catch(err=>console.log(err));
}

function resetUpload(){
    document.querySelectorAll(".mouth-drop-target[style*='background:']").forEach( div => {
        div.style.background = "none";
    })
    $("#upload-form")[0].reset();
}
/* END OF upload.html JS */

/**
 * VanillaJS for the user preferences section and modal, please copy to the main/universal js file
 * for this file to work, please also include the ui.js file in your js file imports (check from upload.html)
 */
let usernameForm = null;
let emailForm = null;
let passwordForm = null;

function logout(){
    // send a logout request to user management
    console.log("You logged out");
    document.location = "Login.html"
}

function getUpdateUsername(){
    document.querySelector("#update-user-prefs .modal-header h4").innerHTML = "Update username";
    if(usernameForm != null) {
        document.querySelector("#update-user-prefs .modal-body").innerHTML = "";
        document.querySelector("#update-user-prefs .modal-body").appendChild(usernameForm);
        return;
    }
    let fields = [
        {
            id: "password-inp",
            type: "password",
            label: "Enter current password:",
        },
        {
            id: "username-inp",
            type: "text",
            label: "Enter new username:",
        },
    ]

    
    usernameForm = buildForm(fields).setAttribute("id", "update-username");
    document.querySelector("#update-user-prefs .modal-body").innerHTML = "";
    document.querySelector("#update-user-prefs .modal-body").appendChild(usernameForm);
}

function getUpdateEmail(){
    document.querySelector("#update-user-prefs .modal-header h4").innerHTML = "Update email";
    if(emailForm != null) {
        document.querySelector("#update-user-prefs .modal-body").innerHTML = "";
        document.querySelector("#update-user-prefs .modal-body").appendChild(emailForm);
        return;
    }
   
    let fields = [
        {
            id: "password-inp",
            type: "password",
            label: "Enter current password:",
        },
        {
            id: "email-inp",
            type: "email",
            label: "Enter new email:",
        },
    ]    
    
    emailForm = buildForm(fields).setAttribute("id", "update-email");
    document.querySelector("#update-user-prefs .modal-body").innerHTML = "";
    document.querySelector("#update-user-prefs .modal-body").appendChild(emailForm);
}

function getUpdatePassword(){
    document.querySelector("#update-user-prefs .modal-header h4").innerHTML = "Update password";
    if(passwordForm != null) {
        document.querySelector("#update-user-prefs .modal-body").innerHTML = "";
        document.querySelector("#update-user-prefs .modal-body").appendChild(passwordForm);
        return;
    }
    let form = new Component("form", "update-password", "");
    let fields = [
        {
            id: "password-inp",
            type: "password",
            label: "Enter current password:",
        },
        {
            id: "npassword-inp",
            type: "password",
            label: "Enter new password:",
        },
        {
            id: "cpassword-inp",
            type: "password",
            label: "Confirm new password:",
        },
    ]
    
    passwordForm = buildForm(fields).setAttribute("id", "update-password");
    document.querySelector("#update-user-prefs .modal-body").innerHTML = "";
    document.querySelector("#update-user-prefs .modal-body").appendChild(passwordForm);
}

function submitUpdateForm(evt){
    evt.preventDefault();
    let updateForm = evt.target;
    // verify password with the user management api then proceed
    let password = document.getElementById("password-inp").value;
    // mock verification
    if(password != "1234"){
        alert("MOCK: incorrect password, try 1234");
        return;
    }
    switch(updateForm.id){
        case "update-username":{ // update username
            let formData = {};
            formData.username = document.getElementById("username-inp").value;
            console.log(formData);
            // submit form data
            $(".preference-option:nth-child(2)>div>p")[0].innerHTML = formData.username;
            break;
        }
        case "update-email":{ // update email
            let formData = {};
            formData.email = document.getElementById("email-inp").value;
            console.log(formData);
            // submit form data
            $(".preference-option:nth-child(3)>div>p")[0].innerHTML = formData.email;
            break;
        }
        case "update-password":{ // update password
            let formData = {};
            formData.password = document.getElementById("npassword-inp").value;
            if(formData.password != document.getElementById("cpassword-inp").value){
                alert("passwords don't match");
                return;
            }
            console.log(formData);
            // submit form data
            break;
        }
    }
}

function buildForm(fields){
    let form = new Component("form", "", "");
    fields.forEach( field => {
        let label = new Component("label", "", "");
        label.appendText(field.label)
        label.getElement().setAttribute("for", field.id);
        let formGroup = new Component("div", "", "form-group");
        formGroup.appendChild(label.getElement())
        .appendChild(new InputComponent(field.type, field.id, "form-control").setAttribute("required", "true"));
        form.appendChild(formGroup.getElement());
    });

    form.appendChild(new ButtonComponent("", "btn btn-default btn-block bg-dark text-white", "Submit").getElement());
    form.getElement().onsubmit = function(evt){
        submitUpdateForm(evt)
    }
    return form;
}
/* END OF user preferences VanillaJS */

//switch to dark mode/light mode

// document.addEventListener('DOMContentLoaded', () => {

//     const themeStylesheet = document.getElementById('theme');
//     const themeToggle = document.getElementById('theme-toggle');
//     themeToggle.addEventListener('click', () => {
//         // if it's light -> go dark
//         if(themeStylesheet.href.includes('Light')){
//             themeStylesheet.href = 'DarkTheme.css';

//         } else {
//             // if it's dark -> go light
//             themeStylesheet.href = 'LightTheme.css';
    

//         }
//     })
// })
