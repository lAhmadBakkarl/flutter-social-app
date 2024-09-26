class UploadResponse {
  String? imageUrl;
  bool success;
  UploadResponse(
      {this.imageUrl, required this.success, required String message});
}
