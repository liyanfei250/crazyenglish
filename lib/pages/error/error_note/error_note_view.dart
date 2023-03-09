import 'package:crazyenglish/pages/error/error_note/error_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/AppUtil.dart';
import '../../../base/widgetPage/base_page_widget.dart';
import '../../../r.dart';
import '../../../routes/getx_ids.dart';
import '../../../utils/colors.dart';
import '../error_note_child/error_note_child_view.dart';
import 'error_note_logic.dart';

class ErrorNotePage extends BasePage {
  const ErrorNotePage({Key? key}) : super(key: key);

  @override
  BasePageState<BasePage> getState() => _ToErrorNotePageState();
}

class _ToErrorNotePageState extends BasePageState<ErrorNotePage>
    with SingleTickerProviderStateMixin {
  var _selectedIndex = 0.obs;
  final PageController pageController = PageController(keepPage: true);

  // 禁止 PageView 滑动
  final ScrollPhysics _neverScroll = const NeverScrollableScrollPhysics();

  final logic = Get.put(Error_noteLogic());
  final state = Get.find<Error_noteLogic>().state;

  final List<String> tabs = const [
    '待订正',
    '已订正',
  ];

  void _onItemTapped(int index) {
    _selectedIndex.value = index;
    pageController!.jumpToPage(_selectedIndex.value);
    logic.update([GetBuilderIds.changeNoteList]);
    state.correction = index == 0 ? 0 : 1;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBottomAppBar("错题本"),
      backgroundColor: AppColors.theme_bg,
      body: PageView(
        controller: pageController,
        physics: _neverScroll,
        children: [
          ErrorNoteChildPage(ErrorNoteChildPage.WAIT_CORRECT),
          ErrorNoteChildPage(ErrorNoteChildPage.HAS_CORRECTED),
        ],
      ),
    );
  }

  AppBar buildBottomAppBar(String text) {
    return AppBar(
      backgroundColor: AppColors.c_FFFFFFFF,
      centerTitle: true,
      title: Text(
        text,
        style: TextStyle(
            color: AppColors.c_FF32374E,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold),
      ),
      leading: Util.buildBackWidget(context),
      elevation: 10.w,
      bottom: ErrorTopBar(
        Container(
          height: 40.w,
          width: 120.w,
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildBottomBar(0),
                buildBottomBar(1),
              ],
            ),
          ),
        ),
      ),
      shadowColor: const Color(0x1F000000),
    );
  }

  Widget buildBottomBar(int index) {
    return Expanded(
        child: InkWell(
      onTap: () {
        _onItemTapped(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: EdgeInsets.only(top: 6.w)),
          Obx(() => Text(
                tabs[index],
                style: TextStyle(
                    color: _selectedIndex.value == index
                        ? Color(0xffeb5447)
                        : Colors.grey,
                    fontWeight: _selectedIndex.value == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 14.sp),
              )),
          Padding(padding: EdgeInsets.only(top: 6.w)),
          Obx(() => Container(
                width: 19.w,
                height: 3.w,
                decoration: BoxDecoration(
                    color: _selectedIndex.value == index
                        ? Color(0xffeb5447)
                        : Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(1.5.w))),
              ))
        ],
      ),
    ));
  }
}
