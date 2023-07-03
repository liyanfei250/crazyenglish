import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/convert.dart';
import 'app_update_panel_logic.dart';

class AppUpdatePanelPage extends StatefulWidget {
  const AppUpdatePanelPage({Key? key}) : super(key: key);

  @override
  _AppUpdatePanelPageState createState() => _AppUpdatePanelPageState();
}

class _AppUpdatePanelPageState extends State<AppUpdatePanelPage> {
  final logic = Get.put(AppUpdatePanelLogic());
  final state = Get.find<AppUpdatePanelLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    Get.delete<AppUpdatePanelLogic>();
    super.dispose();
  }

  Widget _buildProgress(BuildContext context, double progress, int appSize) {
    return Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Column(
            children: [
              Text(
                '${(progress * 100).toStringAsFixed(2)} %',
                style: const TextStyle(height: 1, fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${Convert.convertFileSize((appSize * progress).floor())}/${Convert.convertFileSize(appSize)}',
                style: const TextStyle(height: 1, fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              backgroundColor: Colors.grey,
              value: progress,
            ),
          )
        ]);
  }

  // Widget _buildByUpdateState(BuildContext context, UpdateState state) {
  //   String info = '检查新版本';
  //   Widget trail = const SizedBox.shrink();
  //   if (state is ShouldUpdateState) {
  //     info = "下载新版本";
  //     trail = Wrap(
  //         alignment: WrapAlignment.center,
  //         crossAxisAlignment: WrapCrossAlignment.center,
  //         children: [
  //           Text(
  //             '${state.oldVersion} --> ${state.info.appVersion} ',
  //             style: const TextStyle(height: 1, fontSize: 12, color: Colors.grey),
  //           ),
  //           const SizedBox(width: 5),
  //           const Icon(Icons.update, color: Colors.green)
  //         ]);
  //   }
  //   if (state is CheckLoadingState) {
  //     trail = const CupertinoActivityIndicator();
  //   }
  //   if (state is DownloadingState) {
  //     info = "新版本下载中...";
  //     trail = _buildProgress(context, state.progress, state.appSize);
  //   }
  //
  //   return ListTile(
  //     title: Text(
  //       info,
  //       style: const TextStyle(fontSize: 13),
  //     ),
  //     trailing: trail,
  //     onTap: () => _tapByState(state, context),
  //   );
  // }
  //
  // void _tapByState(UpdateState state, BuildContext context) {
  //   if (state is NoUpdateState) {
  //     BlocProvider.of<UpdateBloc>(context)
  //         .add(const CheckUpdate(appName: 'FlutterUnit'));
  //   }
  //   if (state is ShouldUpdateState) {
  //     // 处理下载的事件
  //     BlocProvider.of<UpdateBloc>(context)
  //         .add(DownloadEvent(appInfo: state.info));
  //   }
  // }
}