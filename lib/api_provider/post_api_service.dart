import 'package:dio/dio.dart';
import '../model_classes/post_model_class.dart';
abstract class PostApiService {
  String baseUrl = 'https://jsonplaceholder.typicode.com/';
  String get endPoint;
  Dio dio = Dio();
  String get url => baseUrl + endPoint;
  Future getPosts() async {
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      var data = (response.data);
      return data;
    } else {
      print(response.statusMessage.toString());
      return response.statusMessage.toString();
    }
  }
}

class ApiProvider extends PostApiService {
  static ApiProvider? _apiProvider;
  ApiProvider._internal();
  factory ApiProvider() {
    return _apiProvider ??= ApiProvider._internal();
  }

  Future<List<PostApiClass>> fetch() async {
    var posts = await getPosts() as List;
    List<PostApiClass> p = posts.map((e) => PostApiClass.fromMap(e)).toList();
    return p;
  }

  @override
  String get endPoint => 'albums';
}
