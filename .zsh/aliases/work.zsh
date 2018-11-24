run_unit_test() {
    if [ $1 ] ; then
        echo "Run $1 test"
        docker exec -it devcart_php_1 bash -c "cd _tools/unit_tests && ../../app/lib/vendor/bin/phpunit ../../$1"
    else
        docker exec -it devcart_php_1 bash -c 'cd _tools/unit_tests && ../../app/lib/vendor/bin/phpunit'
    fi
}
