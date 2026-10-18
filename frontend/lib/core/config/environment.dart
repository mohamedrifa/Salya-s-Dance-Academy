enum EnvironmentType { dev, staging, prod }

class Environment {
  final EnvironmentType type;
  final String name;
  final String defaultBaseUrl;

  const Environment({
    required this.type,
    required this.name,
    required this.defaultBaseUrl,
  });

  static const Environment dev = Environment(
    type: EnvironmentType.dev,
    name: 'Development',
    defaultBaseUrl: 'http://localhost:5117/api/v1',
  );

  static const Environment staging = Environment(
    type: EnvironmentType.staging,
    name: 'Staging',
    defaultBaseUrl: 'https://staging-api.salyasacademy.com/api/v1',
  );

  static const Environment prod = Environment(
    type: EnvironmentType.prod,
    name: 'Production',
    defaultBaseUrl: 'https://api.salyasacademy.com/api/v1',
  );

  static Environment current = Environment.dev;
}
