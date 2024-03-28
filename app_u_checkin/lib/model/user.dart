class User {
  String? email;
  String? password;
  String? name;
  String? nameEnglish;
  String? dOB;
  String? position;
  String? team;
  String? avatar;

  User(
      {this.email,
      this.password,
      this.name,
      this.nameEnglish,
      this.dOB,
      this.position,
      this.team,
      this.avatar});

  factory User.formJson(Map<String, dynamic> json) => User(
        email: json["email"],
        password: json["password"],
        name: json["name"],
        nameEnglish: json["nameEnglish"],
        dOB: json["dOB"],
        position: json["position"],
        team: json["team"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "name": name,
        "nameEnglish": nameEnglish,
        "dOB": dOB,
        "position": position,
        "team": team,
        "avatar": avatar
      };
}
