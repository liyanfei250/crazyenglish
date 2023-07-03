import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:flutter/material.dart';

/**
 * Time: 2023/5/17 17:49
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description: 批改弹窗
 */
class CorrectionDialog extends BasePage {

  CorrectionDialog({Key? key}) : super(key: key);

  @override
  BasePageState<CorrectionDialog> getState() => _CorrectionDialogState();

}

class _CorrectionDialogState extends BasePageState<CorrectionDialog> {


  @override
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}
