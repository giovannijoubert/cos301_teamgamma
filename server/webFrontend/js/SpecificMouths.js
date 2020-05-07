$(document).ready(function() {

    if (!getUrlVars()["mpID"])
        window.location.href = "Explore";

    loadMouthpack(getUrlVars()["mpID"]);

    //Download entire mouthpack 
    $("#downloadButton").click(function() {
        var zip = new JSZip();
        aBoxes = $("[id^='abox']");
        for (i = 1; i < aBoxes.length; i++) {
            child = $(aBoxes[i]).children()[0];
            zip.file($(".mpName").text() + i + ".png", urlToPromise($(child).attr("href")), { binary: true });

        }
        zip.generateAsync({ type: "blob" })
            .then(function callback(blob) {
                saveAs(blob, $(".mpName").text());
            });
    })

    //API Call to Load Specific Mouthpack
    function loadMouthpack(mp_id) {
        var postData = {
            requestType: "getMouthPack",
            id: mp_id
        }
        $.ajax({
            url: 'https://teamgamma.ga/api/sharingapi.php',
            type: 'post',
            dataType: 'json',
            contentType: 'application/json',
            success: function(data) {
                showMouthPack(data);
            },
            error: function(data) {
                console.log(data);
            },
            data: JSON.stringify(postData)
        });
    }

    function showMouthPack(mouthpack) {

        for (i = 0; i < mouthpack[0].images.length; i++) {
            if (i != 0)
                $("#abox0").clone().attr("id", "abox" + i).appendTo("#aboxContainer");

            //set aBox image
            $("#abox" + i + " img").attr("src", mouthpack[0].images[i]);

            //set aBox image download
            $("#abox" + i + " a").attr("href", mouthpack[0].images[i]);

            //set aBox image download attribute
            $("#abox" + i + " a").attr("download", mouthpack[0].name + (i + 1));

            //set mouthpack rating
            ratingAvg = 0;
            for(r = 1; r < mouthpack[0].ratings.length; r++){
                if(mouthpack[0].ratings[r].value)
                    ratingAvg = ratingAvg + mouthpack[0].ratings[r].value;

            }

            ratingAvg = ratingAvg / (mouthpack[0].ratings.length-1);  

            ratingAvg= Math.round(ratingAvg);

            console.log(ratingAvg);

            for(k = 1; k <= 5; k++){
                if(ratingAvg >= k)
                    $("[rating="+k+"]").removeClass("unchecked").addClass("checked");
                else
                   $("[rating="+k+"]").removeClass("checked").addClass("unchecked");
            }
        }

        //set mouthpack name
        $(".mpName").text(mouthpack[0].name);

        $("#aboxContainer").fadeTo("slow", 1.0);
    }

    function getUrlVars() {
        var vars = {};
        var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m, key, value) {
            vars[key] = value;
        });
        return vars;
    }

});