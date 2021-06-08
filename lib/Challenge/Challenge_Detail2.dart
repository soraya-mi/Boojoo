class challengedetail2 {
  int  likenumber, id, owner;
  String icon, category, password;
  String startdate, enddate;
  String  title, description, private_pub, progress_type;
  List  days, users;

  challengedetail2({ this.title, this.id, this.owner, this.icon, this.description, this.likenumber, this.startdate, this.days,
    this.users, this.category, this.password, this.enddate, this.progress_type, this.private_pub});

  factory challengedetail2.fromJson(Map <String, dynamic> i){
    return challengedetail2(
      id : i['id'],
      title: i['title'],
      owner: i['owner'],
      description: i['description'],
      likenumber: i['like_number'],
      icon: i['icon'],
      category: i['category'],
      startdate: i['start_date'],
      enddate: i['end_date'],
      days: i['days'],
      progress_type: i['progress_type'],
      private_pub: i['private_public_type'],
      users: ['users'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      //"users": users,
      "title": title,
      "description": description,
      // "like_number": likenumber,
      "days": days,
      "start_date": startdate,
      "end_date": enddate,
      "progress_type": progress_type,
      // "icon": icon,
      //"owner_id": ownerid,
      //"cat_id": catid,
      "private_public_type": private_pub,
      "categories": category,
      "password" : password
      //"created_at": createtime,
      //"updated_at": updatetime
    };
  }
}