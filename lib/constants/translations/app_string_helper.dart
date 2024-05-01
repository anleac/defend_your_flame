class AppStringHelper {
  static const String _descriptionGap = '\n\n';

  static String purchasableDescription({required List<String> attributes, String? quote}) {
    var description = '';
    for (var attribute in attributes) {
      description += '- $attribute$_descriptionGap';
    }

    if (quote != null) {
      description += '$_descriptionGap\n"$quote"';
    }

    return description;
  }
}
