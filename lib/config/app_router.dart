import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// 🛣️ Application routing configuration
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      // TODO: Add your routes here
    ],
    
    // 🚫 Error page
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('🚫 Page Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'The page you are looking for was not found',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              state.error.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('🏠 Back to Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
