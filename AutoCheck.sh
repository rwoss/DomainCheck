#!/bin/bash

# 执行 Python 脚本并捕获输出
output=$(echo -e "com\ntest\n0" | python3 GetDomain.py)

# 获取输出结果的倒数第三行
result=$(echo "$output" | tail -n 3 | head -n 1)

# 获取倒数第三行的前五个字符
substring=${result:0:5}

# 打印结果
echo "最后检查的结果: $substring"

# 查找与获取的字符匹配的行的行号
line_number=$(grep -n "$substring" dict/test | cut -d ":" -f1)

if [[ -n "$line_number" ]]; then
    # 删除与获取的字符匹配的行及其以上的所有行
    sed -i "1,$line_number d" dict/test
    echo "已删除匹配的行及其以上的内容"
else
    echo "未找到匹配的字符"
fi