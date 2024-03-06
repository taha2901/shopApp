class ChangeFav {
  final bool status;
  final String message;

  ChangeFav({required this.status, required this.message});

  factory ChangeFav.fromJson(json) {
    return ChangeFav(
      status: json['status'],
      message: json['message'],
    );
  }
}
