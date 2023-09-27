import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final datasetFileProvider = StateProvider<StateController<PlatformFile?>>((ref) => StateController<PlatformFile?>(null));
