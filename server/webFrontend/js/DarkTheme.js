$(document).ready(function() {

    if(profile == null)
        $("#theme_toggler").hide();


    //prevent caching
    version = Math.random();

    $('#theme_toggler').click(function() {
        toggleDarkTheme();
    });

    function toggleDarkTheme() {
        if ($('link[rel=stylesheet][href~="../css/Dark-Theme.css?ver=' + version + '"]').length || $('link[rel=stylesheet][href~="../css/Dark-Theme.css"]').length) {

            $('link[rel=stylesheet][href~="../css/Dark-Theme.css"]').remove();
            $('link[rel=stylesheet][href~="../css/Dark-Theme.css?ver=' + version + '"]').remove();
            $('.fa-sun').fadeOut(function() {
                $('.fa-sun').addClass('fa-moon').removeClass('fa-sun').fadeIn();
            });

            if(profile != null)
                setTheme("Light");
        } else {

            $('head').append($('<link rel="stylesheet" type="text/css" />').attr('href', '../css/Dark-Theme.css?ver=' + version));
            $('.fa-moon').fadeOut(function() {
                $('.fa-moon').addClass('fa-sun').removeClass('fa-moon').fadeIn();
            });

            if(profile != null)
                setTheme("Dark");

        }

    }


    //API call to set user theme
    function setTheme(theme) {
        //   profile = JSON.parse(localStorage.getItem("userProfile"));
        var postdata = {
            option: "theme",
            theme: theme,
            username: profile.username,
            jwt: profile.JWT
        }

        $.ajax({
            url: 'https://teamgamma.ga/api/umtg/update',
            type: 'post',
            dataType: 'json',
            contentType: 'application/json',
            success: function(data) {
                document.cookie = "theme=" + theme;
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


    //Toast message: Update Success
    var successfullUpdate = Toastify({
        text: "Update Successful",
        gravity: "bottom",
        backgroundColor: "linear-gradient(135deg, #56ab2f, #56ab2f)",
        duration: 4000
    });

});