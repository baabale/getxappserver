import 'dart:io';

import 'package:get_server/get_server.dart';
import 'app/routes/app_pages.dart';
import 'dart:developer' as dev;
import 'package:vm_service/utils.dart';
import 'package:vm_service/vm_service_io.dart';
import 'package:watcher/watcher.dart';

void main() async {
  var observatoryUri = (await dev.Service.getInfo()).serverUri;
  if (observatoryUri != null) {
    var serviceClient = await vmServiceConnectUri(
        convertToWebSocketUrl(serviceProtocolUrl: observatoryUri).toString());
    var vm = await serviceClient.getVM();
    var mainIsolate = vm.isolates.first;

    Watcher(Directory.current.path).events.listen((_) async {
      await serviceClient.reloadSources(mainIsolate.id);
      print('App restarted ${DateTime.now()}');
    });
  } else {
    // You need to pass `--enable-vm-service --disable-service-auth-codes` to enable hot reload
  }
  runApp(
    GetServer(
      getPages: AppPages.routes,
      onNotFound: Json({
        'status': 'error',
        'message': 'Not found',
      }),
    ),
  );
}
