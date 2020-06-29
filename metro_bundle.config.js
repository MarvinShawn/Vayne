const pathSep = require('path').sep;
const md5 = require('js-md5');

function createModuleIdFactory() {
  const projectRootPath = __dirname;
  return (path) => {
    let name = '';
    if (path.indexOf(projectRootPath) == 0) {
      name = path.substr(projectRootPath.length + 1);
    }
    let regExp = pathSep == '\\' ? new RegExp('\\\\', "gm") : new RegExp(pathSep, "gm");
    name = name.replace(regExp, '_');
    name = md5(name);
    return name;
  };
}

function processModuleFilter(module) {
  if (module['path'].indexOf('__prelude__') >= 0) {
    return false;
  }
  if (module['path'].indexOf(pathSep + 'node_modules' + pathSep) > 0) {
    if ('js' + pathSep + 'script' + pathSep + 'virtual' == module['output'][0]['type']) {
      return true;
    }
    return false;
  }
  return true;
}


module.exports = {
  createModuleIdFactory,
  processModuleFilter
}