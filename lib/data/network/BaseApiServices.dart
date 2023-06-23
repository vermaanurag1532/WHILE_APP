// ignore: file_names
abstract class BaseApiServices{

  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url,dynamic data);
}