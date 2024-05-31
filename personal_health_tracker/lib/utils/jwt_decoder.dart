import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

const String jwtSecret = 'aldjkafnldfjanlfaflandjv p98u4t40fnvosdfjowfuigvnhowsiu019q8fecdjn09FENDOUI  8Aaoifuhnoiufvnoiuhovnouq90req807(*No0Ua098)(*';

Map<String, dynamic> decodeJWT(String token) {
  try {
    final jwt = JWT.verify(token, SecretKey(jwtSecret));
    return jwt.payload as Map<String, dynamic>;
  } catch (e) {
    print('Failed to decode JWT: $e');
    return {};
  }
}
