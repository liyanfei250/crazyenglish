import 'package:crazyenglish/routes/getx_ids.dart';
import 'package:get/get.dart';

/**
 * Time: 2023/3/29 08:49
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */
abstract class ChooseIntel<N>{

  // key
  String getDataId(String key,N n);

  void addSelected(String key,N n,bool isSelected);

  void selectAll(String key,bool isSelected);

  void addData(String key,List<N> list);

  void resetData(String key,List<N> list);

  int countSelectedNum();

  bool isDataSelected(String key,N n);

  bool hasSelectedAll(String key);

}

class ChooseLogic extends GetxController {

  void updateCheckboxState(String key){
    update([GetBuilderIds.updateCheckBox+key]);
  }
}
