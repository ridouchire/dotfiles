if [ -f /usr/bin/php ]; then
    alias phpchecksyntax='find . -type f -name "*.php" -exec php -d error_reporting=32767 -l {} \; 2>&1 >&- | grep "^"'
fi
