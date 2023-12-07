class chatGroupUsers {
  final String chatGroupUsersId;
  final String chatGroupId;
  final String residentId;

  chatGroupUsers({
    required this.chatGroupId,
    required this.chatGroupUsersId,
    required this.residentId,
});

  factory chatGroupUsers.fromJson(Map<String, dynamic> json) {
    return chatGroupUsers(
      chatGroupUsersId: json['chatGroupUsers_id'],
      chatGroupId: json['chatGroup_id'],
      residentId: json['resident_id'],
    );
  }
}