#!/bin/bash
# set -e

# 获取当前脚本所在目录
root_path=$(cd `dirname $0`; cd ..; pwd)
package_list=(`cd $root_path; ls -d */ |grep -v "script" |awk -F '/' '{print $1}'`)
package_name=""
latest_tag=""

echo $package_list

# 打印绿色字体
function green(){
  echo -e "\033[32m\033[01m$1\033[0m"
}

# 打印红色字体
function red(){
  echo -e "\033[31m\033[01m$1\033[0m"
}

# 删除 tag
function delete_tag() {
  for name in ${package_list[@]}; do
    tag_num=`git tag --sort=-creatordate |grep $name |wc -l |xargs -I {} echo {}`
    tag_list=(`git tag --sort=-creatordate |grep $name`)
    green "===>>> 清理 $name tag"

    # 保留最新的10个tag
    for index in ${!tag_list[*]}; do
      if [ $index -ge 5 ]; then
        tag=${tag_list[index]}
        green "删除tag: $index: ${tag_list[index]}"
        git tag -d $tag
        git push origin :refs/tags/$tag
      fi
    done
  done
}

# 运行
function run() {
  # 移除本地所有tag
  git tag -l |xargs -I {} git tag -d {}

  # 拉取最新代码
  green "===>>> 拉取最新代码"
  git pull

  # 拉取最新Tag
  green "===>>> 拉取最新Tag"
  git fetch --tags

  # 删除多余的tag
  delete_tag
}


run "$@"
