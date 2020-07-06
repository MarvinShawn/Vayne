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


echo "--🚀开始打业务包b🚀--"

npx react-native bundle \
--platform ios \
--dev false \
--entry-file rn/src/business_a/index.js \
--bundle-output rn/dist/buz/buz_a.bundle \
--assets-dest rn/dist/buz/buz_a_assets/ \
--config buz.config.js\

echo "--💐业务包a打包完成💐--"


echo "--🚀开始打业务包b🚀--"

npx react-native bundle \
--platform ios \
--dev false \
--entry-file rn/src/business_b/index.js \
--bundle-output rn/dist/buz/buz_b.bundle \
--assets-dest rn/dist/buz/buz_b_assets/ \
--config buz.config.js\

echo "--💐业务包b打包完成💐--"


echo "--🚀开始打业务包c🚀--"

npx react-native bundle \
--platform ios \
--dev false \
--entry-file rn/src/business_c/index.js \
--bundle-output rn/dist/buz/buz_c.bundle \
--assets-dest rn/dist/buz/buz_c_assets/ \
--config buz.config.js\

echo "--💐业务包c打包完成💐--"