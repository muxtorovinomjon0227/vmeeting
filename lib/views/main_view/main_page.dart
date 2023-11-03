import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vmeeting/blocs/home_page_bloc/home_page_bloc.dart';
import 'package:vmeeting/src/controllers/enter_number_cont.dart';
import 'package:vmeeting/views/home_view/home_page.dart';
import 'package:vmeeting/views/profile_view/profile_page.dart';
import 'package:vmeeting/views/users_view/users_page.dart';
import '../../service/user_repositores/user_repo.dart';
import '../../src/constants/colors_const.dart';
import '../../src/widgets/appbar_animation_widgets/icon_painters/category_icon_painter.dart';
import '../../src/widgets/appbar_animation_widgets/sliver_scaffold.dart';
import '../drower_view/drower_menue.dart';

class MainPage extends StatefulWidget {
  final NumberController controller;
  const MainPage({super.key, required this.controller});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int current_index = 0;
  late List<Widget> pages = [
    MultiBlocProvider(
      providers: [
        BlocProvider<HomePageBloc>(
          create: (context) => HomePageBloc(),
        ),
      ],
      child: HomePage(controller: widget.controller),
    ),
    AllUsersViewPage(controller: widget.controller),
    ProfilePage(controller: widget.controller)
  ];

  void OnTapped(int index) {
    setState(() {
      current_index = index;
    });
  }
  @override
  void initState() {
    UserRepository.getInstance().getUserProfile(context);
    super.initState();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: Drawer(
        child: DrawerMenue(controller: widget.controller),
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CurvedNavigationBar(
            height: 50,
            backgroundColor: ColorConst.appBackgroundColor.withOpacity(0.5),
            color: ColorConst.appGreenColor,
            buttonBackgroundColor: ColorConst.appGreenColor,
            onTap: OnTapped,
            items: const <Widget>[
              Icon(Icons.home),
              Icon(Icons.search),
              Icon(Icons.person)
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SliverScaffold(
          appBarIcon: IconButton(
            onPressed: ()=> _key.currentState!.openDrawer(),
            splashRadius: 24,
            icon: CategoryIconPainter.getCustomPaint(1.8),
          ),
          body: pages[current_index],
          pageIndex: current_index,
        ),
      ),
    );
  }
}
