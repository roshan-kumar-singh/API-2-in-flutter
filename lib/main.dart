import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({required this.id, required this.userId, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSONPlaceholderAPI Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const JsonPlaceholderApiDemo(),
    );
  }
}

class JsonPlaceholderApiDemo extends StatefulWidget {
  const JsonPlaceholderApiDemo({Key? key}) : super(key: key);

  @override
  _JsonPlaceholderApiDemoState createState() => _JsonPlaceholderApiDemoState();
}

class _JsonPlaceholderApiDemoState extends State<JsonPlaceholderApiDemo> {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      Response response = await Dio().get(apiUrl);
      List<dynamic> data = response.data;
      setState(() {
        posts = data.map((post) => Post.fromJson(post)).toList();
      });
    } catch (e) {
      print(e.toString());
      // handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JSONPlaceholderAPI Demo'),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(posts[index].title),
            subtitle: Text(posts[index].body),
          );
        },
      ),
    );
  }
}
