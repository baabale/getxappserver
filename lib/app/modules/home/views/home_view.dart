import 'package:get_server/get_server.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Json(
        {'status': 'success', 'message': 'Welcome to Dart2 on Server,'});
  }
}
