import 'package:circular_gradient_spinner/circular_gradient_spinner.dart';
import 'package:learn/utils/utils.dart';

class CustomLoader extends StatelessWidget {
  final double strokeWidth;
  final double size;
  final double? height;
  final bool isAnimation;
  const CustomLoader({
    super.key,
    this.strokeWidth = 4,
    this.size = 20,
    this.height,
    this.isAnimation = false,
  });

  const CustomLoader.animation({
    Key? key,
    double size = 100,
  }) : this(
          key: key,
          size: size,
          isAnimation: true,
        );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularGradientSpinner(
        color: Colors.blue,
        strokeWidth: strokeWidth,
        size: size,
      ),
    );
  }
}
