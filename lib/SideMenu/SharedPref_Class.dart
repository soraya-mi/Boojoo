import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  MySharedPreferences._privateConstructor();

  static final MySharedPreferences instance =
  MySharedPreferences._privateConstructor();


  Future<void>addStringToSF(String stringKey, String stringValue) async {
    print("in ass string to sf"+stringKey+"/////"+stringValue);
    SharedPreferences myPrefs  = await SharedPreferences.getInstance();
    myPrefs.setString(stringKey,stringValue);
  }

  Future<void>addIntToSF(String stringKey, int intValue) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setInt(stringKey,intValue);
  }

  Future<void>addBoolToSF(String stringKey , bool boolValue) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setBool(stringKey,boolValue);
  }

  Future<void>addDoubleToSF(String stringKey, double doubleValue) async {
    SharedPreferences myPrefs  = await SharedPreferences.getInstance();
    myPrefs.setDouble(stringKey,doubleValue);
  }

  //read prefrences from mobile
  Future<String>getStringValuesSF(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    //Return String
    // String stringValue = await myPrefs .getString(key);
    // print(stringValue.runtimeType);
    //
    // return stringValue.toString();
    return await myPrefs .getString(key);

  }
  Future<bool>getBoolValuesSF(String key) async {
    SharedPreferences myPrefs   = await SharedPreferences.getInstance();
    //Return bool

    bool boolValue = myPrefs .getBool(key);
    return boolValue;
  }
  Future<int>getIntValuesSF(String key) async {
    SharedPreferences myPrefs  = await SharedPreferences.getInstance();
    //Return int
    int intValue = myPrefs .getInt(key);
    return intValue;
  }
  Future<double>getDoubleValuesSF(String key) async {
    SharedPreferences myPrefs   = await SharedPreferences.getInstance();
    //Return double
    double doubleValue = myPrefs .getDouble(key);
    return doubleValue;
  }

  Future<void>removeValuesString(String ValueToBeDelete) async {
    SharedPreferences myPrefs  = await SharedPreferences.getInstance();
    myPrefs.remove(ValueToBeDelete);
  }


  Future<void>removeValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.remove(key);
  }

  Future<void>removeAll() async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.clear();
  }

}