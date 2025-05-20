import 'dart:convert';
import 'package:get/get.dart';
import 'package:zillow_rental/Screens/TopLocationScreen/post_model.dart';
import 'package:http/http.dart' as http;

class PostController extends GetxController {
  var loading = false.obs;
  var postlist = <PostModel>[].obs;

  Future<void> fetchPosts() async {
    loading.value = true;
    try {
      final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        postlist.value = data.map((e) => PostModel.fromJson(e)).toList();
      } else {
        postlist.clear(); // If status not OK, empty list
      }
    } catch (e) {
      print("Error fetching posts: $e");
      postlist.clear(); // Handle error case
    } finally {
      loading.value = false;
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchPosts();
  // }
}
