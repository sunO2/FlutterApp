

class LogUtils{
  static log(String message){
    try{
      assert(false);
    }catch(e){
      print(message + e.toString());
    }

  }
}