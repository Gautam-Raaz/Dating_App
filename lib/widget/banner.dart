import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageBanner extends StatefulWidget {

  List<String> imageUrls;

   ImageBanner({super.key,required this.imageUrls});



  @override
  _ImageBannerState createState() => _ImageBannerState();
}

class _ImageBannerState extends State<ImageBanner> {
  // final List<String> imageUrls = [
  //   'https://picsum.photos/id/1015/600/300',
  //   'https://picsum.photos/id/1016/600/300',
  //   'https://picsum.photos/id/1018/600/300',
  //   'https://picsum.photos/id/1020/600/300',
  // ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          CarouselSlider(
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: widget.imageUrls.map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imageUrls.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => {}, // Optional: jump to that slide
                child: Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key
                        ? Colors.purple
                        : Colors.grey,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
