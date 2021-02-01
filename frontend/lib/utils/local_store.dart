import 'package:get_storage/get_storage.dart';

class LocalStore {
  // inicializando o storage
  final _box = GetStorage();

  void store(String token) {
    _box.write("token", token);
  }

  void removeFromStorage() {
    _box.remove("token");
  }

  String getFromStorage() {
    return _box.read("token") ?? "none";
  }
}
