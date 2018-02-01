#/bin/bash

#en cas de besoin d'acces aux commandes de bases sur l'ensemble des bases, 
#permet de ne pas utiliser le compte courant de la bd
#pour de la maintenance
#sudo -i -u postgres

USERDB=$(whoami)
DATADB="ttdb"

RQT_CMD="$cmd "

psql --version

addDB()
{
  createdb -O $USERDB -E UTF8 $DATADB	
}

dropDB()
{
  dropdb -U $USERDB $DATADB -W
}

#Sauvegarde d'une base de données
#$1 -> chemin de sauvegarde
saveDB()
{
  pg_dump -f $1/$DATADB.sql $DATADB 
}

#Restauration d'une base de données (attention la base doit avoir été recréer préalablement avec createdb)
#$1 -> chemin de sauvegarde
loadDB()
{
  psql -f $1/$DATADB.sql $DATADB 
}

#execution d'une requete
#$1 -> requete sql
execRequest()
{
	psql -U $USERDB $DATADB -c "$1"
}

execRequest "CREATE TABLE  utilisateurs (id SERIAL PRIMARY KEY,email varchar( 60 ) UNIQUE NOT NULL ,mot_de_passe varchar( 32 ) NOT NULL ,nom varchar( 20 ) NOT NULL ,date_inscription date NOT NULL);"

execRequest "INSERT INTO utilisateurs (email, mot_de_passe, nom, date_inscription) VALUES ('moi@la.com', MD5('tutu'), 'BaMoi', NOW());"

execRequest "INSERT INTO utilisateurs (email, mot_de_passe, nom, date_inscription) VALUES ('toi@pas.la', MD5('utut'), 'EtToi', NOW());"

execRequest "SELECT * FROM utilisateurs;"

execRequest "delete from utilisateurs where id = 4;"

saveDB .

#ENDSCRIPT
