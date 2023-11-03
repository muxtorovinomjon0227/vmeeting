import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vmeeting/app_models/app_users_model/app_users_model.dart';
import 'package:vmeeting/blocs/home_page_bloc/home_page_bloc.dart';
import 'package:vmeeting/src/constants/colors_const.dart';
import 'package:vmeeting/src/controllers/enter_number_cont.dart';
import 'package:vmeeting/src/extension/context_extensions.dart';
import 'package:vmeeting/src/widgets/small_text.dart';
import '../../service/routes/routes_name.dart';
import '../../src/managers/call_manager.dart';
import '../../src/managers/push_notifications_manager.dart';
import '../../src/utils/platform_utils.dart';
import '../../src/widgets/custom_loading/customloading.dart';
import '../../src/widgets/exceptions/app_exeptions.dart';
import '../../src/widgets/image_avatar.dart';

class HomePage extends StatefulWidget {
  final NumberController controller;
  const HomePage({super.key, required this.controller});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageBloc homePageBloc;
  late List<int> selectedUsers = [];

  @override
  void initState() {
    super.initState();
    homePageBloc = BlocProvider.of<HomePageBloc>(context);
    homePageBloc.add(HomePageFetchEvent());
    initForegroundService();
    checkSystemAlertWindowPermission(context);
    requestNotificationsPermission();
    CallManager.instance.init(context);
    PushNotificationsManager.instance.init();
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
                    message: "Exception", authName: MainRoutes.main_page));
          }
          return const Center(child: Text("AloVoice"));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:   Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12),
            child: FloatingActionButton(
              heroTag: "VideoCall",
              backgroundColor: Colors.blue,
              onPressed: () => CallManager.instance.startNewCall(
                  context, CallType.VIDEO_CALL, selectedUsers.toSet()),
              child: const Icon(
                Icons.videocam,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: FloatingActionButton(
              heroTag: "AudioCall",
              backgroundColor: Colors.green,
              onPressed: () => CallManager.instance.startNewCall(
                  context, CallType.AUDIO_CALL, selectedUsers.toSet()),
              child: const Icon(
                Icons.call,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUI(List<AppUsersModel> appUserModelList) {
    return  ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding:
      EdgeInsets.symmetric(horizontal: 16, vertical: context.h * 0.01),
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemCount: appUserModelList.length,
      itemBuilder: (BuildContext context, int index) => SizedBox(
        height: 100,
        child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 10,
                  color: ColorConst.appBackgroundColor.withOpacity(0.3),
                ),
              ],
            ),
            child: Row(
              children: [
                buildImage(context, appUserModelList[index].user?.avatar),
                SizedBox(width: context.w * 0.02),
                buildUserName(appUserModelList[index]),
                const Spacer(),
                buildChackBox(appUserModelList[index].user!.id ?? 0),
                SizedBox(width: context.w * 0.02),
              ],
            )),
      ),
    );
  }
  Widget buildChackBox(int callerId){
    return  StreamBuilder(
        initialData: selectedUsers,
        stream: widget.controller.outputChackBox,
        builder: (BuildContext context, snapshot){
          return Checkbox.adaptive(
            value: selectedUsers.contains(callerId),
            onChanged: (value){
              if(selectedUsers.contains(callerId)){
                selectedUsers.remove(callerId);
                widget.controller.inputChackBox.add(selectedUsers);
              }else{
                selectedUsers.add(callerId);
                widget.controller.inputChackBox.add(selectedUsers);
              }
            },);
        });
  }

  Widget buildUserName(AppUsersModel appUsersModel) {
    return Column(
      children: [
        SizedBox(height: context.h*0.01),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmallText(text: appUsersModel.user?.fullName ?? "",fontWidget: FontWeight.bold,),
            SizedBox(height: context.h*0.005),
            SmallText(text: appUsersModel.user?.email ?? "", size: context.h*0.015),
            SizedBox(height: context.h*0.005),
            SmallText(text: appUsersModel.user?.phone ?? ""),
          ],
        ),
      ],
    );
  }

  Widget buildImage(BuildContext context, String? imagaAvatar) {
    return Center(
        child: AvatarImage(
      radius: context.h * 0.06,
      imagePath: imagaAvatar,
    ));
  }

  Widget buildLoading() {
    return Center(child: CustomLoading());
  }
}
