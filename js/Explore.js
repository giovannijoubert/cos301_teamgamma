$(document).ready(function(){
    let searchDB = [
        "lindo",
        "ryan",
        "user",
    ]
    $("#search-form").submit(function(evt){
        evt.preventDefault();
        let query = $("#search-field").val().toLowerCase();
        $("#main-content").addClass("collapse");
        $("#search-content").addClass("show");
        if(searchDB.indexOf(query) > -1){
            $("#search-heading h4 span").html("Search results for "+query);
            $(".search-data").removeClass("show");
            $("."+query).addClass("show");
            return;
        }
        $(".search-data").removeClass("show");
        $("#search-heading h4 span").html("No results for "+query);

    })
})