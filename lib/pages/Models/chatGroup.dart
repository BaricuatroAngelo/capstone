class chatGroup {
  final String chatGroupId;
  
  chatGroup ({
   required this.chatGroupId,
});
  
  factory chatGroup.fromJson(Map<String, dynamic> json) {
    return chatGroup(
        chatGroupId: json['chatGroup_id'],
    );
  }
}