class SubTask {
  int _id;
  int _taskId;
  String _name;
  SubTask(this._taskId, this._name);
  //This is during editing(Called with Id)
  SubTask.withId(this._id, this._taskId, this._name);

//All the Getters(Controls the Data Asked By another method from this Class)
  int get id {
    return _id;
  }

  int get taskId => _taskId;
  String get name => _name;

//These are all the Setters
  set name(String newName) {
    if (newName.length <= 255) {
      this._name = newName;
    }
  }

  set taskId(int newTaskId) {
    this._taskId = newTaskId;
  }

//Used to Save and Retrive from the Database
//Converting the Note Object into Map Object
  Map<String, dynamic> toMap() {
    //This is an Map Object
    var map = Map<String, dynamic>();
    //This means Already Created in the Database
    if (id != null) {
      map['id'] = _id;
    }
    map['taskId'] = _taskId;
    map['name'] = _name;
    return map;
  }

  SubTask.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._taskId = map['taskId'];
    this._name = map['name'];
  }
}
