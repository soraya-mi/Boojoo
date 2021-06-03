class MoodTracker {
  int _id;

  String _date;
  int _mood;
  MoodTracker(this._date, this._mood);
  MoodTracker.withId(this._id, this._date, this._mood);
  //getters
  int get id {
    return _id;
  }

  String get date => _date;
  int get mood => _mood;
  //setters
  set date(String newDate) {
    if (newDate.length <= 255) {
      this._date = newDate;
    }
  }

  set mood(int newMood) {
    this._mood = newMood;
  }

  //Used to Save and retrieve from the Database
//Converting the Moodtracker Object into Map Object
  Map<String, dynamic> toMap() {
    //This is an Map Object
    var map = Map<String, dynamic>();
    //This means Already Created in the Database
    if (id != null) {
      map['id'] = _id;
    }
    map['date'] = _date;
    map['mood'] = _mood;

    return map;
  }

  MoodTracker.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._date = map['date'];
    this._mood = map['mood'];
  }
}