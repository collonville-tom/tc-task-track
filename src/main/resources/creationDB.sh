#/bin/bash

#en cas de besoin d'acces aux commandes de bases sur l'ensemble des bases, 
#permet de ne pas utiliser le compte courant de la bd
#pour de la maintenance
#sudo -i -u postgres


USERDB=$(whoami)
DATADB="ttdb"

RQT_CMD="$cmd "

psql --version

#for linux
addDB()
{
	echo "createdb -O $USERDB -E UTF8 $DATADB"
	createdb -O $USERDB -E UTF8 $DATADB; echo "--->Done"	
}

#for linux
dropDB()
{
	echo "dropdb -U $USERDB $DATADB -W"
	dropdb -U $USERDB $DATADB -W; echo "--->Done"	
}

#for linux
#Sauvegarde d'une base de données
#$1 -> chemin de sauvegarde
saveDB()
{
	echo "pg_dump -f $1/$DATADB.sql $DATADB "
	pg_dump -f $1/$DATADB.sql $DATADB ; echo "--->Done"	
}

#for linux
#Restauration d'une base de données (attention la base doit avoir été recréer préalablement avec createdb)
#$1 -> chemin de sauvegarde
loadDB()
{
	echo "psql -U $USERDB $DATADB -c $1"
	psql -f $1/$DATADB.sql $DATADB ; echo "--->Done"	
}



#execution d'une requete
#$1 -> requete sql
execRequest()
{
	echo "psql -c $1 -U $USERDB $DATADB"
	psql -c "$1" -U $USERDB $DATADB ; echo "--->Done"	
}


initDataBase()
{
	echo "Creation des tables"
	execRequest "CREATE TABLE utilisateurs (
		id SERIAL PRIMARY KEY,
		email varchar( 60 ) UNIQUE NOT NULL 
		,mot_de_passe varchar( 32 ) NOT NULL ,
		nom varchar( 20 ) NOT NULL ,
		date_inscription date NOT NULL);"
}


initDatas()
{
	echo "Insertion des données"
	execRequest "INSERT INTO utilisateurs (email, mot_de_passe, nom, date_inscription) VALUES ('moi@la.com', MD5('tutu'), 'BaMoi', NOW());"
	execRequest "INSERT INTO utilisateurs (email, mot_de_passe, nom, date_inscription) VALUES ('toi@pas.la', MD5('utut'), 'EtToi', NOW());"
}

clearDataBase()
{
	echo "Suppression des tables"

	execRequest "DROP TABLE utilisateurs;"
}

initDataBase
initDatas


execRequest "SELECT * FROM utilisateurs;"
#execRequest "delete from utilisateurs where id = 4;"

clearDataBase


#ENDSCRIPT
