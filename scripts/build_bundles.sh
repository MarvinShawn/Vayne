#!bin/sh

echo "--🚀开始打主包🚀--"

npx react-native bundle \
--platform ios \
--dev false \
--entry-file common.js \
--bundle-output rn/dist/common/common.bundle \
--assets-dest rn/dist/common/assets/ \
--config common.config.js\

echo "--💐主包打包完成💐--"

echo "--🚀开始打业务包a🚀--"

npx react-native bundle \
--platform ios \
--dev false \
--entry-file rn/src/business_a/index.js \
--bundle-output rn/dist/buz/buz_a.bundle \
--assets-dest rn/dist/buz/buz_a_assets/ \
--config buz.config.js\

echo "--💐业务包a打包完成💐--"