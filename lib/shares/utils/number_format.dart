class FormatNumber {
  static usdFormat2Digit(String vNumber) {
    var pData = (vNumber.toString()).split('.');
    var pData0 = pData[0];
    var pData1 = '00';
    if(pData.length > 1) {
      pData1 = pData[1];
      if(pData1.length > 2) {
        pData1 = (pData1.toString()).substring(0, 2);
      } else if (pData1.length < 2) {
        pData1 = pData1.toString() + '0';
      }
    }
    String vData = pData0.toString() + '.'+pData1.toString();
    return vData;
  }
}
