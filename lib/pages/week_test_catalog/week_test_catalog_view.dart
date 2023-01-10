import 'package:crazyenglish/base/widgetPage/base_page_widget.dart';
import 'package:crazyenglish/widgets/dash_line.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../entity/week_test_catalog_response.dart';
import '../../entity/week_test_list_response.dart';
import '../../r.dart';
import '../../routes/app_pages.dart';
import '../../routes/getx_ids.dart';
import '../../routes/routes_utils.dart';
import '../../utils/Util.dart';
import '../../utils/colors.dart';
import '../../widgets/treeview/expander_theme_data.dart';
import '../../widgets/treeview/tree_view.dart';
import '../../widgets/treeview/models/node.dart' as tree;
import '../../widgets/treeview/tree_view_controller.dart';
import '../../widgets/treeview/tree_view_theme.dart';
import 'week_test_catalog_logic.dart';

class WeekTestCatalogPage extends BasePage {

  Records? records;

  WeekTestCatalogPage({Key? key}) : super(key: key){
    if(Get.arguments!=null &&
        Get.arguments is Records){
      records = Get.arguments;
    }
  }

  @override
  BasePageState<BasePage> getState() => _WeekTestCatalogPageState();
}

class _WeekTestCatalogPageState extends BasePageState<WeekTestCatalogPage> {
  final logic = Get.put(WeekTestCatalogLogic());
  final state = Get.find<WeekTestCatalogLogic>().state;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  // WeekTestCatalogResponse? paperCategory;
  TreeViewController? treeViewController;

  Set<String> nodeFirst = {};
  Set<String> nodeEnd = {};
  Set<String> nodeEndParent = {};
  @override
  void onCreate() {
    // TODO: implement onCreate
    logic.addListenerId(GetBuilderIds.weekTestCatalogList,(){
      if(state.nodes!=null && state.nodes.length>0){
        // paperCategory = state.weekTestCatalogResponse;
        if(mounted && _refreshController!=null){
          _refreshController.refreshCompleted();
          setState(() {

          });
        }
      }
    });
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    TreeViewTheme _treeViewTheme = TreeViewTheme(
      expanderTheme: ExpanderThemeData(
          // color: Colors.grey.shade800,
          size: 20,
          color: Colors.blue),
      labelStyle: TextStyle(
        fontSize: 16,
        letterSpacing: 0.3,
      ),
      parentLabelStyle: TextStyle(
        fontSize: 16,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w800,
        color: Colors.blue.shade700,
      ),
      iconTheme: IconThemeData(
        size: 18,
        color: Colors.grey.shade800,
      ),
      colorScheme: Theme.of(context).colorScheme,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.c_FFFFFFFF,
        centerTitle: true,
        title: Text("每周习题",style: TextStyle(color: AppColors.c_FF32374E,fontSize: 18.sp),),
        leading: Util.buildBackWidget(context),
        // bottom: ,
        elevation: 0,
      ),
      body: GetBuilder<WeekTestCatalogLogic>(
        id: GetBuilderIds.weekTestCatalogList,
        builder: (logic){
          if(logic.state.nodes!=null && logic.state.nodes.length>0){
            if(treeViewController==null){
              treeViewController = TreeViewController(children:logic.state.nodes!);
              List<tree.Node> nodes = treeViewController!.expandAll();
              nodes.forEach((element) {
                nodeFirst.add(element!.key??"");
                int length = element.children!=null ? element.children.length:0;
                for(int i = 0;i<length;i++){
                  if(i==length-1){
                    // 最后一个章
                    if(element.children[i].children!=null && element.children[i].children!.length>0){
                      int childLength = element.children[i].children.length;
                      nodeEnd.add(element.children[i].children[childLength-1].key??"");
                    }
                    nodeEndParent.add(element.children[i].key??"");
                  }
                }
              });
              treeViewController = TreeViewController(children:nodes!);
            }
            return Container(
              margin: EdgeInsets.only(top: 20.w,left: 14.w,right: 14.w,bottom: 20.w),
              decoration: BoxDecoration(
                  boxShadow:[
                    BoxShadow(
                      color: AppColors.c_0FA50D1A.withOpacity(0.05),		// 阴影的颜色
                      offset: Offset(10, 20),						// 阴影与容器的距离
                      blurRadius: 45.0,							// 高斯的标准偏差与盒子的形状卷积。
                      spreadRadius: 0,
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(6.w)),
                  color: AppColors.c_FFFFFFFF
              ),
              child: Column(
                children: [
                  Expanded(
                    child: TreeView(
                      controller: treeViewController!,
                      nodeBuilder: (context, node)=>buildItem(context, node),
                      onExpansionChanged: (key, expanded) {
                        tree.Node? node = treeViewController!.getNode(key);
                        if (node != null) {
                          List<tree.Node> updated = treeViewController!.updateNode(key, node.copyWith(expanded: expanded));
                          setState(() {
                            treeViewController = treeViewController!.copyWith(children: updated);
                          });
                        }
                      }
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }


  Widget buildItem(BuildContext context, tree.Node node){
    if(node.isParent){
      return Container(
        height: 48.w,
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Visibility(
                        maintainAnimation: true,
                        maintainState: true,
                        maintainSize: true,
                        visible: !nodeFirst.contains(node.key),
                      child: Container(
                          margin: EdgeInsets.only(left:22.w),
                          child: Visibility(
                            visible: node.parent,
                            child: DottedLine(
                              dashLength: 3.w,
                              dashGapLength: 3.w,
                              lineThickness: 2.w,
                              dashColor: AppColors.c_FFE2E2E2,
                              direction: Axis.vertical,
                            ),
                          )),
                    ),
                    ),
                Row(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        width: 17.w,
                        height: 17.w,
                        margin: EdgeInsets.only(left:14.w,right: 14.w),
                        decoration: BoxDecoration(
                            color: AppColors.c_FFFF4D35,
                            borderRadius: BorderRadius.all(Radius.circular(16.w))
                        ),
                        child: Text(node.expanded? "—":"+",style: TextStyle(color: AppColors.c_FFFFFFFF),)
                    ),
                    Text(node.label,style: TextStyle(color:AppColors.TEXT_BLACK_COLOR),)
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Visibility(
                    maintainAnimation: true,
                    maintainState: true,
                    maintainSize: true,
                    visible: !((nodeEndParent.contains(node.key) || nodeFirst.contains(node.key))&& !node.expanded),
                    child: Container(
                        margin: EdgeInsets.only(left:22.w),
                        child: DottedLine(
                          dashLength: 3.w,
                          dashGapLength: 3.w,
                          lineThickness: 2.w,
                          dashColor: AppColors.c_FFE2E2E2,
                          direction: Axis.vertical,
                        )),
                  ),
                ),
              ],
            ),),
            Container(
              height: 1.w,
              width: double.infinity,
              margin: EdgeInsets.only(left: 44.w),
              color: AppColors.c_FFEBEBEB,
            )
          ],
        ),
      );

    }else{
      return InkWell(
        onTap: (){
          RouterUtil.toNamed(AppRoutes.WeeklyTestDetail,arguments: {"id":node.key,"name":node.label});
        },
        child: Container(
          height: 48.w,
          padding: EdgeInsets.only(right: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: EdgeInsets.only(left:22.w),
                        child: DottedLine(
                          dashLength: 3.w,
                          dashGapLength: 3.w,
                          lineThickness: 2.w,
                          dashColor: AppColors.c_FFE2E2E2,
                          direction: Axis.vertical,
                        )),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 12.w,
                        height: 12.w,
                        margin: EdgeInsets.only(left:17.w,right: 18.w),
                        decoration: BoxDecoration(
                            color: AppColors.c_FFFF4D35,
                            borderRadius: BorderRadius.all(Radius.circular(16.w))
                        ),
                      ),
                      Container(
                        width: 250.w,
                        child: Text(node.label,
                          overflow:TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(color:AppColors.TEXT_GRAY_COLOR),),
                      )

                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: Visibility(
                      maintainAnimation: true,
                      maintainState: true,
                      maintainSize: true,
                      visible: !nodeEnd.contains(node.key),
                      child: Container(
                          margin: EdgeInsets.only(left:22.w),
                          child: DottedLine(
                            dashLength: 3.w,
                            dashGapLength: 3.w,
                            lineThickness: 2.w,
                            dashColor: AppColors.c_FFE2E2E2,
                            direction: Axis.vertical,
                          )),
                    ),
                  ),
                ],
              ),
              Image.asset(R.imagesTreeEdit,width: 20.w,height: 20.w,)
            ],
          ),
        ),
      );

    }
  }



  void _onRefresh() async{
    logic.getWeekTestCategory("${widget.records!.id}");
  }

  void _onLoading() async{
    // monitor network fetch
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    logic.getWeekTestCategory("${widget.records!.id}");
  }

  @override
  void dispose() {
    Get.delete<WeekTestCatalogLogic>();
    super.dispose();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}