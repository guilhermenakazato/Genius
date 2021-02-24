// deixando a exceção mais específica
class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
