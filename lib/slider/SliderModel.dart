class SliderModel{
  String ImagePath;
  String title;
  String desc;
  SliderModel({this.ImagePath,this.title,this.desc});
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
List<SliderModel>getSlides(){
  List<SliderModel>slideOnBoardingScreen=new List<SliderModel>();
  SliderModel slidermodelTodo=new SliderModel();
  //first slide is the todolist
  slidermodelTodo.SetImageAssetPath("assets/tood.png");
  slidermodelTodo.Settitle("تودو لیست");
  slidermodelTodo.Setdescription("تودو لیست بساز تا منظم بشی");
  slideOnBoardingScreen.add(slidermodelTodo);//add first slide to the set of slides


  SliderModel slidermodelHabit=new SliderModel();
  //second slide is the habit
  slidermodelHabit.SetImageAssetPath("assets/habit.png");
  slidermodelHabit.Settitle("عادت ها");
  slidermodelHabit.Setdescription("عادت هات را تیک بزن و ثبت کن ");
  slideOnBoardingScreen.add(slidermodelHabit);//add first slide to the set of slides

  SliderModel slidermodelChallenge=new SliderModel();
  //thirdt slide is the challenges
  slidermodelChallenge.SetImageAssetPath("assets/challesh.png");
  slidermodelChallenge.Settitle("چالش ها");
  slidermodelChallenge.Setdescription("عادت های خودت را به عنوان چالش با دیگران به اشتراک بگذار همچنین در چالش های دیگران شرکت کن");
  slideOnBoardingScreen.add(slidermodelChallenge);//add first slide to the set of slides

  return slideOnBoardingScreen;
}
