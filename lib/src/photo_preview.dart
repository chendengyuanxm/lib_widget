import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoPreview extends StatefulWidget {
  final List<String?> photoList;
  final int index;

  PhotoPreview({required this.photoList, this.index = 0});

  @override
  _PhotoPreviewState createState() => _PhotoPreviewState();
}

class _PhotoPreviewState extends State<PhotoPreview> {
  int currentIndex = 0;
  late int initialIndex;
  late int length;
  late int title;

  @override
  void initState() {
    currentIndex = widget.index;
    initialIndex = widget.index;
    length = widget.photoList.length;
    title = initialIndex + 1;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
      title = index + 1;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height,
            ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: PhotoViewGallery.builder(
                    scrollDirection: Axis.horizontal,
                    scrollPhysics: const BouncingScrollPhysics(),
                    builder: (BuildContext context, int index) {
                      String image = widget.photoList[index] ?? '';
                      bool isUrl = image.startsWith('http');
                      ImageProvider imageProvider;
                      if (isUrl) {
                        imageProvider = CachedNetworkImageProvider(image);
                      } else {
                        imageProvider = FileImage(File(image));
                      }
                      return PhotoViewGalleryPageOptions(
                        imageProvider: imageProvider,
                        initialScale: PhotoViewComputedScale.contained * 1,
                        minScale: PhotoViewComputedScale.contained * 0.5,
                      );
                    },
                    itemCount: widget.photoList.length,
                    // loadingChild: widget.loadingChild,
                    backgroundDecoration: BoxDecoration(
                      color: Colors.black87,
                    ),
                    pageController: PageController(initialPage: initialIndex),
                    onPageChanged: onPageChanged,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  // child: Text(
                  //   "Image ${currentIndex + 1}",
                  //   style: const TextStyle(color: Colors.white, fontSize: 14.0, decoration: null),
                  // ),
                )
              ],
            )),
      ),
    );
  }
}
