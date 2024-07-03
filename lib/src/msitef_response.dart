class MSitefResponse {
  final String? codresp;
  final String? compDadosConf;
  final String? codtrans;
  final String? tipoParc;
  final String? vltroco;
  final String? redeAut;
  final String? bandeira;
  final String? nsuSitef;
  final String? nsuHost;
  final String? codAutorizacao;
  final String? numParc;
  final String? viaEstabelecimento;
  final String? viaCliente;
  final String? tipoCampos;

  MSitefResponse({
    this.codresp,
    this.compDadosConf,
    this.codtrans,
    this.tipoParc,
    this.vltroco,
    this.redeAut,
    this.bandeira,
    this.nsuSitef,
    this.nsuHost,
    this.codAutorizacao,
    this.numParc,
    this.viaEstabelecimento,
    this.viaCliente,
    this.tipoCampos,
  });

  factory MSitefResponse.fromMap(Map<String, dynamic> map) {
    return MSitefResponse(
      codresp: map['CODRESP'],
      compDadosConf: map['COMP_DADOS_CONF'],
      codtrans: map['CODTRANS'],
      tipoParc: map['TIPO_PARC'],
      vltroco: map['VLTROCO'],
      redeAut: map['REDE_AUT'],
      bandeira: map['BANDEIRA'],
      nsuSitef: map['NSU_SITEF'],
      nsuHost: map['NSU_HOST'],
      codAutorizacao: map['COD_AUTORIZACAO'],
      numParc: map['NUM_PARC'],
      viaEstabelecimento: map['VIA_ESTABELECIMENTO'],
      viaCliente: map['VIA_CLIENTE'],
      tipoCampos: map['TIPO_CAMPOS'],
    );
  }
}
