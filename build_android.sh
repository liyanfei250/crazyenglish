#!/bin/bash

#flutter build apk --target=lib/main_ios.dart -v

# 设置 COS 和 CDN 参数
bucket="apk-1315843937"
region="ap-beijing"
cdn_domain="apk-download.crazyenglishweekly.com"
secret_id="AKIDMW7UfdPxIRRWQ5XnRyMniSxEHH5f5IHJ"
secret_key="vgCTclhP6kADBwRioiMm04ua1Wp3LUUi"

# 设置 COS 路径和文件名
file_name="crazyenglish.apk"

# 设置本地文件路径
local_file_path="build/app/outputs/flutter-apk/app-release.apk"

coscmd config -a "$secret_id" -s "$secret_key" -r "$region" -b "$bucket"

# 上传
echo "upload $local_file_path $cos_path/$file_name"
coscmd upload "$local_file_path" "$file_name"

echo "upload success ?"
## 刷新 CDN 缓存
# 设置 COS 和 CDN 参数
urls="http://${cdn_domain}/crazyenglish.apk"

echo "刷新 CDN 缓存"
tccli configure set secretId "$secret_id"
tccli configure set secretKey "$secret_key"
tccli configure set region "$region"

tccli cdn PurgeUrlsCache --Urls "[\"$urls\"]"
