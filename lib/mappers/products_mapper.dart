class ProductsMapper {
  List<String> map(List<dynamic> input) {
    return input.where((element) {
      if (element != null && (element as Map).isNotEmpty) {
        if (element['available']) {
          return true;
        }
      }
      return false;
    }).map((messageMap) {
      String link = messageMap['linkUrl'];
      int index = link.indexOf('.html');
      if (index == -1) {
        return '';
      }
      var string = link.substring(0, index);
      List<String> list = string.split('-');
      return list.last;
    }).toList();
  }
}
