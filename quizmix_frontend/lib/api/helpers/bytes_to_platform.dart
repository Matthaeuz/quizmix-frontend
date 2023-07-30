import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

PlatformFile bytesToPlatform(Uint8List bytes) {
  return PlatformFile(
    bytes: bytes,
    name: 'selected_image.jpg',
    size: bytes.length,
  );
}