import 'package:animate_icons/animate_icons.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
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

import '../../app/logger.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_routes.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  var logger = getLogger("HomeView");

  String currentPage = RoutePaths.MainPage;
  PanelController _panelController;
  AnimateIconController _animationController;
  ScrollController _scrollController;
  bool isClosed = true;
  double _scrollPosition;
  double _oldScrollPosition = 0;
  double _newScrollPosition = 232;
//  AudioPlayer _audioPlayer;
  double scrollOffset = 232.0;
  AudioCache _audioCache;

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
                  height: 250.h,
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
    _scrollController = ScrollController();
//    _audioPlayer = AudioPlayer();
    _audioCache = AudioCache();

    _scrollController.addListener(_scrollListener);
  }

  playLocal() async {
    await _audioCache.play('/tick.mp3');
  }

  _scrollListener() {
//    _scrollPosition = _scrollController.position.pixels;
//    if((_scrollPosition) > _newScrollPosition){
//      playLocal();
//      _oldScrollPosition = _newScrollPosition;
//      _newScrollPosition += scrollOffset;
//    }
//    if((_newScrollPosition -_scrollPosition))
//      if ( > _newScrollPosition) {
//        logger.i("Playing..");
//        _newScrollPosition += 200;
//          playLocal();
//      }
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
            minHeight: 100.h,
            maxHeight: 350.h,
            backdropEnabled: true,
            parallaxEnabled: true,
            controller: _panelController,
            onPanelOpened: () {
              setState(() {
                _animationController.animateToEnd();
              });
            },
            onPanelClosed: () {
              setState(() {
                _animationController.animateToStart();
              });
            },
            header: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: AnimateIcons(
                startIcon: Icons.keyboard_arrow_up,
                endIcon: Icons.keyboard_arrow_down,
                controller: _animationController,
                size: 40.0,
                duration: Duration(milliseconds: 100),
                color: kBlackColor,
                clockwise: false,
                onStartIconPress: () {
                  _panelController.open();
                  _animationController.animateToEnd();
                  return true;
                },
                onEndIconPress: () {
                  _panelController.close();
                  _animationController.animateToStart();
                  return true;
                },
              ),
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0)),
            panel: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 50.h,
                ),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: items,
                    controller: _scrollController,
                  ),
                )
              ],
            )),
            body: page,
          );
        },
      ),
    );
  }
}
