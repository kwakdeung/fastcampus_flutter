import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_app/model/open_ai_model.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TextEditingController messageTextController = TextEditingController();
  final List<Messages> _historyList = List.empty(growable: true);
  // String apiKey = "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";
  String apiKey = "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";
  String streamText = "";
  static const String _kStrings = "Flutter ChatGPT";
  String get _currentString => _kStrings;
  ScrollController scrollController = ScrollController();
  late Animation<int> _characterCount;
  late AnimationController animationController;

  setupAnimations() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _characterCount = StepTween(begin: 0, end: _currentString.length).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );
    animationController.addListener(() {
      setState(() {});
    });
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 1)).then((value) {
          animationController.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        Future.delayed(const Duration(seconds: 1)).then((value) {
          animationController.forward();
        });
      }
    });
    animationController.forward();
  }

  Future requestChat(String text) async {
    ChatCompletionModel openAiModel = ChatCompletionModel(
      model: "gpt-3.5-turbo",
      messages: [
        Messages(
          role: "system",
          content: "You are a helpful assistant",
        ),
        ..._historyList,
      ],
      stream: false,
    );
    final url = Uri.https("api.openai.com", "/v1/chat/completions");
    final resp = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode(openAiModel.toJson()),
    );
    print(resp.body);
    if (resp.statusCode == 200) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupAnimations();
  }

  @override
  void dispose() {
    messageTextController.dispose();
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Card(
                  child: PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: ListTile(
                            title: const Text("히스토리"),
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            title: const Text("설정"),
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            title: const Text("새로운 채팅"),
                          ),
                        ),
                      ];
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _characterCount,
                      builder: (BuildContext context, Widget? child) {
                        String text =
                            _currentString.substring(0, _characterCount.value);
                        return Row(
                          children: [
                            Text(
                              "${text}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.orange[200],
                            )
                          ],
                        );
                      },
                      // color: Colors.blue,
                      // child: Center(
                      //   child: Text(_kStrings),
                      // ),
                      // child: ListView.builder(
                      //   itemCount: 10,
                      //   itemBuilder: (context, index) {
                      //     if (index % 2 == 0) {
                      //       return Padding(
                      //         padding: const EdgeInsets.symmetric(vertical: 16),
                      //         child: Row(
                      //           children: [
                      //             CircleAvatar(),
                      //             SizedBox(width: 8),
                      //             Expanded(
                      //               child: Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text("User"),
                      //                   Text("message"),
                      //                 ],
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       );
                      //     }
                      //     return Row(
                      //       children: [
                      //         CircleAvatar(
                      //           backgroundColor: Colors.teal,
                      //         ),
                      //         SizedBox(width: 8),
                      //         Expanded(
                      //             child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text("ChatGPT"),
                      //             Text("OpenAI OpenAI OpenAI OpenAI"),
                      //           ],
                      //         ))
                      //       ],
                      //     );
                      //   },
                      // ),
                    ),
                  ),
                ),
              ),
              Dismissible(
                key: Key("chat-bar"),
                direction: DismissDirection.startToEnd,
                onDismissed: (d) {
                  if (d == DismissDirection.startToEnd) {
                    // row
                  }
                },
                background: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("New Chat"),
                  ],
                ),
                confirmDismiss: (d) async {
                  if (d == DismissDirection.startToEnd) {
                    // logic
                  }
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(),
                        ),
                        child: TextField(
                          controller: messageTextController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Message",
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          if (messageTextController.text.isEmpty) {
                            return;
                          }
                          try {
                            requestChat(messageTextController.text.trim());
                            messageTextController.clear();
                            streamText = "";
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                        iconSize: 42,
                        icon: Icon(Icons.arrow_circle_up))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
