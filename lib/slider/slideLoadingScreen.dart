class SliderModelLoading{
  String ImagePath;
  String title;
  String desc;
  SliderModelLoading({this.ImagePath,this.title,this.desc});
  //setters for image , title and description
  void SetImageAssetPath(String getImagePath){
    ImagePath=getImagePath;
  }
  void Settitle(String getTitle){
    title=getTitle;
  }
  void Setdescription(String getDesc){
    desc=getDesc;
  }
  //getters for image,tutle , description
  String GetImageAssetPath(){
    return ImagePath;
  }
  String GetTitle(){
    return title;
  }
  String Getdescription(){
    return desc;
  }
}
List<SliderModelLoading>getSlides(){
  List<SliderModelLoading>slideLoadingScreen=new List<SliderModelLoading>();
  SliderModelLoading loadingScrenn=new SliderModelLoading();
  //first slide is the todolist
  loadingScrenn.SetImageAssetPath('assets/bozhoo.gif');
  loadingScrenn.Settitle('بوژووو');
  loadingScrenn.Setdescription('!...ّبولت ژورنال شخصی شما');
  slideLoadingScreen.add(loadingScrenn);//add first slide to the set of slides


  return slideLoadingScreen;
}
