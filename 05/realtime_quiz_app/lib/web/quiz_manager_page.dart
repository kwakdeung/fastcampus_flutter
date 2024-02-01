import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realtime_quiz_app/main.dart';
import 'package:realtime_quiz_app/model/quiz.dart';
import 'package:realtime_quiz_app/web/quiz_bottom_sheet_widget.dart';

class QuizManagerPage extends StatefulWidget {
  const QuizManagerPage({super.key});

  @override
  State<QuizManagerPage> createState() => _QuizManagerPageState();
}

class _QuizManagerPageState extends State<QuizManagerPage> {
  String? uid;
  // 퀴즈 문제 목록
  List<QuizManager> quizItems = [];

  // 퀴즈 출제 목록

  // 익명 로그인 정보
  signInAnonymously() {
    FirebaseAuth.instance.signInAnonymously().then((value) {
      setState(() {
        uid = value.user?.uid ?? "";
      });
    });
  }

  generateQuiz() async {
    if (quizItems.isEmpty) {
      return;
    }
    final pinCode = Random().nextInt(999999).toString().padLeft(6);
    final quizRef = database!.ref("quiz");
    final quizDetailRef = database!.ref("quiz_detail");
    final quizStateRef = database!.ref("quiz_state");

    final newQuizDetailRef = quizDetailRef.push();
    newQuizDetailRef.set({
      "code": pinCode,
      "problem": quizItems
          .map(
            (e) => {
              "title": e.title,
              "options": e.problems
                  ?.map((e2) => e2.textEditingController.text)
                  .toList(),
              "answerIndex": e.answer?.index,
              "answer": e.answer?.textEditingController.text
            },
          )
          .toList(),
    });

    await quizStateRef.child("${newQuizDetailRef.key}").set({
      "quizDetailRef": newQuizDetailRef.key,
      "user": [],
      "state": false,
      "score": [],
      "solve": [{}],
    });

    final newQuizRef = quizRef.push();
    await newQuizRef.set({
      "code": pinCode,
      "uid": uid,
      "generateTime": DateTime.now().toString(),
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "quizDetailRef": newQuizDetailRef.key,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signInAnonymously();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("퀴즈 출제하기(출제자용)"),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(tabs: [
              Tab(
                text: "출제하기",
              ),
              Tab(
                text: "퀴즈목록",
              ),
            ]),
            Expanded(
              child: TabBarView(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: quizItems.length,
                          itemBuilder: (context, index) {
                            return ExpansionTile(
                              title:
                                  Text(quizItems[index].title ?? "문제 타이틀 없음"),
                              children: quizItems[index]
                                      .problems
                                      ?.map(
                                        (e) => ListTile(
                                          title: Text(
                                              e.textEditingController.text),
                                        ),
                                      )
                                      .toList() ??
                                  [],
                            );
                          },
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          /// TODO: 퀴즈 생성 및 핀코드 생성 로직 추가
                          generateQuiz();
                        },
                        height: 72,
                        color: Colors.indigo,
                        child: const Text(
                          "제출 및 핀코드 생성",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // TODO 문제 출제를 위한 모달을 띄우기
          final quiz = await showModalBottomSheet(
            context: context,
            builder: (context) => QuizBottomSheetWidget(),
          );
          setState(() {
            quizItems.add(quiz);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
