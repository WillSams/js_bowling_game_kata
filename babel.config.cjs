module.exports = function(api) {
  api.cache(true);

  const presets = [
    [
      '@babel/preset-env',
      {
        targets: {
          node: 'current',
        },
      },
    ],
  ];
  const plugins = [
    '@babel/plugin-transform-class-properties',
    '@babel/plugin-transform-private-methods',
  ];

  return {
    presets,
    plugins,
  };
};
