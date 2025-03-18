// lib/services/dio_client.dart
import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient({Dio? dio})
      : dio = dio ??
            Dio(BaseOptions(
              // Vous pouvez définir des options communes ici
              connectTimeout: Duration(milliseconds: 5000),
              receiveTimeout: Duration(milliseconds: 3000),
            )) {
    // Exemple d'interceptor (facultatif)
    dio?.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Par exemple, ajouter des headers si besoin
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
    ));
  }
}
