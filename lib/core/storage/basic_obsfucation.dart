import 'dart:convert';
import 'dart:typed_data';

mixin BasicObsfucation {
  static const String keyCode = 'cheating is not good for your health';
  late final Uint8List key = _generateKey();

  Uint8List _generateKey() {
    final utf8Bytes = utf8.encode(keyCode);
    final key = Uint8List(4);
    for (var i = 0; i < utf8Bytes.length; i++) {
      key[i % key.length] += utf8Bytes[i];
    }

    return key;
  }

  String obsfucate(String text) {
    final bytes = utf8.encode(text);
    for (var i = 0; i < bytes.length; i++) {
      bytes[i] ^= key[i % key.length];
    }

    return base64.encode(bytes);
  }

  String deobsfucate(String text) {
    final bytes = base64.decode(text);
    for (var i = 0; i < bytes.length; i++) {
      bytes[i] ^= key[i % key.length];
    }

    return utf8.decode(bytes);
  }
}
