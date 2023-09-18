import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/bytes_to_platform.dart';
import 'package:quizmix_frontend/api/utils/multipart_form_handlers/update_user.utils.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/reviewees/current_viewed_reviewee_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';
import 'package:quizmix_frontend/views/modals/view_reviewee_recent_attempts_modal.dart';
import 'package:quizmix_frontend/views/modals/view_reviewee_top_categories_modal.dart';
import 'package:quizmix_frontend/views/widgets/view_reviewee_profile/reviewee_recent_attempts.dart';
import 'package:quizmix_frontend/views/widgets/view_reviewee_profile/reviewee_top_categories.dart';

class ViewRevieweeProfileScreen extends ConsumerStatefulWidget {
  const ViewRevieweeProfileScreen({Key? key}) : super(key: key);

  @override
  ViewRevieweeProfileScreenState createState() =>
      ViewRevieweeProfileScreenState();
}

class ViewRevieweeProfileScreenState
    extends ConsumerState<ViewRevieweeProfileScreen> {
  static const BoxConstraints detailsBoxConstraintsA = BoxConstraints(
    minWidth: 400.0,
    minHeight: 800.0,
    maxHeight: 800.0,
    maxWidth: 600.0,
  );
  static const BoxConstraints detailsBoxConstraintsB = BoxConstraints(
    minWidth: 400.0,
    minHeight: 600.0,
    maxWidth: 600.0,
  );

  bool isChanged = false;
  Uint8List? selectedImageBytes;
  ImageProvider? imageProvider;

  @override
  void initState() {
    super.initState();

    final revieweeDetails = ref.read(currentViewedRevieweeProvider);

    if (revieweeDetails.image != null && revieweeDetails.image!.isNotEmpty) {
      imageProvider = NetworkImage(revieweeDetails.image!);
    }
  }

  void _selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      ImageProvider<Object> image = MemoryImage(file.bytes!);
      setState(() {
        imageProvider = image;
        selectedImageBytes = file.bytes;
        isChanged = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final revieweeDetails = ref.watch(currentViewedRevieweeProvider);
    final modalState = ref.watch(modalStateProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Scaffold(
          appBar: null,
          body: SingleChildScrollView(
            child: Container(
              width: screenWidth,
              color: AppColors.secondaryColor,
              padding: EdgeInsets.fromLTRB(
                  0, screenHeight * 0.05, 0, screenHeight * 0.05),
              child: Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    width: 400,
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () async {
                            PlatformFile? imageFile;
                            if (isChanged && imageProvider != null) {
                              imageFile = bytesToPlatform(selectedImageBytes!);
                            }
                            if (isChanged) {
                              updateUser(imageFile, ref).then((value) {
                                Navigator.pop(context);
                              });
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            alignment: Alignment.centerLeft,
                            foregroundColor: AppColors.white,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_back,
                                size: 16.0,
                                color: AppColors.white,
                              ),
                              Text('Back to Home'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Circle Picture
                        Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 16,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              ClipOval(
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: user.id == revieweeDetails.id
                                      ? _selectImage
                                      : null,
                                  child: Image(
                                    width: 180,
                                    height: 180,
                                    image: imageProvider ??
                                        const AssetImage(
                                            "lib/assets/images/default_pic.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              imageProvider != null
                                  ? Positioned(
                                      top: 0,
                                      right: 0,
                                      child: RawMaterialButton(
                                        onPressed: () {
                                          setState(() {
                                            imageProvider = null;
                                            isChanged = true;
                                          });
                                        },
                                        fillColor: AppColors.red,
                                        shape: const CircleBorder(),
                                        constraints: const BoxConstraints(
                                          minWidth: 36.0,
                                          minHeight: 36.0,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                      ))
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Name
                        Text(
                          revieweeDetails.fullName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                        const Text(
                          "Reviewee",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Email: ${revieweeDetails.email}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.9,
                    constraints:
                        screenHeight >= detailsBoxConstraintsA.minHeight
                            ? detailsBoxConstraintsA
                            : detailsBoxConstraintsB,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: const RevieweeTopCategories(),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: const RevieweeRecentAttempts(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        if (modalState == ModalState.preparingReview) ...[
          Scaffold(
            body: Container(
              color: AppColors.mainColor,
              child: const Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 48.0,
                        width: 48.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 6.0,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        "Preparing Review...",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ] else if (modalState == ModalState.viewRevieweeRecentAttempts) ...[
          Container(
            color: AppColors.fourthColor.withOpacity(0.8),
            child: const ViewRevieweeRecentAttemptsModal(),
          ),
        ] else if (modalState == ModalState.viewRevieweeTopCategories) ...[
          Container(
            color: AppColors.fourthColor.withOpacity(0.8),
            child: const ViewRevieweeTopCategoriesModal(),
          ),
        ]
      ],
    );
  }
}
