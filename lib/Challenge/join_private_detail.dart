class joinprivateinfo {
  int challenge_id;
  int user_id;
  String password;

  joinprivateinfo({this.challenge_id, this.password, this.user_id});

  Map<String, dynamic> toJson() {
    return {
      "user_id": user_id,
      "challenge_id": challenge_id,
      "password": password,
    };
  }
}

