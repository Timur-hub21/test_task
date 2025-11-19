import 'package:flutter/material.dart';

class ErrorContent extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetryTap;

  const ErrorContent({
    required this.errorMessage,
    required this.onRetryTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodySmall?.color,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: onRetryTap,
          child: Text('Retry'),
        ),
      ],
    ),
  );
}
