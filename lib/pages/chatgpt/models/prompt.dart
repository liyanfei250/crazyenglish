import 'dart:convert';
import 'package:crazyenglish/pages/chatgpt/controller/prompt.dart';
import 'package:http/http.dart' as http;

const RAW_FILE_URL = "https://raw.githubusercontent.com/";
const MIRRORF_FILE_URL = "https://raw.fgit.ml/";

Future<List<Prompt>> getPrompts() async {
  final List<Prompt> prompts = [];
  const String MIR_JSON = '[{"act": "担任高考英语写作考官","prompt": "我希望你假定自己是高考英语写作考官，根据雅思评判标准，按我给你的高考写作考题和对应答案给我评分，并且按照高考英语写作评分细则给出打分依据。此外，请给我详细的修改意见并写出满分范文。###请依次给到我以下内容：具体分数及其评分依据、文章修改意见、满分范文。\\n"},{"act": "充当英语翻译和改进者","prompt": "我希望你能担任英语翻译、拼写校对和修辞改进的角色。我会用任何语言和你交流，你会识别语言，将其翻译并用更为优美和精炼的英语回答我。请将我简单的词汇和句子替换成更为优美和高雅的表达方式，确保意思不变，但使其更具文学性。请仅回答更正和改进的部分，不要写解释。我的话是“###”，请翻译它。\\n"},{"act": "充当英英词典(附中文解释)","prompt": "将英文单词转换为包括中文翻译、英文释义和一个例句的完整解释。请检查所有信息是否准确，并在回答时保持简洁，不需要任何其他反馈。第一个单词是“###”\\n"},{"act": "充当英语发音帮手","prompt": "我想让你为说汉语的人充当英语发音助手。我会给你写句子，你只会回答他们的发音，没有别的。回复不能是我的句子的翻译，而只能是发音。发音应使用汉语谐音进行注音。不要在回复上写解释。我的第一句话是“###”\\n" },{"act": "担任 AI 写作导师","prompt": "我想让你做一个 AI 写作导师。我将为您提供一名需要帮助改进其写作的学生，您的任务是使用人工智能工具（例如自然语言处理）向学生提供有关如何改进其作文的反馈。您还应该利用您在有效写作技巧方面的修辞知识和经验来建议学生可以更好地以书面形式表达他们的想法和想法的方法。我的第一个请求是“我需要有人帮我修改下面的高考作文 ###”。\\n"} ]';

  // final response = await http.get(
  //   Uri.parse(
  //       '$MIRRORF_FILE_URL/bravekingzhang/awesome-chatgpt-prompts-zh/main/prompts-zh.json'),
  //   headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8'
  //   },
  // );
  //
  // if (response.statusCode == 200) {
  //   final jsonResponse = json.decode(response.body);
  //
  //   for (var item in jsonResponse) {
  //     prompts.add(Prompt(item['act'], item['prompt']));
  //   }
  // } else {
  //   throw Exception('Failed to load prompts');
  // }
  final jsonResponse = json.decode(MIR_JSON);

  for (var item in jsonResponse) {
    prompts.add(Prompt(item['act'], item['prompt']));
  }
  return prompts;
}
