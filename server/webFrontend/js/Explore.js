
$(document).ready(function() {
    //auto run code
    loadLatestMouthpacks(showLatestMouthpacks);

    profile = JSON.parse(localStorage.getItem("userProfile"));


    //bind search button
    $("#search-btn").click(function() { searchMouthpacks($("#search-field").val()); })

    //bind category button
    $(".category_search").click(function() { searchByCategory(); })

    //bind sort button
    $(".sortMethod").click(function() { searchBySort(); })

    //search by category


    function searchBySort(){
       // loadLatestMouthpacks(sortMouthpacks, $(event.target).text());
       sortMouthpacks(JSON.parse(localStorage.getItem("mouthpacks")),$(event.target).text());
    }

    function sortMouthpacks(mouthpacks, method){

        if(method == "Top Rated"){ //sort by rating

            mouthpacks.sort(function(a, b) {
                var c = $("[mp_id="+a.id+"]").attr("mp_rating");
                var d = $("[mp_id="+b.id+"]").attr("mp_rating");
                return d-c;
            });
            
        }

        if(method == "Lowest Rated"){ //sort by rating

            mouthpacks.sort(function(a, b) {
                var c = $("[mp_id="+a.id+"]").attr("mp_rating");
                var d = $("[mp_id="+b.id+"]").attr("mp_rating");
                return c-d;
            });
            
        }

        if(method == "Newest"){ //sort by date
            mouthpacks.sort(function(a, b) {
                var c = new Date(a.date);
                var d = new Date(b.date);
                return d-c;
            });
        }

        if(method == "Oldest"){ //sort by date
            mouthpacks.sort(function(a, b) {
                var c = new Date(a.date);
                var d = new Date(b.date);
                return c-d;
            });
        }

        showLatestMouthpacks(mouthpacks);
        
    }

    function searchByCategory(){
        loadLatestMouthpacks(filterByCategory, $(event.target).text().substring(1));
    }

    function filterByCategory(mouthpacks, cat){
    //   console.log(mouthpacks);
        var filteredMouthpacks = [];

        for(i = 0; i < mouthpacks.length; i++){
         //   console.log(mouthpacks[i].categories[0] );
            if(mouthpacks[i].categories[0] == cat)
                filteredMouthpacks.push(mouthpacks[i]);
        }

        showLatestMouthpacks(filteredMouthpacks);
        
    }

    //Display 24 Latest Mouthpacks
    function showLatestMouthpacks(mouthpacks) {
        $(".box_container").fadeTo("slow", 0, function() {
            boxes = $(".box_container").children();
            for (i = 1; i < boxes.length; i++)
                $("#box" + i).remove();


            counter = 0;
            i = 0;

          //  console.log(mouthpacks);

            while (counter < 100 && i < mouthpacks.length && mouthpacks[0].message != "0 results found") {
                if (mouthpacks[i].images.length == 0) {
                    i++;
                    continue; //skip to next mouthpack with image
                }
            //    console.log(mouthpacks[i])
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

                //add to collection button
                $("#box" + counter + " .card .collection-btn").click(function() { addMPtoCollection(profile) });


                //save mouthpacks in local storage
                localStorage.setItem("mouthpacks", JSON.stringify(mouthpacks));

                //set Download button function
                $("#box" + counter + " .download-btn").click(function() { downloadMP(); });

                if(profile != null)
                    $("#box" + counter + " .card .ratingStars").click(function() { rateMP(); })

                $("#box" + counter).show(); //incase it was hidden at 0 results

                //set mouthpack category
                $("#box" + counter + " .card-category").html('<i class="fa fa-list-alt"></i> '+mouthpacks[i].categories[0]);

                //set mouthpack rating
                ratingAvg = 0;
                for(r = 1; r < mouthpacks[i].ratings.length; r++){
                    if(mouthpacks[i].ratings[r].value)
                        ratingAvg = ratingAvg + mouthpacks[i].ratings[r].value;

                }

                ratingAvg = ratingAvg / (mouthpacks[i].ratings.length-1);  

                ratingAvg= Math.round(ratingAvg);

                
                $("#box" + counter).attr("mp_rating", ratingAvg);

                for(k = 1; k <= 5; k++){
                    if(ratingAvg >= k)
                        $("#box" + counter + " [rating="+k+"]").addClass("checked");
                    else
                       $("#box" + counter + " [rating="+k+"]").removeClass("checked");
                }
                
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

            console.log(profile);
            if(profile == null){
                $(".btns.collection-btn").remove();
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
    function loadLatestMouthpacks(callme, cat) {
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
                callme(data, cat);
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



        //Toast message: Update Success
        var rateSuccess = Toastify({
            text: "Rating Submitted Successfully",
            gravity: "bottom",
            backgroundColor: "linear-gradient(135deg, #56ab2f, #56ab2f)",
            duration: 4000
        });

    //rate a mouthpack
    function rateMP() {
        rating = $(event.target).attr("rating");
        //console.log(rating);
        card = $(event.target).parent().parent().parent();
        //  console.log(card);

       //     console.log($(card).attr("mp_id"));
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

                rateSuccess.showToast();
            },
            error: function(data) {
                console.log(data);
            },
            data: JSON.stringify(postData)
        });
    }
});
