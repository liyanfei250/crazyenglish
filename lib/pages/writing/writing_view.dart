import 'package:bot_toast/bot_toast.dart';
import 'package:crazyenglish/pages/writing/writingDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../base/AppUtil.dart';
import '../../base/widgetPage/base_page_widget.dart';
import '../../base/widgetPage/dialog_manager.dart';
import '../../entity/commit_request.dart';
import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/getx_ids.dart';
import '../../routes/routes_utils.dart';
import '../../utils/colors.dart';
import '../../../entity/week_detail_response.dart' as detail;
import 'writing_logic.dart';
import '../../../utils/text_util.dart';

class WritingPage extends BasePage {
  detail.WeekDetailResponse? testDetailResponse;

  WritingPage({Key? key}) : super(key: key) {
    if (Get.arguments != null && Get.arguments is Map) {
      testDetailResponse = Get.arguments["detail"];
    }
  }

  @override
  BasePageState<BasePage> getState() => _ToOrderDetailPageState();
}

class _ToOrderDetailPageState extends BasePageState<WritingPage> {
  final logic = Get.put(WritingLogic());
  final state = Get
      .find<WritingLogic>()
      .state;
  var exTile = "Everyone Favorite Fruit";
  var exList =
      "Everyone has favorite fruit. My favorite fruit is filled with the purple grape. It is sour. Because I like to eat sour fruit.She is a vine. The purple coat package in the body. A very beautiful. Like a purple pearls. In the sunshine. The glow of beauty. People have seen.Dear friends are you favorite fruit is what? Introduce to me ok?";
  final TextEditingController writController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppBar("Module 1 Unit3写作"),
      backgroundColor: AppColors.theme_bg,
      body: SingleChildScrollView(
        child: _buildClassArea(),
      ),
    );
  }

  @override
  void onCreate() {

    logic.addListenerId(GetBuilderIds.commitAnswerWriting, () {
      RouterUtil.offAndToNamed(
          AppRoutes.ResultPage,arguments: {"detail":state.commitRequest});
    });
  }

  @override
  void onDestroy() {}

  Widget _buildClassArea() =>
      Container(
        width: double.infinity,
        margin:
        EdgeInsets.only(right: 20.w, left: 20.w, top: 17.w, bottom: 17.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image.asset(
                      R.imagesWritingTitleBg,
                      width: 66.w,
                      height: 9.w,
                    ),
                    Text(
                      "题目",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: AppColors.c_FF101010),
                    ),
                  ],
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 16.w)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 2.w,
                  height: 13.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.zero,
                          topLeft: Radius.zero,
                          topRight: Radius.circular(2.w),
                          bottomRight: Radius.circular(2.w)),
                      color: Color(0xff353e4d)),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  "Reading",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: AppColors.c_FF101010),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 8.w)),
            SelectionArea(
              child: Html(
                data: TextUtil.weekDetail.replaceFirst("###content###",
                    widget.testDetailResponse?.obj!.subjectVoList![0].content ?? ""),
                onImageTap: (url,
                    context,
                    attributes,
                    element,) {
                  if (url != null && url!.startsWith('http')) {
                    DialogManager.showPreViewImageDialog(
                        BackButtonBehavior.close, url);
                  }
                },
                style: {
                  "p": Style(fontSize: FontSize.large),
                  "sentence": Style(
                      textDecorationStyle: TextDecorationStyle.dashed,
                      textDecorationColor: AppColors.THEME_COLOR),
                  "hr": Style(
                    margin: Margins.only(
                        left: 0, right: 0, top: 10.w, bottom: 10.w),
                    padding: EdgeInsets.all(0),
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  )
                },
                tagsList: Html.tags..addAll(['sentence']),
              ),
            )
            /*Text(
              widget.testDetailResponse?.data![0].content??"",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                  wordSpacing: 6.w,
                  height: 1.5,
                  color: Color(0xff353e4d)),
            )*/
            ,
            _buildClassCard(0),
            _inputCard(),
          ],
        ),
      );

  Widget _inputCard() =>
      Container(
        margin: EdgeInsets.only(top: 14.w),
        padding:
        EdgeInsets.only(left: 14.w, right: 14.w, top: 14.w, bottom: 14.w),
        width: double.infinity,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.c_FFFFEBEB.withOpacity(0.5), // 阴影的颜色
                offset: Offset(10, 20), // 阴影与容器的距离
                blurRadius: 45.0, // 高斯的标准偏差与盒子的形状卷积。
                spreadRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(10.w)),
            color: AppColors.c_FFFFFFFF),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                Util.toast("写作提交");
                CommitAnswer commitRequest = CommitAnswer(
                    // muchTime: "2023-02-23 02:20:01",
                    // name: "测试写作题",
                    // directory: "1cddffb0-bcef-11ed-8e11-530450f105f5",
                    // directory_uuid: "1cddffb0-bcef-11ed-8e11-530450f105f5",
                    // exercises: widget.testDetailResponse!.data
                );
                logic.uploadWritingTest(commitRequest);
                Get.back();
              },
              child: Image.asset(
                R.imagesWritingCommitButton,
                width: 57.w,
                height: 17.w,
              ),
            ),
            TextField(
              autofocus: true,
              maxLines: 100,
              minLines: 10,
              controller: writController,
              style: TextStyle(color: Color(0xff353e4d), fontSize: 12.sp),
              decoration: InputDecoration(
                //提示信息
                  hintText: "请在这里开始答题吧～",
                  border: InputBorder.none,
                  hintStyle:
                  TextStyle(color: Color(0xffb3b7c6), fontSize: 12.sp)),
            )
          ],
        ),
      );

  Widget _buildClassCard(int index) =>
      Container(
        margin: EdgeInsets.only(top: 20.w),
        padding:
        EdgeInsets.only(left: 14.w, right: 14.w, top: 14.w, bottom: 14.w),
        width: double.infinity,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.c_FFFFEBEB.withOpacity(0.5), // 阴影的颜色
                offset: Offset(10, 20), // 阴影与容器的距离
                blurRadius: 45.0, // 高斯的标准偏差与盒子的形状卷积。
                spreadRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(10.w)),
            color: AppColors.c_FFFFFFFF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_listShow(), _rightShow()],
        ),
      );

  Widget _listShow() =>
      Expanded(
          child: Container(
              height: 190.w,
              child: SelectionArea(
                child: Html(
                  data: TextUtil.weekDetail.replaceFirst("###content###",
                      widget.testDetailResponse?.obj!.subjectVoList![0].content ?? ""),
                  onImageTap: (url,
                      context,
                      attributes,
                      element,) {
                    if (url != null && url!.startsWith('http')) {
                      DialogManager.showPreViewImageDialog(
                          BackButtonBehavior.close, url);
                    }
                  },
                  style: {
                    "p": Style(fontSize: FontSize.large),
                    "sentence": Style(
                        textDecorationStyle: TextDecorationStyle.dashed,
                        textDecorationColor: AppColors.THEME_COLOR),
                    "hr": Style(
                      margin: Margins.only(
                          left: 0, right: 0, top: 10.w, bottom: 10.w),
                      padding: EdgeInsets.all(0),
                      border: Border(bottom: BorderSide(color: Colors.grey)),
                    )
                  },
                  tagsList: Html.tags..addAll(['sentence']),
                ),
              )));

  Widget _rightShow() =>
      Container(
        width: 90.w,
        height: 190.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                //RouterUtil.toNamed(AppRoutes.IntensiveListeningPage);
                Util.toast("查看范文");
                showDialog(
                  context: context,
                  builder: (context) =>
                      WritDialog(
                          exTile,
                          exList,
                          widget.testDetailResponse?.obj!.subjectVoList![0].content ??
                              ""),
                );
              },
              child: Image.asset(
                R.imagesWritingLookBotton,
                width: 77.w,
                height: 18.w,
              ),
            ),
            Expanded(child: Text("")),
            Text(
              "注意：词数100左右",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 10.sp,
                  color: Color(0xfff2a842)),
            ),
          ],
        ),
      );

  // 使用dialog 来自己真正的定义一个对话框
  Widget myDialog(exList) {
    return Dialog(
      // insetPadding: EdgeInsets.all(10), //距离
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      //形状
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      //强制裁剪
      elevation: 10,
      child: Container(
        //需要在内部限制下高度和宽度才能更好的显示
        height: 250,
        width: 300,
        padding: EdgeInsets.all(18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  R.imagesWritingLookBotton,
                  width: 77.w,
                  height: 18.w,
                ),
                Expanded(child: Text('')),
                InkWell(
                    onTap: () {
                      //RouterUtil.toNamed(AppRoutes.IntensiveListeningPage);
                    },
                    child: Image.asset(
                      R.imagesToridClose,
                      width: 12.w,
                      height: 12.w,
                    ))
              ],
            ),
            Text(exTile,
                style: TextStyle(
                    color: Color(0xff353e4d),
                    fontSize: 15.sp,
                    wordSpacing: 2.0,
                    height: 2),
                overflow: TextOverflow.ellipsis,
                maxLines: 5),
            Text(exList,
                style: TextStyle(
                    color: Color(0xff353e4d),
                    fontSize: 14.sp,
                    wordSpacing: 2.0,
                    height: 2),
                overflow: TextOverflow.ellipsis,
                maxLines: 5),
          ],
        ),
      ),
    );
  }
}
