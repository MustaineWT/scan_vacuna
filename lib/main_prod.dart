import 'app/core/utils/enviroments.dart';
import 'main_common.dart';

Future<void> main() async {
  await mainCommon(Environment.prod);
}
