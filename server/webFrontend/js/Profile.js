
$(document).ready(function() {

    profile = JSON.parse(localStorage.getItem("userProfile"));


    //pull newest profile on page load
    if (profile)
        getProfile(profile.username, profile.JWT, ProfileLoaded);

    //user not logged in
    if (profile == null) {
        $(".nav_login_btn").fadeIn();
        $("#user-prefs-2").fadeOut();
    }

    function ProfileLoaded() {
        console.log(profile);
        if (profile != null) { //user is logged in
            $(".nav_login_btn").fadeOut();
            $("#user-prefs-2").fadeIn();


            //update user-preferences-section
            $(".username_display").text(profile.username);
            $(".email_display").text(profile.email);

            if (profile.theme == "Dark") {
                $('.fa-moon').fadeOut(function() {
                    $('.fa-moon').addClass('fa-sun').removeClass('fa-moon').fadeIn();
                });
            } else {
                $('.fa-sun').fadeOut(function() {
                    $('.fa-sun').addClass('fa-moon').removeClass('fa-sun').fadeIn();
                });
            }
        } else {
            $(".nav_login_btn").fadeIn();
            $("#user-prefs-2").fadeOut();
        }
    }

    //Api call to update email adress
    function apiUpdateEmail(email) {
        profile = JSON.parse(localStorage.getItem("userProfile"));
        var postdata = {
            option: "email",
            email: email,
            username: profile.username,
            jwt: profile.JWT
        }

        $.ajax({
            url: 'https://teamgamma.ga/api/umtg/update',
            type: 'post',
            dataType: 'json',
            contentType: 'application/json',
            success: function(data) {
                profile = getProfile(profile.username, data.JWT);
                $(".preference-option:nth-child(3)>div>p")[0].innerHTML = email;
                $('.modal').modal('hide');
                successfullUpdate.showToast();
            },
            error: function(data) {
                //Toast message: Register Failed
                var failedUpdate = Toastify({
                    close: true,
                    gravity: "bottom",
                    text: "Update Failed: " + data.responseJSON.message,
                    backgroundColor: "linear-gradient(135deg, #9E1A1A, #9E1A1A)",
                    duration: 5000
                });
                failedUpdate.showToast();
            },
            data: JSON.stringify(postdata)
        });
    }

    //Api call to update password
    function apiUpdatePassword(password) {
        profile = JSON.parse(localStorage.getItem("userProfile"));
        var postdata = {
            option: "password",
            email: profile.email,
            username: profile.username,
            jwt: profile.JWT,
            password: password
        }

        $.ajax({
            url: 'https://teamgamma.ga/api/umtg/update',
            type: 'post',
            dataType: 'json',
            contentType: 'application/json',
            success: function(data) {
                $('.modal').modal('hide');
                successfullUpdate.showToast();
            },
            error: function(data) {
                //Toast message: Register Failed
                var failedUpdate = Toastify({
                    close: true,
                    gravity: "bottom",
                    text: "Update Failed: " + data.responseJSON.message,
                    backgroundColor: "linear-gradient(135deg, #9E1A1A, #9E1A1A)",
                    duration: 5000
                });
                failedUpdate.showToast();
            },
            data: JSON.stringify(postdata)
        });
    }

    function apiUpdateProfilePic(profile_image) {
        console.log(profile_image);
        profile = JSON.parse(localStorage.getItem("userProfile"));
        var postdata = {
            option: "image",
            username: profile.username,
            jwt: profile.JWT,
            image: profile_image
        }

        $.ajax({
            url: 'https://teamgamma.ga/api/umtg/update',
            type: 'post',
            dataType: 'json',
            contentType: 'application/json',
            success: function(data) {
                $('.modal').modal('hide');
                successfullUpdate.showToast();
                getProfile2(profile.username,profile.JWT);
                user();
            },
            error: function(data) {
                //Toast message: Register Failed
                var failedUpdate = Toastify({
                    close: true,
                    gravity: "bottom",
                    text: "Update Failed: " + data.responseJSON.message,
                    backgroundColor: "linear-gradient(135deg, #9E1A1A, #9E1A1A)",
                    duration: 5000
                });
                failedUpdate.showToast();
            },
            data: JSON.stringify(postdata)
        });
    }

    function user()
    {
        const xhttp = new XMLHttpRequest()
        const url = "https://teamgamma.ga/api/umtg/update";
        xhttp.open("POST", url, true);
        xhttp.setRequestHeader("Content-type", "application/json");
        xhttp.onreadystatechange = function () {
            if (xhttp.readyState === 4) {
                console.log(JSON.parse(xhttp.responseText).image)
                document.getElementsByClassName("ui medium rounded image")[0].src = 'data:image/png;base64,'+JSON.parse(xhttp.responseText).image;
            }
        }
        let data = JSON.stringify({"option":"download","username":JSON.parse(localStorage.getItem("userProfile")).username,"jwt" : JSON.parse(localStorage.getItem("userProfile")).JWT,"location":JSON.parse(localStorage.getItem("userProfile")).profile_image});
        xhttp.send(data);
    }

    //Api call to update username
    function apiUpdateUsername(username) {
        profile = JSON.parse(localStorage.getItem("userProfile"));
        var postdata = {
            option: "username",
            username: username,
            jwt: profile.JWT
        }

        $.ajax({
            url: 'https://teamgamma.ga/api/umtg/update',
            type: 'post',
            dataType: 'json',
            contentType: 'application/json',
            success: function(data) {
                profile = getProfile(username, data.JWT);
                $(".preference-option:nth-child(2)>div>p")[0].innerHTML = username;
                $('.modal').modal('hide');
                successfullUpdate.showToast();
            },
            error: function(data) {
                //Toast message: Register Failed
                var failedUpdate = Toastify({
                    close: true,
                    gravity: "bottom",
                    text: "Update Failed: " + data.responseJSON.message,
                    backgroundColor: "linear-gradient(135deg, #9E1A1A, #9E1A1A)",
                    duration: 5000
                });
                failedUpdate.showToast();
            },
            data: JSON.stringify(postdata)
        });
    }

    //Api call to retreive latest profile
    function getProfile(username, JWT, ProfileLoaded) {
        var postdata = {
            username: username,
            jwt: JWT
        }

        $.ajax({
            url: 'https://teamgamma.ga/api/umtg/getprofile',
            type: 'post',
            dataType: 'json',
            contentType: 'application/json',
            success: function(data) {
                localStorage.setItem("userProfile", JSON.stringify(data));
                if (document.referrer == "https://teamgamma.ga/webfrontend/html/Login" || document.referrer == "https://teamgamma.ga/webfrontend/html/Register")
                    successfullLogin.showToast();
                profile = JSON.parse(localStorage.getItem("userProfile"));
                ProfileLoaded();
            },
            error: function(data) {
                alert("API FAIL: getProfile");
            },
            data: JSON.stringify(postdata)
        });
    }

    function getProfile2(username, JWT) {
        var profile = {
            username: username,
            jwt: JWT
        }

        $.ajax({
            url: 'https://teamgamma.ga/api/umtg/getprofile',
            type: 'post',
            dataType: 'json',
            contentType: 'application/json',
            success: function(data) {
                localStorage.setItem("userProfile", JSON.stringify(data));
                profileupdated.showToast();
            },
            error: function(data) {
                alert("API FAIL: getProfile");
            },
            data: JSON.stringify(profile)
        });
    }

    var profileupdated = Toastify({
        text: "Profile Picture Updated",
        gravity: "bottom",
        backgroundColor: "linear-gradient(135deg, #56ab2f, #56ab2f)",
        duration: 4000
    });
    //Toast message: Login Success
    var successfullLogin = Toastify({
        text: "You are logged in",
        gravity: "bottom",
        backgroundColor: "linear-gradient(135deg, #56ab2f, #56ab2f)",
        duration: 4000
    });

    //Toast message: Update Success
    var successfullUpdate = Toastify({
        text: "Update Successful",
        gravity: "bottom",
        backgroundColor: "linear-gradient(135deg, #56ab2f, #56ab2f)",
        duration: 4000
    });




    /**
     * VanillaJS for the user preferences section and modal, please copy to the main/universal js file
     * for this file to work, please also include the ui.js file in your js file imports (check from upload.html)
     */
    let usernameForm = null;
    let emailForm = null;
    let passwordForm = null;

    function logout() {
        profile = JSON.parse(localStorage.getItem("userProfile"));
        var postdata = {
            option: "signout",
            username: profile.username,
            jwt: profile.JWT,
            theme: profile.theme,
            listening_mode: profile.listening_mode
        }

        $.ajax({
            url: 'https://teamgamma.ga/api/umtg/update',
            type: 'post',
            dataType: 'json',
            contentType: 'application/json',
            success: function(data) {
                localStorage.setItem("userProfile", null);
                document.location = "Explore.html";
            },
            error: function(data) {
                alert("API FAIL: Signout");
            },
            data: JSON.stringify(postdata)
        });

    }

    function getUpdateUsername() {
        document.querySelector("#update-user-prefs .modal-header h4").innerHTML = "Update username";
        if (usernameForm != null) {
            document.querySelector("#update-user-prefs .modal-body").innerHTML = "";
            document.querySelector("#update-user-prefs .modal-body").appendChild(usernameForm);
            return;
        }
        let fields = [{
            id: "username-inp",
            type: "text",
            label: "Enter new username:",
        }, ]

        usernameForm = buildForm(fields).setAttribute("id", "update-username");
        document.querySelector("#update-user-prefs .modal-body").innerHTML = "";
        document.querySelector("#update-user-prefs .modal-body").appendChild(usernameForm);
    }

    function getUpdateProfilePicBtn()
    {
        document.querySelector("#update-user-prefs .modal-header h4").innerHTML = "Update Profile Picture";
        if (usernameForm != null) {
            document.querySelector("#update-user-prefs .modal-body").innerHTML = "";
            document.querySelector("#update-user-prefs .modal-body").appendChild(profilepicForm);
            return;
        }
        let fields = [{
            id: "image-inp",
            type: "file",
            label: "Upload image:",
        }, ]

        profilepicForm = buildForm(fields).setAttribute("id", "update-image");
        document.querySelector("#update-user-prefs .modal-body").innerHTML = "";
        document.querySelector("#update-user-prefs .modal-body").appendChild(profilepicForm);
    }

    function getUpdateEmail() {

        document.querySelector("#update-user-prefs .modal-header h4").innerHTML = "Update email";
        if (emailForm != null) {
            document.querySelector("#update-user-prefs .modal-body").innerHTML = "";
            document.querySelector("#update-user-prefs .modal-body").appendChild(emailForm);
            return;
        }

        let fields = [{
            id: "email-inp",
            type: "email",
            label: "Enter new email:",
        }]

        emailForm = buildForm(fields).setAttribute("id", "update-email");
        document.querySelector("#update-user-prefs .modal-body").innerHTML = "";
        document.querySelector("#update-user-prefs .modal-body").appendChild(emailForm);
    }

    function getUpdatePassword() {
        document.querySelector("#update-user-prefs .modal-header h4").innerHTML = "Update password";
        if (passwordForm != null) {
            document.querySelector("#update-user-prefs .modal-body").innerHTML = "";
            document.querySelector("#update-user-prefs .modal-body").appendChild(passwordForm);
            return;
        }
        let form = new Component("form", "update-password", "");
        let fields = [{
                id: "npassword-inp",
                type: "password",
                label: "Enter new password:",
            },
            {
                id: "cpassword-inp",
                type: "password",
                label: "Confirm new password:",
            }
        ]

        passwordForm = buildForm(fields).setAttribute("id", "update-password");
        document.querySelector("#update-user-prefs .modal-body").innerHTML = "";
        document.querySelector("#update-user-prefs .modal-body").appendChild(passwordForm);
    }

    function submitUpdateForm(evt) {
        evt.preventDefault();
        let updateForm = evt.target;

        switch (updateForm.id) {
            case "update-username":
                { // update username
                    let formData = {};
                    formData.username = document.getElementById("username-inp").value;
                    apiUpdateUsername(formData.username);
                    break;
                }
            case "update-email":
                { // update email
                    let formData = {};
                    formData.email = document.getElementById("email-inp").value;
                    apiUpdateEmail(formData.email);
                    break;
                }
            case "update-password":
                { // update password
                    let formData = {};
                    formData.password = document.getElementById("npassword-inp").value;
                    if (formData.password != document.getElementById("cpassword-inp").value) {
                        //Toast message: Passwords don't match Failed
                        var failedUpdate = Toastify({
                            close: true,
                            gravity: "bottom",
                            text: "Passwords don't match",
                            backgroundColor: "linear-gradient(135deg, #9E1A1A, #9E1A1A)",
                            duration: 5000
                        });
                        failedUpdate.showToast();
                        return;
                    }
                    apiUpdatePassword(formData.password);
                    break;
                }
            case "update-image":
            {
                let formData = {};
                let sample = document.getElementById("image-inp");
                encodeImageFileAsURL(sample);
                break;
            }
        }
    }

    function encodeImageFileAsURL(element) {
        var file = element.files[0];
        var reader = new FileReader();
        reader.onloadend = function() {
            apiUpdateProfilePic(reader.result.replace("data:image/jpeg;base64,",""));
        }
        reader.readAsDataURL(file);
    }

    function buildForm(fields) {
        let form = new Component("form", "", "");
        fields.forEach(field => {
            let label = new Component("label", "", "");
            label.appendText(field.label)
            label.getElement().setAttribute("for", field.id);
            let formGroup = new Component("div", "", "form-group");
            formGroup.appendChild(label.getElement())
                .appendChild(new InputComponent(field.type, field.id, "form-control").setAttribute("required", "true"));
            form.appendChild(formGroup.getElement());
        });

        form.appendChild(new ButtonComponent("submit_profile", "btn btn-default btn-block bg-dark text-white", "Submit").getElement());
        form.getElement().onsubmit = function(evt) {
            submitUpdateForm(evt)
        }
        return form;
    }
    /* END OF user preferences VanillaJS */

    // bind user preferencebuttons

    $("#updateUsernameBtn").click(function() { getUpdateUsername(); });
    $("#updateProfilePicBtn").click(function() { getUpdateProfilePicBtn(); });
    $("#updateEmailBtn").click(function() { getUpdateEmail(); });
    $("#updatePasswordBtn").click(function() { getUpdatePassword(); });
    $("#logoutBtn").click(function() { logout(); });
});

