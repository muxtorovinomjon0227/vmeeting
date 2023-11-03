import 'dart:ui';
import 'package:flutter/material.dart';
import '../../constants/colors_const.dart';
import '../textfiled_widgets/auth_text_fild.dart';
import 'icon_painters/notification_icon_painter.dart';

const double _searchBarHeight = 54;
const double _searchBarVerticalMargin = 12;
const double _appBarCollapsedHeight =
    _searchBarHeight + _searchBarVerticalMargin * 2; // 78
const double _appBarExpandedHeight = 100 + _searchBarHeight; // 154
const double _appBarExpandedHeight1 = 50 + _searchBarHeight; // 154

class SliverScaffold extends StatefulWidget {
  final Widget appBarIcon;
  final int pageIndex;
  const SliverScaffold({Key? key, required this.body,required this.appBarIcon, required this.pageIndex}) : super(key: key);

  final Widget body;

  @override
  _SliverScaffoldState createState() => _SliverScaffoldState();
}

class _SliverScaffoldState extends State<SliverScaffold> {
  final ScrollController _scrollController = ScrollController();
  double currentExtent = 0.0;
  double get minExtent => 0.0;
  double get maxExtent => _scrollController.position.maxScrollExtent;
  double get deltaExtent => maxExtent - minExtent;
  Curve get curve => Curves.easeOutCubic;

  double actionSpacing = 24;
  double iconStrokeWidth = 1.8;
  double titlePaddingHorizontal = 16;
  double titlePaddingTop = 74;

  final Tween<double> actionSpacingTween = Tween(begin: 24, end: 0);
  final Tween<double> iconStrokeWidthTween = Tween(begin: 1.8, end: 1.2);
  final Tween<double> titlePaddingHorizontalTween = Tween(begin: 16, end: 48);
  final Tween<double> titlePaddingTopTween = Tween(begin: 74, end: 12);
  final _searchControlle = TextEditingController(text: "");
  final _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (_, __) => [
        SliverAppBar(
          leading: Row(
            children: [
              SizedBox(width: actionSpacing),
              widget.appBarIcon
            ],
          ),
          leadingWidth: 74,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              splashRadius: 24,
              icon: NotificationIconPainter.getCustomPaint(iconStrokeWidth),
            ),
            SizedBox(width: actionSpacing),
          ],
          toolbarHeight: _appBarCollapsedHeight,
          collapsedHeight: _appBarCollapsedHeight,
          expandedHeight: widget.pageIndex == 0
              ? _appBarExpandedHeight
              : _appBarExpandedHeight1,
          flexibleSpace: FlexibleSpaceBar.createSettings(
            currentExtent: _appBarCollapsedHeight,
            minExtent: _appBarCollapsedHeight,
            maxExtent: _appBarExpandedHeight,
            toolbarOpacity: 1.0,
            child: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(
                top: titlePaddingTop,
                left: titlePaddingHorizontal,
                right: titlePaddingHorizontal,
              ),
              centerTitle: true,
              title: Column(
                children: [
                  widget.pageIndex == 0
                      ?  AuthTextFild(
                    lableName: "Search...",
                    borderRadius: 10,
                    elevation: 1,
                    color: ColorConst.appBackgroundColor.withOpacity(0.4),
                    focusNode: _searchFocusNode,
                    textEditingController: _searchControlle,
                  )
                       : widget.pageIndex == 1
                      ? SizedBox()
                      : widget.pageIndex == 2
                      ? SizedBox()
                      : SizedBox(),
                  const Spacer(),
                ],
              ),
            ),
          ),
          elevation: 4,
          shadowColor: ColorConst.appGreenColor,
          pinned: true,
        ),
      ],
      body: widget.body,
    );
  }

  _scrollListener() {
    setState(() {
      currentExtent = _scrollController.offset;

      actionSpacing = _remapCurrentExtent(actionSpacingTween);
      iconStrokeWidth = _remapCurrentExtent(iconStrokeWidthTween);
      titlePaddingHorizontal = _remapCurrentExtent(titlePaddingHorizontalTween);
      titlePaddingTop = _remapCurrentExtent(titlePaddingTopTween);
    });
  }

  double _remapCurrentExtent(Tween<double> target) {
    final double deltaTarget = target.end! - target.begin!;

    double currentTarget =
        (((currentExtent - minExtent) * deltaTarget) / deltaExtent) +
            target.begin!;

    double t = (currentTarget - target.begin!) / deltaTarget;

    double curveT = curve.transform(t);

    return lerpDouble(target.begin!, target.end!, curveT)!;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
}
