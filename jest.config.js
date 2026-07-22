module.exports = {
  testEnvironment: 'jsdom',
  roots: ['<rootDir>/srcjs'],
  transform: {
    '\\.jsx?$': ['babel-jest', { presets: ['@babel/preset-env', '@babel/preset-react'] }]
  },
  moduleNameMapper: {
    // reactR is a webpack external (window.reactR), not an npm package
    '^reactR$': '<rootDir>/srcjs/__mocks__/reactR.js',
    '\\.css$': 'identity-obj-proxy',
    '\\.(woff|woff2|eot|ttf|otf|svg|png|jpg|jpeg|gif)$': '<rootDir>/srcjs/__mocks__/fileMock.js'
  },
  setupFilesAfterEnv: ['<rootDir>/srcjs/__mocks__/setupTests.js']
};
