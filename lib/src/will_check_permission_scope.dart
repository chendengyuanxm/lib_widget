import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';

import 'log_util.dart';

class WillCheckPermissionScope extends StatefulWidget {
  final Widget? child;
  final List<Permission>? checkPermissions;

  const WillCheckPermissionScope({Key? key, this.child, @required this.checkPermissions,}) : super(key: key);

  @override
  _WillCheckPermissionScopeState createState() => _WillCheckPermissionScopeState();
}

class _WillCheckPermissionScopeState extends State<WillCheckPermissionScope> with WidgetsBindingObserver {
  List<Permission> _checkPermissions = [];
  late StreamSubscription<FGBGType> subscription;
  late Future<bool> _future;

  @override
  void initState() {
    _registerLifecycleListener();
    super.initState();
    _checkPermissions = widget.checkPermissions ?? [];
    _future = checkPermissions();
  }

  _registerLifecycleListener() {
    WidgetsBinding.instance?.addObserver(this);
    subscription = FGBGEvents.stream.listen((event) {
      LogUtil.v(event.toString()); // FGBGType.foreground or FGBGType.background
      if (event == FGBGType.foreground) {
        checkPermissions();
      }
    });
  }

  _unregisterLifecycleListener() {
    WidgetsBinding.instance?.removeObserver(this);
    subscription.cancel();
  }

  @override
  void dispose() {
    _unregisterLifecycleListener();
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   switch(state){
  //     case AppLifecycleState.resumed:
  //       checkPermissions();
  //       break;
  //     case AppLifecycleState.paused:
  //       break;
  //   }
  // }

  bool verifyPermissions(Map<Permission, PermissionStatus> statuses) {
    statuses.removeWhere((key, value) => value.isGranted);
    return statuses.length <= 0;
  }

  Future<bool> checkPermissions() async {
    LogUtil.v('check permission...');
    Map<Permission, PermissionStatus> statuses = await _checkPermissions.request();
    bool verified = verifyPermissions(statuses);
    LogUtil.v('all permission is granted: $verified');
    if (!verified) {
      // _showMissingPermissionDialog();
    }
    return verified;
  }

  _showMissingPermissionDialog() {
    // Future.delayed(Duration.zero, () async {
    //   DialogUtil.showAlertDialog(context, content: '未获取相关权限，是否前往设置？', onConfirm: () async {
    //     await openAppSettings();
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      initialData: false,
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.data!)
          return Center(
            child: Text.rich(TextSpan(children: [
              TextSpan(text: '未获取相关权限，',),
              TextSpan(
                text: '去设置',
                style: TextStyle(color: Colors.blueAccent),
                recognizer: TapGestureRecognizer()..onTap = openAppSettings,
              ),
            ])),);
        return widget.child!;
      },
    );
  }
}
