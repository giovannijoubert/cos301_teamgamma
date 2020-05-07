$(document).ready(function() {
    if (profile == null)
        document.location = "Explore.html";

    getProfile(profile.username, profile.JWT, displayCollection);

    //displayCollection(profile.mouthpacks);

    //API Call to Load Specific Mouthpack
    function loadMouthpack(mp_id, loadCallBack) {
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
                loadCallBack(data);
            },
            error: function(data) {
                console.log(data);
            },
            data: JSON.stringify(postData)
        });
    }

    function fillCollectionData(mouthpack) {
        mouthpack = mouthpack[0];
        if (mouthpack.images.length == 0) {
            return; //skip to next mouthpack with image
        }
        console.log(mouthpack)
            //create box
        if (counter != 0)
            $("#box0").clone().attr("id", "box" + counter).appendTo(".box_container");


        //set mouthpack ID
        $("#box" + counter).attr("mp_id", mouthpack.id);

        //set mouthpack href
        $("#box" + counter + " .d-block").attr("href", "SpecificMouth?mpID=" + mouthpack.id);


        //set mouthpack name
        $("#box" + counter + " .card h2").text(mouthpack.name);

        //set mouthpack image
        $("#box" + counter + " .card a .img-thumbnail").attr("src", mouthpack.images[3]);

        //set mouthpack image
        $("#box" + counter + " .card .card-body .card-title").text(new Date(mouthpack.date).toDateString());

        //add remove from collection handler
        $("#box" + counter + " .card #collection-btn").click(function() { rmMPfromCollection() });

        //set Download button function
        $("#box" + counter + " .download-btn").click(function() { downloadMP(); });

              //set mouthpack rating
              ratingAvg = 0;
              for(r = 1; r < mouthpack.ratings.length; r++){
                  if(mouthpack.ratings[r].value)
                      ratingAvg = ratingAvg + mouthpack.ratings[r].value;

              }

              ratingAvg = ratingAvg / (mouthpack.ratings.length-1);  

              ratingAvg= Math.round(ratingAvg);

              console.log(ratingAvg);

              for(k = 1; k <= 5; k++){
                  if(ratingAvg >= k)
                      $("#box" + counter + " [rating="+k+"]").addClass("checked");
                  else
                     $("#box" + counter + " [rating="+k+"]").removeClass("checked");
              }

        $("#box" + counter).show(); //incase it was hidden at 0 results
        counter++;
    }

    //Display the collection of mouthpacks saved in profile
    function displayCollection() {
        mouthpacks = profile.mouthpacks;
        counter = 0;
        for (i = 0; i < mouthpacks.length; i++)
            mouthpack = loadMouthpack(mouthpacks[i].mouthpack_id, fillCollectionData);

        $(".no-results").fadeOut("Slow");

        if (mouthpacks.length == 0) {
            $("#box0").fadeOut("slow");
            //Toast message: No search results
            var noResults = Toastify({
                close: true,
                gravity: "bottom",
                text: "No mouthpacks saved in collection",
                backgroundColor: "linear-gradient(135deg, #9E1A1A, #9E1A1A)",
                duration: 5000
            });
            $(".no-results").fadeIn("Slow");
            noResults.showToast();
        } else {
            $(".box_container").fadeTo("slow", 1.0);
        }
    }

    function rmMPfromCollection() {
        card = $(event.target).parent().parent();
        //   console.log(card);
        mpID = $(card).attr("mp_id");
        var postData = {
            option: "remove-mouthpack",
            username: profile.username,
            jwt: profile.JWT,
            mouthpack_id: mpID,
        }
        console.log(postData);
        $.ajax({
            url: 'https://teamgamma.ga/api/umtg/update',
            type: 'post',
            dataType: 'json',
            contentType: 'application/json',
            success: function(data) {
                console.log(data);
                //Toast message: add to Collection Success
                var addMPtoCollectionSuccess = Toastify({
                    text: "Mouthpack removed from Collection",
                    gravity: "bottom",
                    backgroundColor: "linear-gradient(135deg, #9E1A1A, #9E1A1A)",
                    duration: 4000
                });
                addMPtoCollectionSuccess.showToast();
                $(card).fadeOut("slow");
                //TODO: Mark card as added to collection
            },
            error: function(data) {
                console.log(data);
            },
            data: JSON.stringify(postData)
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

});