import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FreeGuessingForum extends StatefulWidget {
  final String username;

  const FreeGuessingForum({
    super.key,
    required this.username,
  });

  @override
  State<FreeGuessingForum> createState() =>
      _FreeGuessingForumState();
}

class _FreeGuessingForumState
    extends State<FreeGuessingForum> {

  List posts = [];

  bool loading = true;

  final TextEditingController
  postController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  Future<void> loadPosts() async {

    try {

      var response = await http.get(

        Uri.parse(
          "https://khelbindass99.com/bgf/api/bgf_get_posts.php",
        ),

      );

      var data =
      jsonDecode(response.body);

      setState(() {

        posts =
            data["posts"] ?? [];

        loading = false;

      });

    } catch(e){

      setState(() {
        loading = false;
      });

    }
  }

  Future<void> createPost() async {

    if(postController.text
        .trim()
        .isEmpty){
      return;
    }

    try {

      var response = await http.post(

        Uri.parse(
          "https://khelbindass99.com/bgf/api/bgf_create_post.php",
        ),

        body: {

          "username":
          widget.username,

          "message":
          postController.text
              .trim(),

        },

      );

      var data =
      jsonDecode(response.body);

      if(data["status"]
      ==
          "success"){

        postController.clear();

        await loadPosts();

        if(mounted){

          ScaffoldMessenger
              .of(context)
              .showSnackBar(

            const SnackBar(
              content:
              Text(
                "Post Added",
              ),
            ),

          );
        }
      }

    } catch(e){

      if(mounted){

        ScaffoldMessenger
            .of(context)
            .showSnackBar(

          SnackBar(
            content:
            Text(
              e.toString(),
            ),
          ),

        );
      }
    }
  }

  void openPostDialog(){

    showDialog(

      context: context,

      builder: (_){

        return AlertDialog(

          title:
          const Text(
            "Create Post",
          ),

          content: TextField(

            controller:
            postController,

            maxLines: 4,

            decoration:
            const InputDecoration(

              hintText:
              "Write Something...",

            ),

          ),

          actions: [

            TextButton(

              onPressed: (){
                Navigator.pop(
                  context,
                );
              },

              child:
              const Text(
                "Cancel",
              ),

            ),

            ElevatedButton(

              onPressed: () async {

                Navigator.pop(
                  context,
                );

                await createPost();
              },

              child:
              const Text(
                "POST",
              ),

            ),

          ],

        );
      },

    );
  }

  Widget postCard(
      dynamic post){

    return Card(

      color:
      Colors.black87,

      margin:
      const EdgeInsets.all(8),

      child: Padding(

        padding:
        const EdgeInsets.all(12),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Text(

              post["username"]
                  ??
                  "",

              style:
              const TextStyle(

                color:
                Colors.amber,

                fontWeight:
                FontWeight.bold,

              ),

            ),

            const SizedBox(
              height: 8,
            ),

            Text(

              post["message"]
                  ??
                  "",

              style:
              const TextStyle(
                color:
                Colors.white,
              ),

            ),

            const SizedBox(
              height: 8,
            ),

            Text(

              post["created_at"]
                  ??
                  "",

              style:
              const TextStyle(

                color:
                Colors.grey,

                fontSize:
                11,

              ),

            ),

          ],

        ),

      ),

    );
  }

  @override
  Widget build(
      BuildContext context){

    return Scaffold(

      backgroundColor:
      const Color(
        0xff111111,
      ),

      floatingActionButton:
      FloatingActionButton(

        backgroundColor:
        Colors.amber,

        onPressed:
        openPostDialog,

        child:
        const Icon(
          Icons.add,
          color:
          Colors.black,
        ),

      ),

      body:
      RefreshIndicator(

        onRefresh:
        loadPosts,

        child:

        loading

            ? const Center(
          child:
          CircularProgressIndicator(),
        )

            : posts.isEmpty

            ? const Center(
          child:
          Text(
            "No Posts Found",
            style:
            TextStyle(
              color:
              Colors.white,
            ),
          ),
        )

            : ListView.builder(

          itemCount:
          posts.length,

          itemBuilder:
              (
              context,
              index){

            return postCard(
              posts[index],
            );
          },

        ),

      ),

    );
  }
}
