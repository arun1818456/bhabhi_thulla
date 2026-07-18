// import 'package:bhabhi_thulla/modules/home/controller/add_friend_controller.dart';
import 'package:bhabhi_thulla/my_app.dart';
import 'package:bhabhi_thulla/widgets/text_field.dart';

import '../../../constant/colors.dart';
import '../../../constant/export_file.dart';
import '../controller/add_friend_controller.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddFriendController(),
      builder: (controller) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Add Friend"),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Container(
                height: 60,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(width: 1.5, color: AppColors.blue),
                ),
                child: TabBar(
                  controller: tabController,
                  dividerColor: Colors.transparent,
                  labelColor: AppColors.whiteColor,
                  unselectedLabelColor: AppColors.blue,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: AppColors.blue,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: const [
                    Tab(
                      child: Text(
                        "Search",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Requests",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ],
                  labelStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children:  [SearchPage(controller: controller,), RequestPage()],
                ),
              ),
            ],
          ),
        ),
      );
    },);
  }
}

class SearchPage extends StatefulWidget {
  AddFriendController controller;
   SearchPage({super.key,required this.controller});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        gap(height: 20),
        MyTextFieldForm(
          tfController: textEditingController,
          containerHeight: 50,
          hintText: "Search friend",
          horizontalPadding: 15,
          postfix:
              IconButton(onPressed: () {
                widget.controller.onTapToSearchFriend(textEditingController.text.trim());
              }, icon: const Icon(Icons.search)),
        ),
      ],
    );
  }
}

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [Text('Friends Tab Content', style: TextStyle(fontSize: 18))],
    );
  }
}
