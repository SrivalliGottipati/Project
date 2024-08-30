import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Api_Urls.dart';

class UserApiController{
  Future<Map<String,dynamic>> getUserByPage(int page)async{
    try{
      String url = apiUrls.reqresbaseurl+"users?page=$page";
      final res = await http.get(Uri.parse(url));
      if(res.statusCode == 200){
        return jsonDecode(res.body);
      }
      return {};
    }
    catch(err){
      return {};
    }
  }
}

