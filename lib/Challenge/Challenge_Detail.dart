class challengedetail {
  int  likenumber;
  String startdate, enddate;
  String  title, description, private_pub, progress_type;
  List  days;

  challengedetail({ this.title, this.description, this.likenumber, this.startdate, this.days,
    this.enddate, this.progress_type, this.private_pub});

  factory challengedetail.fromJson(Map <String, dynamic> i){
    return challengedetail(
        description: i['description'],
        likenumber: i['like-number'],
        //days: i['days'],
        //startdate: i['start_date'],
        //enddate: i['end_date'],
        days: i['days'],
        progress_type: i['progress_type'],
        private_pub: i['private_public_type']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      //"users": users,
      "title": title,
      "description": description,
      "like_number": likenumber,
      "days": days,
      "start_date": startdate,
      "end_date": enddate,
      "progress_type": progress_type,
      //"icon": icon,
      //"owner_id": ownerid,
      //"cat_id": catid,
      "private_public_type": private_pub,
      //"category": category,
      //"created_at": createtime,
      //"updated_at": updatetime
    };
  }
}