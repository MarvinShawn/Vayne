'use strict';
const config = require('./metro_bundle.config')
module.exports = {
    serializer: {
        createModuleIdFactory: config.createModuleIdFactory,
    }
};
