import 'package:bhabhi_thulla/constant/images_text.dart';

import '../constant/export_file.dart';
import '../my_app.dart';
import 'network_image.dart';

class FriendListWidget extends StatefulWidget {
  String profileUrl = "";
  String name = "";
  String userName = "";
  String userId = "";
  String deviceToken = "";
  bool isUserOnline = false;
  FriendListWidget(
      {super.key,
      required this.profileUrl,
      required this.isUserOnline,
      required this.name,
      required this.userName,
      required this.deviceToken,
      required this.userId});

  @override
  State<FriendListWidget> createState() => _FriendListWidgetState();
}

class _FriendListWidgetState extends State<FriendListWidget> {
  bool searchLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      height: 80,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: .5),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              height: 62,
              width: 62,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.lightBlueAccent)),
              child: NetworkImageWidget(
                imageUrl: widget.profileUrl,
              ),
            ),
          ),
          gap(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                widget.userName,
                // style: w_400.copyWith(
                //   fontSize: 10,
                //   color: AppColors.whiteColor,
                // ),
              ),
            ],
          ),
          const Spacer(),
          searchLoading
              ? Image.asset(
                  AppImages.loadingGif,
                  width: 50,
                  height: 50,
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      searchLoading = true;
                    });
                    Future.delayed(const Duration(seconds: 15), () {
                      setState(() {
                        searchLoading = false;
                      });
                    });
                  },
                  child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border:
                              Border.all(color: Colors.black.withOpacity(.5)),
                          color: Colors.lightBlueAccent.withOpacity(.5)),
                      child: Center(child: Icon(Icons.add))),
                )
        ],
      ),
    );
  }
}
