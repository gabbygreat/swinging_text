import 'package:learn/helper/functions.dart';
import 'package:learn/utils/utils.dart';

class ErrorScreen<T extends FutureSignal> extends StatefulWidget {
  final Object error;
  final StackTrace trace;
  final T signal;

  const ErrorScreen({
    super.key,
    required this.error,
    required this.signal,
    required this.trace,
  });

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildErrorMessage(),
            const SizedBox(
              height: 20,
            ),
            _buildRetryButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    final message = getError(error: widget.error);
    return Text(message);
  }

  Widget _buildRetryButton() {
    if (widget.error is DioException) {
      DioException dioError = widget.error as DioException;
      if (dioError.response?.statusCode == 404) {
        return const SizedBox.shrink();
      } else if (dioError.response?.statusCode == 401) {
        return const SizedBox.shrink();
      }
    }
    return ElevatedButton(
      onPressed: () => widget.signal.reload(),
      child: const Text('Retry'),
    );
  }
}

class ErrorScaffold extends StatelessWidget {
  final ErrorScreen errorScreen;
  const ErrorScaffold({
    super.key,
    required this.errorScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: errorScreen,
    );
  }
}
