import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  bool _canProcess = true;
  bool _isBusy = false;
  String _text = "";
  CustomPaint? _customPaint;
  final _cameraLensDirection = CameraLensDirection.back;

  var _script = TextRecognitionScript.korean;
  TextRecognizer textRecognizer =
      TextRecognizer(script: TextRecognitionScript.korean);
  ImagePicker _imagePicker = ImagePicker();

  @override
  void dispose() {
    _canProcess = false;
    textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          DropdownButton(
            items: TextRecognitionScript.values
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e.name),
                    value: e,
                  ),
                )
                .toList(),
            value: _script,
            onChanged: (script) {
              setState(() {
                if (script != null) {
                  setState(() {
                    _script = script!;
                    textRecognizer.close();
                    textRecognizer = TextRecognizer(script: _script);
                  });
                }
              });
            },
          ),
          _image != null
              ? SizedBox(
                  height: 320,
                  width: 320,
                  child: Image.file(
                    _image!,
                  ),
                )
              : Container(
                  height: 240,
                  width: 240,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                ),
          ElevatedButton(
            onPressed: () => _getImage(ImageSource.gallery),
            child: Text("갤러리 이미지 가져오기"),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                _text,
              ),
            ),
          ),
        ],
      ),
      // body: CameraView(
      //   customPaint: _customPaint,
      //   onImage: _processImage,
      // ),
    );
  }

  Widget buildGalleryView() => Column(
        children: [],
      );

  Future _getImage(ImageSource source) async {
    setState(() {
      _image = null;
    });
    final pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      _processFile(pickedFile.path);
    }
  }

  Future _processFile(String path) async {
    setState(() {
      _image = File(path);
    });
    final inputImage = InputImage.fromFilePath(path);
    _processImage(inputImage);
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final recognizedText = await textRecognizer.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
    } else {
      // 갤러리에서 가져온 값 처리
      _text = "recognized Text: ${recognizedText.text} \n\n";
      for (var block in recognizedText.blocks) {
        _text += "Block: ${block.text}\n";
        for (var line in block.lines) {
          _text += "Line: ${line.text}\n";
          for (var element in line.elements) {
            _text += "element: ${element.text}\n";
          }
        }
        _text += "\n\n";
      }
      setState(() {});
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
