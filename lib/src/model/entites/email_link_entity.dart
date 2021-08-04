class EmailLinkEntity {
  final String email, token;

  EmailLinkEntity(this.email, this.token);

  Map<String, String> toMap() {
    return {
      "email": this.email,
      "token": this.token,
    };
  }

  static EmailLinkEntity toJson(Map<String, dynamic> json) {
    return EmailLinkEntity(json["email"], json["token"]);
  }
}
