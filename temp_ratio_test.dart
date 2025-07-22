void main() {
  print('Ratio 25/16: ${25/16}');
  print('Ratio is ${25/16 > 1.7 ? "greater" : "less"} than 1.7');
  
  const validRatios = [1.125, 1.25, 1.333, 1.5, 1.618];
  const tolerance = 0.1;
  final ratio = 25/16;
  
  for (double validRatio in validRatios) {
    final diff = (ratio - validRatio).abs();
    print('Ratio $validRatio: difference $diff (valid: ${diff <= tolerance})');
  }
}
