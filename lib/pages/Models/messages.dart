class Messages {
  final String chatGroupMessagesId;
  final String messages;
  final String chatGroupId;
  final String residentId;

  Messages ({
    required this.chatGroupMessagesId,
    required this.messages,
    required this.chatGroupId,
    required this.residentId,
});

  factory Messages.fromJson(Map<String, dynamic> json) {
    return Messages (
      chatGroupMessagesId: json['chatGroupMessages_id'] ?? '',
      messages: json['message'] ?? '',
      chatGroupId: json['chatGroup_id'] ?? '',
      residentId: json['resident_id'] ?? '',
    );
  }
}