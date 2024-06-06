import '../models/process_response.dart';

mixin FirebaseHelper {
  ProcessResponse getResponse(String message,
          [bool success = true])  =>
      ProcessResponse(message, success);
}
