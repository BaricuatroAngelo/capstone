class chatGroupUsers {
  final String chatGroupUsersId;
  final String chatGroupId;
  final String residentId;
  final String otherFName;
  final String otherLName;

  chatGroupUsers({
    required this.chatGroupId,
    required this.chatGroupUsersId,
    required this.residentId,
    required this.otherFName,
    required this.otherLName,
});

  factory chatGroupUsers.fromJson(Map<String, dynamic>? json) {
    return chatGroupUsers(
      chatGroupUsersId: json?['chatGroupUsers_id'] as String? ?? '',
      chatGroupId: json?['chatGroup_id'] as String? ?? '',
      residentId: json?['resident_id'] as String? ?? '',
      otherLName: json?['other_resident_lName'] as String? ?? '',
      otherFName: json?['other_resident_fName'] as String? ?? '',
    );
  }
}