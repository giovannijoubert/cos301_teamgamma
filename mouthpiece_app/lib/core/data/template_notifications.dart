 var notifications = [ 
  {
    "localNotifications" : [
      {
        "finished_download":{
          "message":"Your new mouth has finished downloading",
          "options":["try", "dismiss"]
        },
      }, {
        "nearing_capacity": {
          "message":"Your phone is at/near its maximum storage capacity, perhaps deleting some mouth could free up some space",
          "options":["view mouths", "dismiss"]
        },
      }, {
        "dyk_custom_mouths": {
          "message":"Did you know: You can create your own custom mouths",
          "options":["dismiss"]
        },
      }, { 
        "dyk_listening_modes":{
          "message":"Did you know: There are 2 modes for mouth usage, volume based and formant based",
          "options":["dismiss"]
        },
      }, {
        "dyk_downloading_mouths": {
          "message":"Did you know: There is a whole community creating custom mouths for you to download and use",
          "options": ["dismiss"]
        },
      }, {
        "dyk_uploading_mouths": {
          "message":"Did you know: You can upload your custom mouths and let others download and use them",
          "options":["dismiss"]
        }
      }
    ]
  }, {
    "networkNotifications": [
      {
        "download_milestone_10":{
          "message":"Your uploaded mouth has been downloaded 10 times!",
          "options":["view mouth", "dismiss"]
        },
      }, {
        "download_milestone_100":{
          "message":"Your uploaded mouth has been downloaded 100 times!",
          "options":["view mouth", "dismiss"]
        }, 
      }, {
        "download_milestone_1000":{
          "message":"Your uploaded mouth has been downloaded 1000 times!",
          "options":["view mouth", "dismiss"]
        },
      }, {
        "rated_mileston_10":{
          "messsage":"A mouth you rated is in the top 10",
          "options":["view mouth", "dismiss"]
        },
      }, {
        "rated_mileston_100":{
          "messsage":"A mouth you rated is in the top 100",
          "options":["view mouth", "dismiss"]
        },
      }, {
        "rated_mileston_1000":{
          "messsage":"A mouth you rated is in the top 1000",
          "options":["view mouth", "dismiss"]
        },
      }
    ]
  }, {
    "emailNotifications": [
      {
        "reset_password": {
          "message":"A password reset has been requested for john123. Please follow this link to reset your password: teamgamma.ga",
          "arguments": {
            "john123":"username",
            "teamgamma.ga":"reset link"
          }
        } 
      }, {
        "signup_confirmation": {
          "message":"Welcome john123, to Mouthpiece. Please follow this link to confirm that you are in fact human: apples.com",
          "arguments": {
            "john123":"username",
            "apples.com":"signup confirmation link"
          }
        }
      }
    ] 
  }
];