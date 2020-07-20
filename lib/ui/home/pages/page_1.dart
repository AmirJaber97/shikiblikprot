import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shik_i_blisk/constants/app_colors.dart';
import 'package:shik_i_blisk/constants/app_styles.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final List<Widget> _pages = <Widget>[
    _buildPage('sub_1', 'Sub Page 1'),
    _buildPage('sub_2', 'Sub Page 2'),
    _buildPage('sub_3', 'Sub Page 3'),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: IconButton(
                  icon: Hero(
                    tag: 'faq',
                    child: Icon(
                      Icons.info_outline,
                      color: kWhiteColor,
                      size: 40.sp,
                    ),
                  ),
                  onPressed: () {

                      navigator.push(MaterialPageRoute(
                        builder: (BuildContext context) {
                          return Scaffold(
                            backgroundColor: Colors.purple,
                            body: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Hero(
                                    tag: "faq",
                                    child: Icon(
                                      Icons.info_outline,
                                      color: kWhiteColor,
                                      size: 50.sp,
                                    ),
                                  ),
                                  Text('FAQ', style: text(40.sp, color: kWhiteColor, fw: FontWeight.bold),)
                                ],
                              ),
                            ),
                          );
                        },
                      ));



                  },
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 50.0, bottom: 50.0),
                child: Text(
                  "Page 1",
                  style: text(24.sp, fw: FontWeight.bold, color: kWhiteColor),
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 65.0),
              child: Stack(
                children: <Widget>[
                  PageView.builder(
                    itemCount: 3,
                    controller: _controller,
                    itemBuilder: (BuildContext context, int index) {
                      return _pages.elementAt(index);
                    },
                  ),
                  Positioned(
                    bottom: 30.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: new Center(
                        child: new DotsIndicator(
                          controller: _controller,
                          itemCount: _pages.length,
                          color: kBlackColor,
                          onPageSelected: (int page) {
                            _controller.animateToPage(
                              page,
                              duration: _kDuration,
                              curve: _kCurve,
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static _buildPage(String tag, String pageName) {
    return Container(
      color: kWhiteColor,
      child: Center(
          child: Hero(
              tag: tag,
              child: GestureDetector(
                onTap: () {
                  navigator.push(MaterialPageRoute(
                    builder: (BuildContext context) {
                      return buildSubPages(tag, pageName);
                    },
                  ));
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Text(
                        pageName,
                        style: text(14.sp, color: kWhiteColor),
                      ),
                    )),
              ))),
    );
  }

  static buildSubPages(String tag, String subPageName) {
    return SafeArea(
      child: Scaffold(
        body: Hero(
          tag: tag,
          child: Container(
            color: Colors.purple,
            child: Material(
              color: Colors.transparent,
              child: Flexible(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 24.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: kWhiteColor,
                              size: 40.sp,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 50.0, bottom: 50.0),
                          child: Text(
                            subPageName,
                            style: text(24.sp,
                                fw: FontWeight.bold, color: kWhiteColor),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
