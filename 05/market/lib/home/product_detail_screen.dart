import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market/main.dart';
import 'package:market/model/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.product.title}"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 320,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.product.imgUrl ?? "",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          switch (widget.product.isSale) {
                            true => Container(
                                decoration: BoxDecoration(color: Colors.red),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                                child: Text(
                                  "할인증",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            _ => Container()
                          }
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.product.title ?? "플러터 ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            PopupMenuButton(itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                    onTap: () {
                                      int reviewScore = 0;
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          TextEditingController revuewTec =
                                              TextEditingController();
                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              return AlertDialog(
                                                title: Text("리뷰 등록"),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    TextField(
                                                      controller: revuewTec,
                                                    ),
                                                    Row(
                                                      children: List.generate(
                                                        5,
                                                        (index) => IconButton(
                                                          onPressed: () {
                                                            setState(() =>
                                                                reviewScore =
                                                                    index);
                                                          },
                                                          icon: Icon(
                                                            Icons.star,
                                                            color: index <=
                                                                    reviewScore
                                                                ? Colors.orange
                                                                : Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                    child: Text("취소"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {},
                                                    child: Text("등록"),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: Text("리뷰등록")),
                              ];
                            }),
                          ],
                        ),
                        Text("제품 상세 정보"),
                        Text("${widget.product.description}"),
                        Row(
                          children: [
                            Text(
                              "${widget.product.price ?? "100000"}원",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.star,
                              color: Colors.orange,
                            ),
                            Text("4.5"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(tabs: [
                          Tab(text: "제품 상세"),
                          Tab(text: "리뷰"),
                        ]),
                        Container(
                          height: 500,
                          child: TabBarView(
                            children: [
                              Container(
                                child: Text("제품 상세"),
                              ),
                              Container(
                                child: Text("리뷰 "),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              final db = FirebaseFirestore.instance;
              final dupItems = await db
                  .collection("cart")
                  .where("uid", isEqualTo: userCredential?.user?.uid ?? "")
                  .where("product.docId", isEqualTo: widget.product.docId)
                  .get();
              if (dupItems.docs.isNotEmpty) {
                if (context.mounted) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text("장바구니에 이미 등록되어 있는 제품입니다."),
                    ),
                  );
                }
                return;
              }
              // 장바구니 추가
              await db.collection("cart").add(
                {
                  "uid": userCredential?.user?.uid ?? "",
                  "email": userCredential?.user?.email ?? "",
                  "timestamp": DateTime.now().millisecondsSinceEpoch,
                  "product": widget.product.toJson(),
                  "count": 1,
                },
              );
              if (context.mounted) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text("장바구니에 등록 완료"),
                  ),
                );
              }
            },
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: Colors.red[100],
              ),
              child: Center(
                child: Text(
                  "장바구니",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
