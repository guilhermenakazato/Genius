import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/logging_interceptors.dart';

final Client client = HttpClientWithInterceptor.build(
    interceptors: [LoggingInterceptor()], requestTimeout: Duration(seconds: 10));

final String baseUrl = "http://192.168.1.9:3333";
