const path = require('path')
module.exports = {
  lintOnSave: false,
  pluginOptions: {
    // 添加下面这段。src/style/globalValue.less为存放变量的路径＋文件
    'style-resources-loader': {
      preProcessor: 'less',
      patterns: [path.resolve(__dirname, "./src/assets/css/home.less")]
    }
  },
  devServer: {
    overlay: {
      warning: false,
      errors: false,
    },
  },

};
