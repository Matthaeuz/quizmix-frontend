import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final pdfFileProvider = StateProvider.family<StateController<PlatformFile?>, String>((ref, type) => StateController<PlatformFile?>(null));
