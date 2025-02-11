import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loggy/loggy.dart';
import 'package:permission_handler/permission_handler.dart';
class ForumGroupImageUpload extends StatefulWidget {
  final String? image;
  final Function(String?) onChange;
  const ForumGroupImageUpload({
    super.key,
    this.image,
    required this.onChange,
  });
  @override
  State<ForumGroupImageUpload> createState() => _ForumGroupImageUploadState();
}
class _ForumGroupImageUploadState extends State<ForumGroupImageUpload> {
  final _picker = ImagePicker();
  String? _image;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    DecorationImage? decorationImage;
    if (_image != null) {
      decorationImage = DecorationImage(
        image: FileImage(
          File(_image!),
        ),
        fit: BoxFit.cover,
      );
    }
    BoxDecoration decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      image: decorationImage,
    );
    return InkWell(
      onTap: _uploadImage,
      child: Stack(
        children: [
          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(8),
            color: Theme.of(context).primaryColor,
            child: Container(
              decoration: decoration,
              alignment: Alignment.center,
              child: _buildContent(),
            ),
          ),
          Visibility(
            visible: _image != null,
            child: Positioned(
              top: -10,
              right: -10,
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.red[900],
                ),
                onPressed: () {
                  setState(() {
                    _image = null;
                    widget.onChange(null);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _uploadImage() async {
    PermissionStatus statusImage;
    statusImage = await Permission.photos.status;
    statusImage = await Permission.photos.request();
    try {
      if (statusImage == PermissionStatus.granted ||
          statusImage == PermissionStatus.limited) {
        final pickedFile = await _picker.pickImage(
          source: ImageSource.gallery,
        );
        if (pickedFile == null) return;
        if (!mounted) return;
        setState(() {
          _image = pickedFile.path;
          widget.onChange(_image); // Notify parent widget of the selected file.
        });
      } else if (statusImage == PermissionStatus.denied) {
        await Permission.photos.request();
      } else if (statusImage == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      }
    } catch (e) {
      logError('Image Upload Permission Error', e);
    }
  }
  Widget? _buildContent() {
    String uniqueKey = UniqueKey().toString();
    if (_image == null && widget.image == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(Translate.of(context)
              .translate('upload_feature_image')), // Translated text
          const Icon(
            Icons.add,
            size: 24,
            color: Colors.white,
          ),
        ],
      );
    } else {
      if (_image == null && widget.image != null) {
        return SizedBox(
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl:
                "${Application.picturesURL}${widget.image!}?cacheKey=$uniqueKey",
            fit: BoxFit.cover,
          ),
        );
      }
      return const SizedBox();
    }
  }
}