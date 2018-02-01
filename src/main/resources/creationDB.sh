#/bin/bash
win_cmd="psql"
linux_cmd="sudo -u postgres psql "

if [ "$1" == "LINUX" ]
then
  _psql="$linux_cmd"
else
  psqlstart
  _psql="$win_cmd"  
fi


RQT_CMD="_psql -U $USERDB $DATADB -c"


$($_psql -version)

createuser -P --interactive taskTrack
#dropuser -U postgres taskTrack

createdb -O taskTrack -E UTF8 taskTrackDB
#dropdb -U "taskTrack" "taskTrackDB"

rm logfile


#Sauvegarde d'une base de données

#sudo -i -u postgres
#pg_dump -f $PATH_SAVE/nom_de_la_base.sql nom_de_la_base 

#Restauration d'une base de données (attention la base doit avoir été recréer préalablement avec createdb)

#sudo -u postgres psql -f $PATH_SAVE/nom_de_la_base.sql nom_de_la_base 

#Creation d'une table utilisateurs:

#sudo -u postgres psql 
#CREATE TABLE  utilisateurs (
#     id SERIAL PRIMARY KEY,
#     email varchar( 60 ) UNIQUE NOT NULL ,
#     mot_de_passe varchar( 32 ) NOT NULL ,
#     nom varchar( 20 ) NOT NULL ,
#     date_inscription date NOT NULL
#    );

#Insersion de données dans la table

# INSERT INTO utilisateurs (email, mot_de_passe, nom, date_inscription) VALUES ('moi@la.com', MD5('tutu'), 'BaMoi', NOW());
# INSERT INTO utilisateurs (email, mot_de_passe, nom, date_inscription) VALUES ('toi@pas.la', MD5('utut'), 'EtToi', NOW());

#Verification de l'insersion

#SELECT * FROM utilisateurs;

#Nous renvoyant le résultat suivant

#Pour supprimer un enregistrement

#delete from utilisateurs where id = 4;