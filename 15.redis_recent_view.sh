while true; do
    # 사용자가 product을 입력할 때마다, 현재시간을 score 해서 zadd
    echo "원하는 상품 입력 또는 나가기(exit)"
    read product
    if [ "$product" == "exit" ]; then
        echo "탈출."
        break
    fi
    timestamp=$(date +%s)
    redis-cli zadd recent:products $timestamp $product
done
echo "사용자의 최근 본 상품 5개목록 : "
redis-cli zrevrange recent:products 0 4
