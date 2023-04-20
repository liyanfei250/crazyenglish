/**
 * Time: 2023/2/21 13:56
 * Author: leixun
 * Email: leixun33@163.com
 *
 * Description:
 */

mixin AnswerMixin{
  getAnswers();
  bool next();
  bool pre();
  void jumpToQuestion(int index);
  int getQuestionCount();
}