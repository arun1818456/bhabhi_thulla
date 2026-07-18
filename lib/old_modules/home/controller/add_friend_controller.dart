import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddFriendController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> usersList = [];

  onTapToSearchFriend(search) async {
    print("object");
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .where('user_name', isEqualTo: "rohan_124")
        .get();
   print(snapshot);
    if (snapshot.docs.isNotEmpty) {
      usersList = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      print(usersList);
    } else {
      usersList = [];
    }
    print(usersList);
  }
}
