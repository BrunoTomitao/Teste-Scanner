import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isProcessing = false;
  String recognizedText = '';

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final backCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back,
    );
    _controller = CameraController(backCamera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePictureAndScanText() async {
    if (_controller.value.isTakingPicture || _isProcessing) return;

    try {
      setState(() {
        _isProcessing = true;
        recognizedText = '';
      });

      final XFile file = await _controller.takePicture();

      // Carregar a imagem para o ML Kit
      final inputImage = InputImage.fromFilePath(file.path);

      // Instanciar o reconhecedor
      final textRecognizer = TextRecognizer();

      // Processar a imagem
      final RecognizedText result = await textRecognizer.processImage(inputImage);

      // Fechar o reconhecedor para liberar recursos
      textRecognizer.close();

      setState(() {
        recognizedText = result.text;
        _isProcessing = false;
      });
    } catch (e) {
      setState(() {
        _isProcessing = false;
        recognizedText = 'Erro ao reconhecer texto: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scanner de Texto')),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              color: Colors.black12,
              child: SingleChildScrollView(
                child: Text(
                  recognizedText.isEmpty ? 'Texto reconhecido aparecerá aqui' : recognizedText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isProcessing ? null : _takePictureAndScanText,
        child: _isProcessing
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.camera),
      ),
    );
  }
}
