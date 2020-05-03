class User {
    final String theme;
    
    User({this.theme});

    User.initial()
      : theme ='';

    factory User.fromJson()
    {
      return User(  
      );
    }



  //   Map<String, dynamic> toJson() {
  //     final Map<String, dynamic> data = new Map<String, dynamic>();
  //     data['email'] = this.email;
  //     data['password'] = this.password;
  //     return data;
  // }

}