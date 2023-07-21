import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';

MultipartFile convertToMultipartFile(PlatformFile file) {
  return MultipartFile.fromBytes(
    file.bytes!,
    filename: file.name,
    contentType: MediaType(file.extension!, '*'),
  );
}