class IMC {
  String peso = "", altura = "";

  IMC(this.peso, this.altura);

  static int valorImc(int peso, double altura) {
    return peso ~/ (altura * altura);
  }
}