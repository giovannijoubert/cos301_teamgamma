function validation()
{
	var users = ["Premodial", "Thamsanqa", "Lindo","Zoe"]
	var name = document.getElementById('lemail').value;
	var found = false;
	for(var i = 0; i < users.length; i++)
	{
		if(users[i] == name)
		{
			found = true;
		}
	}
		    if(found)
		    {
		    	alert("Log in successful");
                document.location = "Explore.html";
		    }
		    if(found === false)
		    {
		    	alert("Log in unsuccessful, Username is incorrect!")
		    }
	
}
