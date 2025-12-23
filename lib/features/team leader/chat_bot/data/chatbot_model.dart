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