import 'package:animate_icons/animate_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:get/get.dart';
import 'package:shik_i_blisk/app/localization.dart';
import 'package:shik_i_blisk/constants/app_colors.dart';
import 'package:shik_i_blisk/constants/app_routes.dart';
import 'package:shik_i_blisk/constants/app_strings.dart';
import 'package:shik_i_blisk/constants/app_styles.dart';
import 'package:shik_i_blisk/ui/home/home_viewmodel.dart';
import 'package:shik_i_blisk/ui/setup/app_base_widget.dart';
import 'package:shik_i_blisk/ui/setup/routes.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_routes.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin{
  String currentPage = RoutePaths.MainPage;

  var _panelController;
  AnimateIconController _animationController;
  bool isClosed = true;

  Widget generateCard(String tag, Color color, int notificationCount,
      String routePath, PanelController controller) {
    return Stack(
      children: <Widget>[
        Hero(
          tag: tag,
          child: Card(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: InkWell(
              onTap: () {
                controller.close();
                if (routePath != currentPage) {
                  Get.offAndToNamed(routePath, id: 0);
                  currentPage = routePath;
                }
              },
              child: Container(
                  height: 300.h,
                  width: 200.w,
                  color: color,
                  child: Center(child: Text(tag))),
            ),
            clipBehavior: Clip.antiAlias,
          ),
        ),
        notificationCount != null
            ? Positioned(
                top: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Colors.deepOrangeAccent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      notificationCount.toString(),
                      style: text(14.0, color: kWhiteColor),
                    ),
                  ),
                ))
            : SizedBox(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _panelController = PanelController();
    _animationController = AnimateIconController();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 360, height: 640);
    var locale = AppLocalizations.of(context);

    Widget page = Navigator(
      key: Get.nestedKey(0),
      initialRoute: RoutePaths.MainPage,
      onGenerateRoute: Routes.innerRoute,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(locale.translate(AppStrings.appName)),
      ),
      body: BaseWidget<HomeViewModel>(
        viewModel: HomeViewModel(),
        builder: (_, model, __) {
          List<Widget> items = [
            generateCard('home', Colors.purple, null, RoutePaths.MainPage,
                _panelController),
            generateCard('Page 1', Colors.orangeAccent, 21, RoutePaths.Page1,
                _panelController),
            generateCard('Page 2', Colors.greenAccent, 999, RoutePaths.Page2,
                _panelController),
            generateCard('Page 3', Colors.limeAccent, null, RoutePaths.Page3,
                _panelController),
          ];

          return SlidingUpPanel(
            backdropEnabled: true,
            parallaxEnabled: true,
            controller: _panelController,
            onPanelOpened: () {
              setState(() {
                isClosed = false;
              });
            },
            onPanelClosed: () {
              setState(() {
                isClosed = true;
              });
            },
            onPanelSlide: (double){
              isClosed ? _animationController.animateToEnd() : _animationController.animateToStart();
            },
            header: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: AnimateIcons(
                startIcon: Icons.keyboard_arrow_up,
                endIcon: Icons.keyboard_arrow_down,
                controller: _animationController,
                size: 40.0,
                duration: Duration(milliseconds: 500),
                color: Theme.of(context).primaryColor,
                clockwise: false,
              ),
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0)),
            panel: Center(
                child: CarouselSlider(
                    items: items,
                    options: CarouselOptions(
                      height: 400,
                      aspectRatio: 2.0,
                      viewportFraction: 0.62,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      reverse: false,
                      enlargeCenterPage: false,
                      scrollDirection: Axis.horizontal,
                    ))),
            body: Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: Center(
                child: page,
              ),
            ),
          );
        },
      ),
    );
  }
}
