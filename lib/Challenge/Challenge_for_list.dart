class challenge_for_list {
  int id, likenumber;
  DateTime startdate, enddate;
  String  title, icon, private_pub;
  List category;

  challenge_for_list({this.id, this.title, this.likenumber, this.startdate,
      this.enddate, this.icon, this.private_pub});

  factory challenge_for_list.fromJson(Map <String, dynamic> i){
  return challenge_for_list(
  id: i['id'],
  title: i['title'],
  likenumber: i['like-number'],
  startdate: i['start_date'] != null ? DateTime.parse(i['start_date']) : null,
  enddate: i['end_date'] != null ? DateTime.parse(i['end_date']) : null,
  icon: 'images/1.jpg',    //i['icon'],
  private_pub: i['private_public_type']
  );
  }

}