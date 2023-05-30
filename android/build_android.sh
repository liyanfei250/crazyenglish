#!/bin/bash

# 设置 COS 和 CDN 参数
bucket="apk-1315843937"
region="ap-beijing"
cdn_domain="apk-download.crazyenglishweekly.com"
secret_id="AKIDMW7UfdPxIRRWQ5XnRyMniSxEHH5f5IHJ"
secret_key="vgCTclhP6kADBwRioiMm04ua1Wp3LUUi"

# 设置 COS 路径和文件名
cos_path="/"
file_name="crazyenglish_test.apk"

# 设置本地文件路径
local_file_path=$1

# 上传文件到 COS
content_type=$(file --mime-type -b "$local_file_path")
timestamp=$(date +%s)
date_str=$(TZ=UTC date -R)
#date_value=$(date -u '+%a, %d %b %Y %T GMT')
echo "$date_str"
string_to_sign="PUT\n/\n\ncontent-type:$content_type\ndate:$date_str\n/$bucket$cos_path/$file_name"
signature=$(echo -en "${string_to_sign}" | openssl sha1 -hmac "${secret_key}" -binary | base64)

#coscmd config -a "$secret_id" -s "$secret_key" -r "$region" -b "$bucket"
#

#coscmd upload "$local_file_path" "$cos_path/$file_name"

## 刷新 CDN 缓存
# 设置 COS 和 CDN 参数
cdn_domain="apk-download.crazyenglishweekly.com"
urls="http://${cdn_domain}/crazyenglish.apk"

# 腾讯云账户信息
SECRET_ID="AKIDMW7UfdPxIRRWQ5XnRyMniSxEHH5f5IHJ"
SECRET_KEY="vgCTclhP6kADBwRioiMm04ua1Wp3LUUi"

# 要刷新的 URL 或目录列表
# 使用 PurgeUrlsCache（刷新 URL 缓存）或 PurgePathCache（刷新目录缓存）作为操作名称
ACTION="PurgeUrlsCache"
URLS_OR_PATHS=("$urls")

# 腾讯云 API 请求参数
HOST="cdn.tencentcloudapi.com"
SERVICE="cdn"
ALGORITHM="TC3-HMAC-SHA256"
VERSION="2018-06-06"
REGION="ap-beijing"
TIMESTAMP=$(date +%s)
DATE=$(date -u +"%Y-%m-%d")
REQUEST="tc3_request"

# 准备签名信息
function hmac_sha256() {
  digest="$(echo -n "$2" | openssl dgst -binary -sha256 -hmac "$1" | xxd -p -c 256)"
  echo -n "$digest"
}

function signature() {
  secret_date=$(hmac_sha256 "TC3${SECRET_KEY}" "${DATE}")
  secret_service=$(hmac_sha256 "${secret_date}" "${SERVICE}")
  secret_signing=$(hmac_sha256 "${secret_service}" "${REQUEST}")
  signature=$(hmac_sha256 "${secret_signing}" "${1}")
  echo -n "${signature}"
}

# 构建请求 URL 列表或目录列表字符串
url_list=""
for url in "${URLS_OR_PATHS[@]}"; do
  url_list+="\"${url}\","
done
url_list=$(echo "${url_list}" | sed 's/,$//')

# 构建请求正文
request_payload="{
  \"Action\": \"${ACTION}\",
  \"Version\": \"${VERSION}\",
  \"Region\": \"${REGION}\",
  \"Urls\": [${url_list}]
}"

# 构建签名字符串
canonical_request="POST
/
content-type:application/json
host:${HOST}
x-tc-action:${ACTION}
x-tc-region:${REGION}
x-tc-timestamp:${TIMESTAMP}
x-tc-version:${VERSION}
${request_payload}"

hashed_canonical_request=$(echo -n "${canonical_request}" | openssl dgst -sha256 | awk '{print $2}')
string_to_sign="${ALGORITHM}\n${TIMESTAMP}\n${DATE}/${SERVICE}/${REQUEST}\n${hashed_canonical_request}"
signed_signature=$(signature "${string_to_sign}")

# 构建 curl 请求
authorization="${ALGORITHM} Credential=${SECRET_ID}/${DATE}/${SERVICE}/${REQUEST}, SignedHeaders=content-type;host, Signature=${signed_signature}"
request_headers="-H \"Content-Type: application/json\" -H \"Authorization: ${authorization}\" -H \"X-TC-Action: ${ACTION}\" -H \"X-TC-Version: ${VERSION}\" -H \"X-TC-Timestamp: ${TIMESTAMP}\" -H \"X-TC-Region: ${REGION}\""

# 发送请求
response=$(eval "curl -s -X POST https://${HOST} ${request_headers} -d '${request_payload}'")

# 输出结果
echo "Response:"
echo "${response}"