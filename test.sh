GREEN='\033[0;32m';
RED='\033[0;31m';
NC='\033[0m'; # No Color
phpversion="7.3";
userphpversion="";
echo "${RED}Which version of PHP you would like to use? (press enter for 7.3): ${NC}"
read userphpversion
if [ ! -z "$userphpversion" ]
then
  phpversion="$userphpversion";
fi
echo "${GREEN}Running PHP compatibility check for PHP $phpversion ${NC}";
./vendor/bin/phpcs -p ./src/ --standard=PHPCompatibility --report-full=./reports/compatibility-check-full-report-"$phpversion".txt --report-summary=./reports/compatibility-check-summary-report-"$phpversion".txt --runtime-set testVersion "$phpversion" --extensions=php
