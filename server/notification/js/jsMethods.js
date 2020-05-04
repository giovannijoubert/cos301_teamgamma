
var msg = "";

function loadTemplates() {
    var key = "3e30630d-239b-488d-8938-b9305dff3e54";
    console.log("method called");
    ajax(
        {
                "key":key,
                "getMessages":true
        },
        function(data){
            msg = (data);
        });
    document.getElementById("notificationType").selectedIndex=0;
}

function typeSelector()
{
    var typeselect = document.getElementById("notificationType");
    var index = typeselect.selectedIndex;
    var headingEl = document.getElementById("headings");
    if(index==1)
    {
        var messages = msg.emailNotifications;

        for(i in messages)
        {
            console.log(messages[i].heading);
            var head = messages[i].heading;
            var opt = document.createElement("option");
            opt.setAttribute("value",head);
            headingEl.append(opt);
            opt.innerHTML = head;
        }


    }
    else if(index == 2)
    {
        alert("selected push");
    }
    else{
        alert("selected boith");
    }
}

function ajax(data, callback)
{
    var req = new XMLHttpRequest();
    req.onreadystatechange = function()
    {
        if(req.readyState == 4 && req.status == 200)
        {
            var json = JSON.parse(req.responseText);
            //var json = this.responseText;
            callback(json);
        }
    };
    req.open("POST", "notificationAPI.php", true);
    // This is important for POST requests with data that is not submitted via a form.
    req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    req.send(parameterize(data));
}
function parameterize(data)
{
    var result = [];
    for(var d in data)
    {
        result.push(encodeURIComponent(d) + '=' + encodeURIComponent(data[d]));
    }
    return result.join('&');
}