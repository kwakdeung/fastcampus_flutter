import 'package:flutter/material.dart';

class ProdcutAddScreen extends StatefulWidget {
  const ProdcutAddScreen({super.key});

  @override
  State<ProdcutAddScreen> createState() => _ProdcutAddScreenState();
}

class _ProdcutAddScreenState extends State<ProdcutAddScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isSale = false;

  TextEditingController titleTEC = TextEditingController();
  TextEditingController descriptionTEC = TextEditingController();
  TextEditingController priceTEC = TextEditingController();
  TextEditingController stockTEC = TextEditingController();
  TextEditingController salePercentTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("상품 추가"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.batch_prediction)),
          IconButton(onPressed: () {}, icon: Icon(Icons.add)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 240,
                  width: 240,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[200]!,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      Text("제품(상품) 이미지 추가"),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "기본정보",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: titleTEC,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "상품명",
                        hintText: "제품명을 입력하세요.",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "필수 입력 항목입니다.";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: descriptionTEC,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "상품 설명",
                        hintText: "제품명을 입력하세요.",
                      ),
                      maxLength: 254,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "필수 입력 항목입니다.";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: priceTEC,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "가격(단가)",
                        hintText: "1개 가격 입력",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "필수 입력 항목입니다.";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: stockTEC,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "수량",
                        hintText: "입고 및 재고 수량",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "필수 입력 항목입니다.";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    SwitchListTile.adaptive(
                      value: isSale,
                      onChanged: (v) {
                        setState(() {
                          isSale = v;
                        });
                      },
                      title: Text("할인여부"),
                    ),
                    if (isSale)
                      TextFormField(
                        controller: salePercentTEC,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "할인율",
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          return null;
                        },
                      ),
                    SizedBox(height: 16),
                    Text(
                      "카테고리 선택",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    DropdownButton(
                        isExpanded: true, items: [], onChanged: (s) {})
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
