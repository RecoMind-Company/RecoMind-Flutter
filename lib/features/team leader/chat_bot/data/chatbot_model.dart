class createQuery {
  final String? task_id , status , message , user_question ;
  createQuery({required this.task_id,required this.status,required this.message,required this.user_question});
  factory createQuery.fromJson(Map<String, dynamic> json){
    return createQuery(
      task_id: json["task_id"],
      status: json["status"],
      message: json["message"],
      user_question: json["user_question"]
    );
  }
}


class getQuery {
  final String? response,status;
  getQuery({required this.response,required this.status});
  factory getQuery.fromJson(Map<String, dynamic> json){
    return getQuery(
      response: json["response"],
        status: json["status"]
    );
  }
}


/// history
class ChatBotHistoryModel {
  final String? query;
  final String? responseMessage;

  ChatBotHistoryModel({
    this.query,
    this.responseMessage,
  });

  factory ChatBotHistoryModel.fromJson(Map<String, dynamic> json) {
    return ChatBotHistoryModel(
      query: json['query'] as String?,
      responseMessage: json['responseMessage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'query': query,
      'responseMessage': responseMessage,
    };
  }

  // دالة مساعدة لتحويل الـ List القادمة من الباكيند مباشرة
  static List<ChatBotHistoryModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((item) => ChatBotHistoryModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}