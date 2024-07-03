class MSitefResponseFail {
  final String? codresp;
  final String? message;

  MSitefResponseFail({
    this.codresp,
    this.message,
  });

  factory MSitefResponseFail.fromMap(Map<String, dynamic> map) {
    return MSitefResponseFail(
      codresp: map['CODRESP'],
      message: map['MESSAGE'],
    );
  }
}
