import 'package:http/http.dart' as http;

class FirebaseAuthRemoteDataSource{
  final String url = 'https://us-central1-greeny-12a2d.cloudfunctions.net/createCustomToken';

  Future<String> createCutomToken(Map<String, dynamic> user) async{
    final customTokenResponse = await http.post(Uri.parse(url), body: user);
    return customTokenResponse.body;
  }

}