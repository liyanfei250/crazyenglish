import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/widgetPage/base_page_widget.dart';
import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/routes_utils.dart';
import '../../utils/colors.dart';
import 'splash_new_logic.dart';

class SplashPageNew extends BasePage {
  const SplashPageNew({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToSplashPageState();
}

class _ToSplashPageState extends BasePageState<SplashPageNew> {
  final logic = Get.put(Splash_newLogic());
  final state = Get.find<Splash_newLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.theme_bg,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(R.imagesSplashBg), fit: BoxFit.cover),
            ),
          ),
          Positioned(
              top: 15.w,
              right: 15.w,
              child: Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: 50.w, right: 27.w),
                child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      RouterUtil.toNamed(AppRoutes.RolePage);
                    },
                    child: Container(
                      height: 26.w,
                      width: 72.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        //圆角半径
                        borderRadius:
                            const BorderRadius.all(Radius.circular(18)),
                        //边框线宽、颜色
                        border: Border.all(width: 1.0, color: Colors.red),
                      ),
                      child: const Text('跳过',
                          style: TextStyle(color: Colors.red, fontSize: 12)),
                    )),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                R.imagesSplashCenterImage,
                width: 238.w,
                height: 212.w,
              ),
              SizedBox(
                height: 26.w,
              ),
              Image.asset(
                R.imagesSplashCenterText,
                width: 274.w,
                height: 54.w,
              ),
            ],
          ),
          Positioned(
            bottom: 20.w,
            child: Image.asset(
              R.imagesSplashBottomLogo,
              width: 109.w,
              height: 30.w,
            ),
          )
        ],
      ),
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}
