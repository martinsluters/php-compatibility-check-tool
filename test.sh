GREEN='\033[0;32m';
RED='\033[0;31m';
NC='\033[0m'; # No Color
phpversion="7.4";
userphpversion="";
basesourcepath="./src/";
reportspath="./reports/";
sourcepaths=$basesourcepath;
usersourcepaths="";
phpcscmdsourcepaths="";

echo "${RED}Which version of PHP you would like to use? (press enter for 7.4): ${NC}"
read userphpversion
if [ ! -z "$userphpversion" ]
then
  phpversion="$userphpversion";
fi
echo "${GREEN}${phpversion}${NC}"

echo "${RED}Specify source path(s) relative to "PHP Compatibility Check Tool" to sniff (./src): ${NC}"
read usersourcepaths
if [ ! -z "$usersourcepaths" ]
then
  sourcepaths="$usersourcepaths";
fi

if [ "$basesourcepath" == "$sourcepaths" ]; then
  if [ ! "$(ls $sourcepaths)" ]; then
    echo "${RED}$sourcepaths directory is empty. Nothing to sniff. ${NC}"
    exit;
  fi
fi


for single_sourcepath in $sourcepaths
do
  phpcscmdsourcepaths+="${single_sourcepath} "
done

echo "${GREEN}${phpcscmdsourcepaths}${NC}"

echo "${GREEN}Running PHP compatibility check for PHP $phpversion ${NC}";
./vendor/bin/phpcs -p $phpcscmdsourcepaths --standard=PHPCompatibility --report-full="$reportspath"compatibility-check-full-report-"$phpversion".txt --report-summary="$reportspath"compatibility-check-summary-report-"$phpversion".txt --runtime-set testVersion "$phpversion" --extensions=php -d memory_limit=512M
