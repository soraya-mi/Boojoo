class joinpublicinfo {
  int challenge_id;
  int user_id;

  joinpublicinfo({this.challenge_id,  this.user_id});

  Map<String, dynamic> toJson() {
    return {
      "user_id": user_id,
      "challenge_id": challenge_id,
    };
  }
}
