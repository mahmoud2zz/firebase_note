
class ProcessResponse<T>{
  final String message;
  final bool success;
  late T  uploadTask;

  ProcessResponse(this.message,[ this.success=true]);
}