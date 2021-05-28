class APIresponse<T>{
  T data;
  bool error;
  String errormassege;

  APIresponse({this.data, this.error = false, this.errormassege});
}