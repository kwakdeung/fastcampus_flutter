import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future addCategories(String title) async {
  final db = FirebaseFirestore.instance;
  final ref = db.collection("category");
  await ref.add({"title": title});
}

class SellerWidget extends StatefulWidget {
  const SellerWidget({super.key});

  @override
  State<SellerWidget> createState() => _SellerWidgetState();
}

class _SellerWidgetState extends State<SellerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchBar(),
          SizedBox(height: 16),
          ButtonBar(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    List<String> categories = [
                      "정육",
                      "과일",
                      "과자",
                      "아이스크림",
                      "유제품",
                      "라면",
                      "생수",
                      "빵/쿠키"
                    ];
                    final ref =
                        FirebaseFirestore.instance.collection("category");
                    final tmp = await ref.get();
                    for (var element in tmp.docs) {
                      await element.reference.delete();
                    }

                    for (var element in categories) {
                      await ref.add({"title": element});
                    }
                  },
                  child: Text("카테고리 일괄등록")),
              ElevatedButton(
                  onPressed: () {
                    TextEditingController tec = TextEditingController();
                    showAdaptiveDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: TextField(
                          controller: tec,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              if (tec.text.isNotEmpty) {
                                await addCategories(tec.text.trim());
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text("등록"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text("카테고리 등록")),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "상품목록",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                height: 120,
                margin: EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                        // image: DecorationImage(),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "제품 명",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              PopupMenuButton(
                                itemBuilder: (context) => [
                                  PopupMenuItem(child: Text("리뷰")),
                                  PopupMenuItem(child: Text("삭제")),
                                ],
                              ),
                            ],
                          ),
                          Text("1000000원"),
                          Text("할인 중"),
                          Text("재고수량"),
                        ],
                      ),
                    )),
                  ],
                ),
              );
            },
          )),
        ],
      ),
    );
  }
}
