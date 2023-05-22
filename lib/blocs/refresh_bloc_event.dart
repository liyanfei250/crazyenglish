abstract class RefreshBlocEvent {}

class InitEvent extends RefreshBlocEvent {}

// 个人信息已刷新
class RefreshPersonInfoEvent extends RefreshBlocEvent{

}

// 答题刷新 相应页面注册监听即可
// 收藏状态改变（需要刷收藏列表、复习首页）
// 错题本纠正 （需要刷收藏列表、复习首页）
// 练习记录（需要刷收藏列表、复习首页）
// 答题页面（需要刷复习页面列表）
class RefreshAnswerStateInfoEvent extends RefreshBlocEvent{

}
