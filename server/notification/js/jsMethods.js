
var msg = "";
var type="";
var msgBoxHead = false, msgBoxMessage=false;

function loadTemplates() {
    var key = "3e30630d-239b-488d-8938-b9305dff3e54";
    //console.log("method called");
    ajax(
        {
                "key":key,
                "getMessages":true
        },
        function(data){
            msg = (data);
        });
    clearPage();
}

function clearSelector(el){
    var len = el.options.length;
    for(var x=len;x>1;x--)
    {
        el.options.remove(x);
    }

}

function typeSelector(){
    var typeselect = document.getElementById("notificationType");
    var index = typeselect.selectedIndex;
    var headingEl = document.getElementById("headings");
    clearSelector(headingEl);

    if(index==1)
    {
        loadHeadings( msg.emailNotifications,"emailNotifications");
        headingEl.setAttribute("class","emailNotifications");
        type = "emailNotifications";
    }
    else if(index == 2)
    {
        loadHeadings(msg.networkNotifications,"networkNotifications");
        headingEl.setAttribute("class","networkNotifications");
        type = "networkNotifications";
    }
    else{
        loadHeadings(msg.networkNotifications,"networkNotifications");
        loadHeadings( msg.emailNotifications,"emailNotifications");
        headingEl.setAttribute("class","both");
        type = "both";
    }
    console.log("Type set to: "+type);
}

function headSelector(){
    //console.log("headSelector");
    var headingEl = document.getElementById("headings");
    var index = headingEl.selectedIndex;
    //console.log(index);
    if(index == 1)
    {
        createMessageBox(document.getElementById("headingCell"),"headingMsgBox");
    }
    else if(index >1){
        if(msgBoxHead) {
            document.getElementById("headingMsgBox").remove();
            msgBoxHead = false;
        }
        var msgHead = headingEl.options[index].id;
        type = headingEl.options[index].className;
        var msgEl = document.getElementById("message");
        var opt = document.createElement("option");
        var notMessage="";
        clearSelector(msgEl);
        console.log("--------------------")
        notMessage = msg[type][msgHead]["message"];
        console.log("type: "+type+"\tHead: "+msgHead+"\tMessage: "+notMessage);
        console.log("--------------------");

        opt.setAttribute("value",notMessage);
        //opt.setAttribute("id",i);
        msgEl.append(opt);
        opt.innerHTML = notMessage;
    }
}

function loadHeadings(messages,type){
    var headingEl = document.getElementById("headings");
    for(i in messages)
    {
       // console.log(messages[i].heading);
        var head = messages[i].heading;
        var opt = document.createElement("option");
        opt.setAttribute("value",head);
        opt.setAttribute("id",i);
        opt.setAttribute("class",type)
        headingEl.append(opt);
        opt.innerHTML = head;
    }
}

function msgSelector(){
    var headingEl = document.getElementById("message");
    var index = headingEl.selectedIndex;
    //console.log(index);
    //console.log("msg selector");
    if(index == 1)
    {
        createMessageBox(document.getElementById("messageCell"),"messageMsgBox");
    }
    else{
        if(msgBoxMessage) {
            document.getElementById("messageMsgBox").remove();
            msgBoxHead = false;
        }
    }
}

function createMessageBox(el,name) {
    var inputBox = document.createElement("textarea");
    inputBox.setAttribute("id",name);
   // inputBox.setAttribute("type","text");
    inputBox.setAttribute("class","inputBox");
    inputBox.setAttribute("placeHolder","Enter your custom message here");
    if(name=="headingMsgBox")
    {
        inputBox.setAttribute("maxlength",50);
        msgBoxHead = true;
    }
    else{
        inputBox.setAttribute("maxlength",350);
        msgBoxMessage = true;
    }
    el.append(inputBox);
}

function ajax(data, callback){
    var req = new XMLHttpRequest();
    req.onreadystatechange = function()
    {
        if(req.readyState == 4 && req.status == 200)
        {
            var json = JSON.parse(req.responseText);
            //var json = this.responseText;
            callback(json);
        }
        /*else{
            var json = JSON.parse(req.responseText);
            //var json = this.responseText;
            callback(json);
        }*/
    };
    req.open("POST", "notificationAPI.php", true);
    // This is important for POST requests with data that is not submitted via a form.
    req.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    req.send(parameterize(data));
}

function parameterize(data){
    var result = [];
    for(var d in data)
    {
        result.push(encodeURIComponent(d) + '=' + encodeURIComponent(data[d]));
    }
    return result.join('&');
}

function clearPage() {
    if(msgBoxMessage) {
        document.getElementById("messageMsgBox").remove();
        msgBoxHead = false;
    }

    if(msgBoxHead) {
        document.getElementById("headingMsgBox").remove();
    }

    document.getElementById("notificationType").selectedIndex=0;
    document.getElementById("headings").selectedIndex=0;
    document.getElementById("message").selectedIndex=0;
    document.getElementById("email").value = "";
    document.getElementById("deviceID").value = "";

    document.getElementById("email").style.backgroundColor = "white";
    document.getElementById("email").style.color = "black";
    document.getElementById("deviceID").style.backgroundColor = "white";
    document.getElementById("deviceID").style.color = "black";
    document.getElementById("notificationType").style.backgroundColor = "white";
    document.getElementById("notificationType").style.color = "black";

}

function sendData() {
    var subject="",message="",email="",deviceID="";
    type = document.getElementById("notificationType").value;
    deviceID = document.getElementById("deviceID").value;
    if(msgBoxHead){
        subject = document.getElementById("headingMsgBox").value;
    }
    else {
        subject = document.getElementById("headings").value;
    }
    if(msgBoxMessage){
        message = document.getElementById("messageMsgBox").value;
    }
    else {
        message = document.getElementById("message").value;
    }
    canEmail = false;
    email = document.getElementById("email").value;
    var ex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/ ;// /^(([^<>()\[\] \\.,;: \s@"]+(\. [^<>() \[\] \\.,;: \s@"]+)*)|(".+"))@((\[ [0-9]{1,3}\. [0-9]{1,3}\. [0-9]{1,3}\. [0-9]{1,3}\] )|(([a-zA-Z\-0-9]+\. )+[a-zA-Z]{2,}))$/;
    if(email.match(ex)){
        canEmail = true;
    }

    canDevice = false;
    if(deviceID.length>0){
        canDevice = true;
    }

    var canSend = true;

    if(type>2) {
        if(!canEmail){
            canSend = false;
            document.getElementById("email").style.backgroundColor = "maroon";
            document.getElementById("email").style.color = "white";
        }
        if(!canDevice){
            canSend = false;
            document.getElementById("deviceID").style.backgroundColor = "maroon";
            document.getElementById("deviceID").style.color = "white";
        }
    }
    else if(type == 2 && !canDevice){
        canSend = false;
        document.getElementById("deviceID").style.backgroundColor = "maroon";
        document.getElementById("deviceID").style.color = "white";
    }
    else if(type == 1 && !canEmail)
    {
        canSend = false;
        document.getElementById("email").style.backgroundColor = "maroon";
        document.getElementById("email").style.color = "white";
    }
    else if(type ==0)
    {
        canSend = false;
        document.getElementById("notificationType").style.backgroundColor = "maroon";
        document.getElementById("notificationType").style.color = "white";
    }

    if(canSend)
    {
        /** PARAMETERS:
         * 1. key: required = API key
         * 2. getMessages (**optional** type must be sent if getMessages not sent) = for retrieving template data
         * 2. type (**optional** getMessages must be sent if type not sent ) = Message type: email, push, both
         * 3. email (optional) = User's email
         * 4. deviceID (optional) = User's device ID
         * 5. msg (required if type is sent) = Message body of notification
         * 6. heading (required if type is sent)
         */
        var key = "3e30630d-239b-488d-8938-b9305dff3e54";
        ajax(
            {
                "key":key,
                "type":type,
                "email":email,
                "deviceID":deviceID,
                "msg":message,
                "heading":subject
            },
            function (data) {
                    alert(data.message);
            }
            );

    }
    else {
        alert("Please enter all relevant fields");
    }
}