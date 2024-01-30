import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:market/home/product_detail_screen.dart';
import 'package:market/model/category.dart';
import 'package:market/model/product.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  PageController pageController = PageController();
  int bannerIndex = 0;

  List<Category> categoryItems = [];

  // 카테고리 목록 가져오기
  Stream<QuerySnapshot<Map<String, dynamic>>> streamCategories() {
    return FirebaseFirestore.instance.collection("category").snapshots();
  }

  Future<List<Product>> fetchSaleProducts() async {
    final dbRef = FirebaseFirestore.instance.collection("products");
    final saleItems =
        await dbRef.where("isSale", isEqualTo: true).orderBy("saleRate").get();
    List<Product> products = [];
    for (var element in saleItems.docs) {
      final item = Product.fromJson(element.data());
      final copyItem = item.copyWith(docId: element.id);
      products.add(copyItem);
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 140,
            color: Colors.indigo,
            margin: EdgeInsets.only(bottom: 8),
            child: PageView(
              controller: pageController,
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Image.asset("assets/fastcampus_logo.png"),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Image.asset("assets/fastcampus_logo.png"),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(8),
                  child: Image.asset("assets/fastcampus_logo.png"),
                ),
              ],
              onPageChanged: (idx) {
                setState(() {
                  bannerIndex = idx;
                });
              },
            ),
          ),
          DotsIndicator(
            dotsCount: 3,
            position: bannerIndex,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16),
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "카테고리",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text("더보기"),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // TODO: 카테고리 목록을 받아오는 위젯 구현
                Container(
                  height: 240,
                  // color: Colors.red,
                  child: StreamBuilder(
                      stream: streamCategories(),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasData) {
                          categoryItems.clear();
                          final docs = snapshot.data;
                          final docItems = docs?.docs ?? [];
                          for (var doc in docItems) {
                            categoryItems.add(Category(
                                docId: doc.id, title: doc.data()["title"]));
                          }
                          return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                              ),
                              itemCount: categoryItems.length,
                              itemBuilder: (context, index) {
                                final item = categoryItems[index];
                                return Column(
                                  children: [
                                    CircleAvatar(radius: 24),
                                    SizedBox(height: 8),
                                    Text(
                                      item.title ?? "카테고리?",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                );
                              });
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 24),
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 16),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "오늘의 특가",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text("더보기")),
                  ],
                ),
                Container(
                  height: 240,
                  child: FutureBuilder(
                      future: fetchSaleProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final items = snapshot.data ?? [];
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final item = items[index];
                              if (snapshot.hasData) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailScreen(),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 160,
                                          margin: EdgeInsets.only(right: 16),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  item.imgUrl ?? ""),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        item.title ?? "",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "${item.price} 원",
                                        style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                      Text(
                                          "${(item.price! * (item.saleRate! / 100)).toStringAsFixed(0)}원"),
                                    ],
                                  ),
                                );
                              }
                            },
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
