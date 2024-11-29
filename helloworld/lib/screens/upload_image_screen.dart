import 'dart:typed_data'; // Để xử lý dữ liệu file trên web
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Thư viện chọn file
import 'package:http/http.dart' as http; // Để gửi HTTP request

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  Uint8List? _imageBytes; // Lưu trữ dữ liệu ảnh được chọn
  String? _imageName; // Lưu tên file ảnh được chọn

  Future<void> _pickImage() async {
    // Sử dụng file_picker để chọn ảnh
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true, // Để lấy dữ liệu ảnh
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _imageBytes = result.files.single.bytes;
        _imageName = result.files.single.name;
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageBytes == null || _imageName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn ảnh trước!')),
      );
      return;
    }

    try {
      // Tạo request multipart
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://localhost:3000/upload-images'), // Thay URL server
      );

      // Thêm file vào request
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          _imageBytes!,
          filename: _imageName,
        ),
      );

      // Gửi request
      var response = await request.send();

      // Xử lý phản hồi
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Upload thành công!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageBytes != null
                ? Image.memory(_imageBytes!,
                    width: 200, height: 200, fit: BoxFit.cover)
                : const Text('No image selected'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Chọn ảnh'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadImage,
              child: const Text('Tải lên'),
            ),
          ],
        ),
      ),
    );
  }
}
