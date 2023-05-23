#!/bin/bash

ISVALID=false;
P=`pwd`;
FOLDER=$( echo ${P##*/} );
PROYECTS=(api ocr app panel home);
CONFIG='../docker/docker-compose.yml';
PARAMS="$1 $2 $3 $4 $5 $6 $7 $8 $9";

for i in "${PROYECTS[@]}"
do
	if [ ${FOLDER} == $i ] ; then
		ISVALID=true;
	fi
done

fn_exit(){
	if [ ${ISVALID} = false ] ; then
		echo "Desbes estar dentro de un proyecto valido <PREZO>";
		exit; 
	fi
}

fn_bash_container(){
	echo "###############################################################"
	echo "# Accediendo al Container $1";
	echo "###############################################################"
}

if [ "$1" == 'help' ] || [ "$1" == '' ] ; then
	echo 'HELP';
	echo '';
	for i in artisan composer mysql-5.7 mysql-8.0 bash api ocr app panel home
	do
		echo "prezo $i";
	done
	echo '';
	echo "EXAMPLE: prezo artisan MY_COMMAND ARG1 ARG2 ...ARG9";
	echo '';
	fn_exit
	exit;
fi

fn_exit

if [ "$1" == 'mysql' ] ; then

	echo 'mysql-5.7';
	echo 'mysql-8.0';
	exit;
fi

if [ "$1" == 'restore' ] ; then

	echo '	It must exist ./docker/backups/prezo.sql or ocr.sql';
	echo '';
	echo '	use to ocr => docker-compose exec prezo-mysql-8.0 bash -c "mysql -u$MYSQL_USER ocr < ocr.sql";';
	echo '	use to prezo => docker-compose exec prezo-mysql-5.7 bash -c "mysql -u$MYSQL_USER prezo < prezo.sql";';
	echo '';
	exit;
fi

PROYECTS+=("mysql-5.7");
PROYECTS+=("mysql-8.0");
for i in "${PROYECTS[@]}"
do
	if [ "$1" == $i ] ; then
		FOLDER="$1";
		PARAMS="$2 $3 $4 $5 $6 $7 $8 $9";
	fi
done

case "$1" in
  artisan) BIN='php';;
  composer) BIN='composer';;
  cs) BIN='composer cs';;
  *) BIN='bash';;
esac

PARAMS=`echo "${PARAMS}" | xargs`;

if [ "$BIN" == 'bash' ] && [ "$PARAMS" == '' ] ; then
	fn_bash_container $FOLDER
fi

docker-compose -f ${CONFIG} exec "prezo-${FOLDER}" ${BIN} ${PARAMS};

exit 0;