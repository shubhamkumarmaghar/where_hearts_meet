abstract class WHMRepository{

  Future<dynamic> getApiCall({required String url,required String pathParam});

  Future<dynamic> postApiCall({required String url,required Map<String,dynamic> body});

  Future<dynamic> putApiCall({required String url,required Map<String,dynamic> body});

  Future<dynamic> deleteApiCall({required String url,required String pathParam});


}