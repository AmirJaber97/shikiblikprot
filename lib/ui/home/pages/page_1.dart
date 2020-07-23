import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shik_i_blisk/constants/app_colors.dart';
import 'package:shik_i_blisk/constants/app_styles.dart';
import 'package:shik_i_blisk/ui/home/pages/components/indicator.dart';

import '../../../constants/app_colors.dart';

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
          _buildHeader(),
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height - 260.h,
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
                        bottom: 30.h,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: DotsIndicator(
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
                      return GestureDetector(
                        onTap: () => Get.back(),
                        child: Scaffold(
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
                                Text(
                                  'FAQ',
                                  style: text(40.sp,
                                      color: kWhiteColor, fw: FontWeight.bold),
                                )
                              ],
                            ),
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
      ],
    );
  }

  static _buildPage(String tag, String pageName) {
    return Expanded(
      child: Container(
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Text(
                          pageName,
                          style: text(14.sp, color: kWhiteColor),
                        ),
                      )),
                ))),
      ),
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
