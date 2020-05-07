
$(document).ready(function() {
    //auto run code
    loadLatestMouthpacks();

    profile = JSON.parse(localStorage.getItem("userProfile"));


    $("#search-btn").click(function() { searchMouthpacks($("#search-field").val()); })

    //auto run code

    //Display 12 Latest Mouthpacks
    function showLatestMouthpacks(mouthpacks) {
        $(".box_container").fadeTo("slow", 0, function() {
            boxes = $(".box_container").children();
            for (i = 1; i < boxes.length; i++)
                $("#box" + i).remove();


            counter = 0;
            i = 0;

            console.log(mouthpacks);

            while (counter < 12 && i < mouthpacks.length && mouthpacks[0].message != "0 results found") {
                if (mouthpacks[i].images.length == 0) {
                    i++;
                    continue; //skip to next mouthpack with image
                }
                console.log(mouthpacks[i])
                    //create box
                if (counter != 0)
                    $("#box0").clone().attr("id", "box" + counter).appendTo(".box_container");


                //set mouthpack ID
                $("#box" + counter).attr("mp_id", mouthpacks[i].id);

                //set mouthpack href
                $("#box" + counter + " .d-block").attr("href", "SpecificMouth?mpID=" + mouthpacks[i].id);


                //set mouthpack name
                $("#box" + counter + " .card .mpName").text(mouthpacks[i].name);

                //set mouthpack image
                $("#box" + counter + " .card a .img-thumbnail").attr("src", mouthpacks[i].images[3]);

                //set mouthpack image
                $("#box" + counter + " .card .card-body .card-title").text(new Date(mouthpacks[i].date).toDateString());

                $("#box" + counter + " .card .collection-btn").click(function() { addMPtoCollection(profile) });

                //save mouthpacks in local storage
                localStorage.setItem("mouthpacks", JSON.stringify(mouthpacks));

                //set Download button function
                $("#box" + counter + " .download-btn").click(function() { downloadMP(); });

                $("#box" + counter + " .card .ratingStars").click(function() { rateMP(); })

                $("#box" + counter).show(); //incase it was hidden at 0 results




                i++;
                counter++;

            }

            $(".no-results").fadeOut("Slow");

            if (counter == 0) {
                $("#box0").fadeOut("slow");
                //Toast message: No search results
                var noResults = Toastify({
                    close: true,
                    gravity: "bottom",
                    text: "No mouthpacks match the search criteria",
                    backgroundColor: "linear-gradient(135deg, #9E1A1A, #9E1A1A)",
                    duration: 5000
                });
                $(".no-results").fadeIn("Slow");
                noResults.showToast();
            } else {
                $(".box_container").fadeTo("slow", 1.0);
            }


        });
    }

    function addMPtoCollection(profile) {
        card = $(event.target).parent().parent();
        //   console.log(card);
        mpID = $(card).attr("mp_id");
        var postData = {
            option: "add-mouthpack",
            username: profile.username,
            jwt: profile.JWT,
            mouthpack_id: mpID,
            usertype: "Downloader" //decided not to implement role functionality
        }
        console.log(postData);
        $.ajax({
            url: 'https://teamgamma.ga/api/umtg/update',
            type: 'post',
            dataType: 'json',
            contentType: 'application/json',
            success: function(data) {
                //Toast message: add to Collection Success
                var addMPtoCollectionSuccess = Toastify({
                    text: "Mouthpack added to Collection",
                    gravity: "bottom",
                    backgroundColor: "linear-gradient(135deg, #56ab2f, #56ab2f)",
                    duration: 4000
                });
                addMPtoCollectionSuccess.showToast();
                //TODO: Mark card as added to collection
            },
            error: function(data) {
                console.log(data);
            },
            data: JSON.stringify(postData)
        });
    }

    function downloadMP() {
        //load mouthpacks from localStorage
        mouthpacks = JSON.parse(localStorage.getItem("mouthpacks"));

        //get mouthpack image from button that triggered function
        mpID = $(event.target).parent().parent().attr("mp_id");

        //select correct mouthpack
        for (i = 0; i < mouthpacks.length; i++)
            if (mouthpacks[i].id == mpID)
                mouthpack = mouthpacks[i];

        var zip = new JSZip();
        for (i = 1; i < mouthpack.images.length; i++) {
            zip.file(mouthpack.name + i + ".png", urlToPromise(mouthpack.images[i]), { binary: true });

        }
        zip.generateAsync({ type: "blob" })
            .then(function callback(blob) {
                saveAs(blob, mouthpack.name);
            });
    }


    //API Call to Load 12 Newest Mouthpacks
    function loadLatestMouthpacks() {
        var postData = {
            requestType: "getAllMouthpacks",
            sort_by: "date",
            order: "desc"
        }
        $.ajax({
            url: 'https://teamgamma.ga/api/sharingapi.php',
            type: 'post',
            dataType: 'json',
            contentType: 'application/json',
            success: function(data) {
                showLatestMouthpacks(data);
            },
            error: function(data) {
                console.log(data);
            },
            data: JSON.stringify(postData)
        });
    }

    function searchMouthpacks(qry) {
        var postData = {
            requestType: "getAllMouthpacks",
            filter: {
                "criteria": "mouthpack_name",
                "like": qry
            },
            sort_by: "date",
            order: "desc"
        }
        $.ajax({
            url: 'https://teamgamma.ga/api/sharingapi.php',
            type: 'post',
            dataType: 'json',
            contentType: 'application/json',
            success: function(data) {
                showLatestMouthpacks(data);
            },
            error: function(data) {
                console.log(data);
            },
            data: JSON.stringify(postData)
        });
    }


    //rate a mouthpack
    function rateMP() {
        rating = $(event.target).attr("rating");
        console.log(rating);
        card = $(event.target).parent().parent();
        console.log(card);

        var postData = {
            requestType: "rate",
            value: rating,
            userID: profile.id,
            mouthpackID: $(card).attr("mp_id")
        }
        $.ajax({
            url: 'https://teamgamma.ga/api/sharingapi.php',
            type: 'post',
            dataType: 'json',
            contentType: 'application/json',
            success: function(data) {
                console.log(data);
            },
            error: function(data) {
                console.log(data);
            },
            data: JSON.stringify(postData)
        });
    }
});
