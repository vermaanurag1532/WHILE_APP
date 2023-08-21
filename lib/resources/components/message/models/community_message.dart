class CommunityMessage {
  CommunityMessage({
    required this.toId,
    required this.msg,
    required this.read,
    required this.types,
    required this.fromId,
    required this.sent,
    required this.senderName,
  });

  late final String toId;
  late final String msg;
  late final String read;
  late final String fromId;
  late final String sent;
  late final Types types;
  late final String senderName;

  CommunityMessage.fromJson(Map<String, dynamic> json) {
    toId = json['toId'].toString();
    msg = json['msg'].toString();
    read = json['read'].toString();
    types =
        json['type'].toString() == Types.image.name ? Types.image : Types.text;
    fromId = json['fromId'].toString();
    sent = json['sent'].toString();
    senderName = json['senderName'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['toId'] = toId;
    data['msg'] = msg;
    data['read'] = read;
    data['type'] = types.name;
    data['fromId'] = fromId;
    data['sent'] = sent;
    data['senderName'] = senderName;
    return data;
  }
}

enum Types { text, image }
