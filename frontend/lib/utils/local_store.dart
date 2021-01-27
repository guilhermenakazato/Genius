import 'package:get_storage/get_storage.dart';

class LocalStore {
  final box = GetStorage();

  // TODO: documentar
  void store(String token) {
    box.write("token", token);
  }

  // TODO: documentar
  void removeFromStorage() {
    box.remove("token");
  }

  // TODO: documentar
  String getFromStorage() {
    return box.read("token") ?? "none";
  }
}
