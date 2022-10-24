
class DoctorsDetails {
  final bool child;
  final String title;

  DoctorsDetails({
    required this.title,
    required this.child,
  });
  @override
  String toString() {
    return 'DoctorsDetails(title: $title, child: $child)';
  }
}
