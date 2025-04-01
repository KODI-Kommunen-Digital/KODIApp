import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:photo_view/photo_view.dart';

class ForumImageZoomScreen extends StatefulWidget {
  final String imageUrl;

  const ForumImageZoomScreen({super.key, required this.imageUrl});

  @override
  State<ForumImageZoomScreen> createState() => _ForumImageZoomScreenState();
}

class _ForumImageZoomScreenState extends State<ForumImageZoomScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                height: height * 0.8,
                child: widget.imageUrl.contains('.pdf')
                    ? const PDF().cachedFromUrl(
                        widget.imageUrl,
                        placeholder: (progress) =>
                            Center(child: Text('$progress %')),
                        errorWidget: (error) => Center(
                          child: Text(
                            error.toString(),
                          ),
                        ),
                    whenDone: (a) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        setState(() {});
                      });
                    })
                    : PhotoView(
                        imageProvider: CachedNetworkImageProvider(
                            widget.imageUrl.contains('admin/News.jpeg')
                                ? widget.imageUrl
                                : widget.imageUrl.contains('instagram')
                                    ? widget.imageUrl
                                    : widget.imageUrl),
                        minScale: PhotoViewComputedScale.contained * 0.8,
                        maxScale: PhotoViewComputedScale.covered * 2.0,
                        initialScale: PhotoViewComputedScale.contained,
                      ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(
                      context); // Navigate back when the button is pressed
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
