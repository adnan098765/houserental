// import 'package:flutter/material.dart';
//
// class CounterScreen extends StatefulWidget {
//   const CounterScreen({super.key});
//
//   @override
//   State<CounterScreen> createState() => _CounterScreenState();
// }
//
// class _CounterScreenState extends State<CounterScreen> {
//   int counter = 0;
//   void incrementCounter(){
//     setState(() {
//       counter++;
//     });
//   }
//   void decrementCounter(){
//     setState(() {
//       counter--;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Counter"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text("You have pushed this button many times"),
//             SizedBox(height: 30,),
//             Text("$counter"),
//             SizedBox(height: 30,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(onPressed: incrementCounter, icon: Icon(Icons.add,size: 50,)),
//                 IconButton(onPressed: decrementCounter, icon: Icon(Icons.remove,size: 50,))
//
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:zillow_rental/Screens/TopLocationScreen/post_controller.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postController.fetchPosts();
  }
  final PostController postController = Get.put(PostController());
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() {
          if (postController.loading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (postController.postlist.isEmpty) {
            return Center(child: Text("No data found"));
          } else {
            return ListView.builder(
              itemCount: postController.postlist.length,
              itemBuilder: (context, index) {
                final post = postController.postlist[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(post.body!),
                        subtitle: Text(post.body!),
                  )
                );
              },
            );
          }
        })
      // body: GridView.builder(
      //
      //     itemCount: 30,
      //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisSpacing: 20,
      //         mainAxisSpacing: 10,
      //         crossAxisCount: 3
      // ), itemBuilder: (context,index){
      //   return Container(
      //     height: 200,
      //     width: 200,
      //     decoration: BoxDecoration(
      //       color: Colors.green,
      //     ),
      //     child: Column(
      //       children: [
      //         Container(
      //           height: 100,
      //           width: 350,
      //           color: Colors.red,
      //         ),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text("Price"),
      //             Text("1200")
      //           ],
      //         ),
      //         Row(
      //           children: [
      //             Icon(Icons.star,color: Colors.yellow,)
      //           ],
      //         )
      //       ],
      //     ),
      //   );
      // }),
    );
  }
}
