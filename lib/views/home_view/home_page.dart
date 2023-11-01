import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vmeeting/app_models/app_users_model/app_users_model.dart';
import 'package:vmeeting/blocs/home_page_bloc/home_page_bloc.dart';
import 'package:vmeeting/src/controllers/enter_number_cont.dart';
import 'package:vmeeting/src/widgets/small_text.dart';
import '../../service/routes/routes_name.dart';
import '../../src/widgets/custom_loading/customloading.dart';
import '../../src/widgets/exceptions/app_exeptions.dart';

class HomePage extends StatefulWidget {
  final NumberController controller;
  const HomePage({super.key, required this.controller});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageBloc homePageBloc;

  @override
  void initState() {
    super.initState();
    homePageBloc = BlocProvider.of<HomePageBloc>(context);
    homePageBloc.add(HomePageFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomePageBloc, HomePageState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HomePageInitialState) {
            return buildLoading();
          } else if (state is HomePageLoadedState) {
            return buildUI(state.appUsersModelList);
          }
          if (state is HomePageExceptionState) {
            return const Center(
                child: AppExceptionsWidget(
                    message: "Exception",
                    authName: MainRoutes.main_page));
          }
          return const Center(child: Text("AloVoice"));
        },
      ),
    );
  }

  Widget buildUI(List<AppUsersModel> appUserModelList) {
    return ListView.builder(
      itemCount: appUserModelList.length,
        itemBuilder: (BuildContext context, int index){
      return SmallText(text: appUserModelList[index].user?.fullName ?? "");
    });
  }

  Widget buildLoading() {
    return Center(child: CustomLoading());
  }
}