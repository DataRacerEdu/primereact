var path = require('path');

module.exports = {
    entry: path.join(__dirname, 'srcjs', 'main.jsx'),
    output: {
        path: path.join(__dirname, 'inst/www/primereact/main_bundle'),
        filename: 'bundle.js'
    },
    module: {
        rules: [
            {
                test: /\.js$|jsx/,
                loader: 'babel-loader',
                options: {
                    presets: ['@babel/preset-env', '@babel/preset-react']
                }
            },
            // For CSS so that import "path/style.css"; works
            {
                test: /\.css$/,
                    use: [
                          'style-loader',
                          'css-loader' // simply use css-loader without any options that are not valid
                    ]
            },
            // For icons
            {
                test: /\.(woff|woff2|eot|ttf|otf|svg)$/,
                loader: 'file-loader',
                options: {
                    name: 'fonts/[name].[ext]',
                    outputPath: '',
                },
            }
        ]
    },
    externals: {
        'react': 'window.React',
        'react-dom': 'window.ReactDOM',
        'reactR': 'window.reactR'
    },
    stats: {
        colors: true
    },
    devtool: 'source-map'
};
