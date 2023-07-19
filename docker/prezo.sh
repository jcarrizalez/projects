#!/bin/bash
###  ! / usr /bin / env bash
### shc -rf prezo.sh -o prezo; rm prezo; mv prezo.sh.x.c prezo; chmod +x prezo;
### shc -U -f prezo.sh -o prezo; chmod +x prezo;
### /usr/bin/shc -vrf welcome.sh -o welcome
### shc -T -f script.sh

### stop=false;
### i=1
### sp="/-\|"
### echo -n ' '
### while true
### do
###   printf "\b${sp:i++%${#sp}:1}"

###     if [ "$stop" == true ] ; then
###     	break;
###     fi

### done & 
### echo '123456y'
### sleep 10
### stop=true
### exit;

P=`pwd`;
YML='docker-compose.yml';
CONTAINERS_IGNORE=("meilisearch redis s3");
PATH_ABSOLUTE=$(dirname $0)

PROYECTS=`ls "$PATH_ABSOLUTE/sources" | sort`;
DIR=`echo $PATH_ABSOLUTE | sed 's/\/docker//g'`;
PROYECT=`echo $PATH_ABSOLUTE | sed 's/\/docker//g'`;
PROYECT=`echo ${PROYECT##*/}`;
FOLDER=$( echo ${P##*/} );
SELECT='';
PARAMS='';
ISVALID=false;
orange=`tput setaf 3`;green=`tput setaf 2`;red=`tput setaf 1`;reset=`tput sgr0`;
P1=$1;P2=$2;P3=$3;P4=$4;P5=$5;P6=$6;P7=$7;P8=$8;P9=$9;

fn_set_alias_mac (){

	if test -d "/Library/LaunchDaemons/"; then

		for IP in `cat ${PATH_ABSOLUTE}/${YML} | grep ' "127.0.0' | cut -d '"' -f2 | cut -d ':' -f1 | uniq | sort`
		do
			ALIAS="alias-prezo-lo0.${IP}";
			FILE="/Library/LaunchDaemons/${ALIAS}.plist";

			if [ "${1}" = 'up' ]; then

				if test -f "$FILE"; then
					ISFILE=true;
				else
					cat ${PATH_ABSOLUTE}/alias-lo0.plist | sed "s/{{ALIAS}}/${ALIAS}/g" | sed "s/{{IP}}/${IP}/g" > ${PATH_ABSOLUTE}/${ALIAS};
					sudo chmod 0644 ${PATH_ABSOLUTE}/$ALIAS;
					sudo chown root:wheel ${PATH_ABSOLUTE}/$ALIAS;
					sudo mv ${PATH_ABSOLUTE}/${ALIAS} $FILE;
					sudo launchctl load -w $FILE;
					sudo ifconfig lo0 alias $IP up;
				fi
			fi

			if [ "${1}" = 'down' ]; then
				if test -f "$FILE"; then
					sudo launchctl unload -w $FILE;
					sudo rm $FILE;
					sudo ifconfig lo0 alias $IP down;
				fi
			fi
		done
	fi
}

fn_set_params (){
	PARAMS=`echo "$1" | xargs`;
}

fn_container (){
	if [ "${2}" != '' ] ; then

		declare -a MyArray=();
		for i in "${2}"; do MyArray+=($i); done
		unset MyArray[0]
		ROW=`echo ${2} |sed 's/\// /g' | cut -d ' ' -f1`;

		#CUSTOMER REPLACE
		case $ROW in 
		  artisan) FIRST='php artisan';;
		  cs) FIRST='composer cs';;
		  *) FIRST=$ROW;;
		esac

		bash="${FIRST} ${MyArray[@]}"

		docker-compose -f ${PATH_ABSOLUTE}/${YML} exec prezo-${1} ${bash};
	else
		docker-compose -f "${PATH_ABSOLUTE}/${YML}" exec prezo-${1} bash;
	fi
}

fn_print (){

	lengt2=`echo "$2" | wc -c`;
	lengt3=`echo "$3" | wc -c`;
	num1=`echo "${lengt2}+5" | bc`
	if [[ $lengt3 -ge $lengt2 ]]; then
		num1=`echo "${lengt3}+15" | bc`
 	fi
	
	CR='';
	for i in $(seq 1 $num1); do CR+="═"; done
	num2=`echo "${num1}-4" | bc`
	ERROR=`printf "%-${num1}s" "${reset}${2}"`

	case "$1" in
	  red) color=$red;;
	  orange) color=$orange;;
	  *) color=$green;;
	esac

	echo '';
	echo "${color}╔${CR}╗${reset}";
	echo "${color}║   ${ERROR}${color}   ║${reset}"

	if [ "${3}" != '' ]; then
		echo "${color}╠${CR}╣${reset}";
	else
		echo "${color}╚${CR}╝${reset}";
	fi

	if [ "${3}" != '' ]; then
		VALUE=`printf "%-${num1}s" "  ${reset}  ${3}"` 
		SPACE=`printf "%-${num2}s" ""` 
		SPACE=`echo ${SPACE// /═}`
		echo "${color}╠═══${VALUE}${color}═══╣${reset}"
		echo "${color}╚${SPACE}════╝${reset}"
	fi

	if [ "${4}" != '' ]; then
		echo '';
	fi
	# echo '╔╗╚╝═║╣╠';
}

fn_exit () {
  if [ "${1}" = "exit" ]; then exit 1; fi
}

fn_selector(){
	fn_print "$3" "$2" "$4"
	OPTIONS=($1 "exit")
	SELECT='exit';
	while true; do
		select option in "${OPTIONS[@]}" ; do
			if [ -n "${option}" ]; then
				break
			fi
			echo 'Sorry, please enter a number as shown.'
			break
		done;
		if [ "${option}" = "exit" ]; then
			break
		fi
		if [ -n "${option}" ]; then
			SELECT="${option}"
			break;
		fi
	done

	fn_exit $SELECT
}

if [ -e "$PATH_ABSOLUTE/prezo.sh.x.c" ] ; then
  rm "$PATH_ABSOLUTE/prezo.sh.x.c"
fi

# DECLARACION DE CONTENEDORES A USAR
CONTAINERS=''
for i in `cat "$PATH_ABSOLUTE/$YML" | grep container_name: | grep -v nginx | sed 's/prezo-//g' | sed 's/container_name: //g' | grep -v '#' | sort`
do
	if [[ " ${CONTAINERS_IGNORE[*]} " =~ " $i " ]]; then
		CONTAINERS=$CONTAINERS
	else
		CONTAINERS+="$i "
		if [ ${FOLDER} == $i ] ; then
			ISVALID=true;
		fi
	fi
done
CONTAINERS=`echo "$CONTAINERS" | xargs`;

if [ ${ISVALID} == false ] && [ "${FOLDER}" != "${PROYECT}" ] && [ "${FOLDER}" != "docker" ]  ; then

	fn_print 'red' 'ERROR' 'Desbes estar dentro de un proyecto valido <PREZO>';
	exit; 
fi

fn_set_params "$P1 $P2 $P3 $P4 $P5 $P6 $P7 $P8 $P9"

for i in $CONTAINERS
do
	if [ "${P1}" == "$i" ] ; then
		FOLDER=$P1;
		fn_set_params "$P2 $P3 $P4 $P5 $P6 $P7 $P8 $P9"
	fi
done

if [ "${PARAMS}" == 'alias up' ]; then
	fn_set_alias_mac 'up'
	exit;
fi

if [ "${PARAMS}" == 'alias down' ]; then
	fn_set_alias_mac 'down'
	exit;
fi

if [ "${PARAMS}" == 'up' ] || [ "${PARAMS}" == 'up -d' ]; then
	docker-compose -f ${PATH_ABSOLUTE}/${YML} up -d;
	exit;
fi
if [ "${PARAMS}" == 'down' ]; then
	docker-compose -f ${PATH_ABSOLUTE}/${YML} down;
	exit;
fi

if [ "${P1}" == 'logs' ]; then

	MONITOR=`cat "$PATH_ABSOLUTE/$YML" | grep container_name: | sed 's/prezo-//g' | sed 's/container_name: //g' | grep -v '#' | sort`

	if [[ " ${MONITOR[*]} " =~ "$P2" ]]; then
		MONITOR="$P2";
	else
		fn_selector "$MONITOR" 'SELECCIONE UN CONTENEDOR A MONITOREAR' 'green'
		MONITOR=$SELECT;
	fi
	docker-compose logs -f ${PATH_ABSOLUTE}/${YML} "prezo-${MONITOR}"
	exit;
fi

if [ "$PARAMS" == 'ngrok' ]; then

	fn_selector "api ocr panel home app" 'SELECCIONE UN CONTENEDOR A EXPONER' 'green'

	if [ "${SELECT}" == 'app' ]; then
		docker-compose -f ${PATH_ABSOLUTE}/${YML} exec "prezo-${SELECT}" sh -c 'cd /var/www/html && /opt/ngrok/ngrok start --config=/opt/ngrok/ngrok.yml http';
	else
		docker-compose -f ${PATH_ABSOLUTE}/${YML} exec "prezo-nginx-${SELECT}" sh -c 'cd /var/www/public/ && /opt/ngrok/ngrok start --config=/opt/ngrok/ngrok.yml http';
	fi
	exit;
fi

if [ "${FOLDER}" == "${PROYECT}" ] && [ "${PARAMS}" != 'restore' ]  &&  [ "$PARAMS" != 'backup' ] && [ "${PARAMS}" != 'mysql' ]; then
	fn_selector "$CONTAINERS" 'SELECCIONE UN CONTENEDOR' 'green'
	FOLDER=$SELECT;
	fn_set_params "$P1 $P2 $P3 $P4 $P5 $P6 $P7 $P8 $P9"
fi

# # POR HACER RESTORE BASE DE DATOS
if [ "$P1" == 'help' ] ; then

	echo '	It must exist ./docker/backups/prezo.sql or ocr.sql';
	echo '';
	echo "	use to ocr => docker-compose exec prezo-mysql-8.0 bash -c 'mysql -u\$MYSQL_USER \$MYSQL_DATABASE < ocr.sql';";
	echo "	use to prezo => docker-compose exec prezo-mysql-5.7 bash -c 'mysql -u\$MYSQL_USER \$MYSQL_DATABASE < prezo.sql';";
	echo '';
	exit;
fi

if [ "$PARAMS" == 'mysql' ] || [ "$PARAMS" == 'restore' ] || [ "$PARAMS" == 'backup' ]; then

	# for i in $CONTAINERS
	# do
	# 	if [ ${FOLDER} == ${i} ] ; then

	# 		echo $i
	# 	fi
	# done


	MESSAGE='SELECCIONE UN CONTENEDOR DATABASE';
	if [ "$PARAMS" == 'restore' ]; then
		MESSAGE+=' 1/3';
	fi
	if [ "$PARAMS" == 'backup' ]; then
		MESSAGE+=' 1/2';
	fi

	fn_selector "`echo $CONTAINERS | tr [:space:] '\n' | grep mysql | xargs`" "${MESSAGE}" 'green'
	FOLDER=$SELECT;

	if [ "$PARAMS" == 'mysql' ]; then
		fn_print "orange" "Acceso al Container <${FOLDER}>"
		fn_container "${FOLDER}"
		exit;
	fi

	if [ ${FOLDER} == ${PROYECT} ]; then
		VIEW='./docker/backups';
	else
		VIEW='../docker/backups';
	fi

	docker-compose -f ${PATH_ABSOLUTE}/${YML} exec "prezo-${FOLDER}" sh -c 'FILE="/root/mysql-credentials.cnf"; echo "[client]" > $FILE; echo "user=root" >> $FILE; echo "password=$MYSQL_ROOT_PASSWORD" >> $FILE';

	DATABASES=`docker-compose -f ${PATH_ABSOLUTE}/${YML} exec "prezo-${FOLDER}" bash -c 'mysql --defaults-extra-file=/root/mysql-credentials.cnf -e "show databases;"' | sed 's/|//g' | grep -v '+--' | grep -v 'Database' | grep -v '_schema' | grep -v 'sys' | grep -v 'mysql' | xargs;`;

	if [ "$(echo $DATABASES | grep 'ERROR')" != "" ]; then
		fn_print 'red' 'ERROR';

		printf " MESSAGE %0s" " => " 
		echo $DATABASES
		exit;
	fi

	MESSAGE="SELECCIONE UNA BASE DE DATABASE <${FOLDER}> 2/3";
	SUBMESSAGE='DROP/CREATE/RESTORE en el siguiente paso';
	if [ "$PARAMS" == 'backup' ]; then
		MESSAGE="SELECCIONE UNA BASE DE DATABASE <${FOLDER}> 2/2";
		SUBMESSAGE="los respaldos se alojan en ${VIEW}/*.sql";
	fi
	fn_selector "`echo $DATABASES | tr [:space:] '\n' | xargs`" "${MESSAGE}" 'green' "${SUBMESSAGE}"
	DATABASE=$SELECT;

	if [ "$PARAMS" == 'restore' ]; then
		MESSAGE="SELECCIONE UN RESPALDO SQL para <${FOLDER}>:${DATABASE} 3/3";
		BACKUPS=`cd "$PATH_ABSOLUTE/backups"; ls *.sql`;
		fn_selector "`echo $BACKUPS | tr [:space:] '\n' | xargs`" "${MESSAGE}" 'orange' 'Se ejecutara la accion inmediatamente al seleccionar un respaldo'
		BACKUP=$SELECT;

		echo "DROP DATABASE ${DATABASE}";
		docker-compose -f ${PATH_ABSOLUTE}/${YML} exec "prezo-${FOLDER}" bash -c "mysql --defaults-extra-file=/root/mysql-credentials.cnf -e 'DROP DATABASE ${DATABASE};'";
		echo "CREATE DATABASE ${DATABASE}";
		docker-compose -f ${PATH_ABSOLUTE}/${YML} exec "prezo-${FOLDER}" bash -c "mysql --defaults-extra-file=/root/mysql-credentials.cnf -e 'CREATE DATABASE ${DATABASE};'";

		printf "RESTORE DATABASE ${DATABASE} START [%0s]" `date +%T`
		docker-compose -f ${PATH_ABSOLUTE}/${YML} exec "prezo-${FOLDER}" bash -c "mysql --defaults-extra-file=/root/mysql-credentials.cnf $DATABASE < $BACKUP";
		printf " END [%0s]" `date +%T` 
	fi

	if [ "$PARAMS" == 'backup' ]; then

		date=`date +%Y-%d-%m_%H%M%S`;
		printf "DUMP DATABASE ${DATABASE} START [%0s]" `date +%T`
		docker-compose -f ${PATH_ABSOLUTE}/${YML} exec "prezo-${FOLDER}" bash -c "mysqldump --defaults-extra-file=/root/mysql-credentials.cnf $DATABASE > ${DATABASE}-${date}.sql";
		docker-compose -f ${PATH_ABSOLUTE}/${YML} exec "prezo-${FOLDER}" bash -c "chmod 777 ${DATABASE}-${date}.sql";
		printf " END [%0s]" `date +%T`
		echo '';
		ls -lht ${VIEW}/${DATABASE}-${date}.sql
	fi
	echo '';
	exit;
fi

if [ "${FOLDER}" == "docker" ]  ; then
	fn_print 'red' 'ERROR' 'Desbes estar dentro de un proyecto valido <PREZO>';
	exit; 
fi

if [ "$PARAMS" == '' ] || [ "$PARAMS" == 'bash' ]; then
	fn_print "orange" "Acceso al Container <${FOLDER}>"
	fn_container "${FOLDER}"
else
	fn_print "green" "Ejecucion de [${PARAMS}] en Container <${FOLDER}>"
	fn_container "${FOLDER}" "${PARAMS}"
fi

exit 0;