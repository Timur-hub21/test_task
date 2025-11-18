enum EnvType { test }

final class Env {
  final EnvType type;
  final String apiBaseUrl;

  const Env._({required this.type, required this.apiBaseUrl});

  static Env? _instance;

  factory Env() {
    _instance ??= Env._test();
    return _instance!;
  }

  factory Env._test() {
    return const Env._(
      type: EnvType.test,
      apiBaseUrl: 'https://madeindream.com',
    );
  }
}
