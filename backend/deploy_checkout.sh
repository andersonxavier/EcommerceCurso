#!/usr/bin/env bash
# exit when any command fails
set -e

# Deixar o mesmo nome q esta em build_resources.sh pq ele puxa pelo nome
APPNAME="ecommerceappcursoax"

#cd ../   #Volta um diretorio para compilar e subir.
cd ../src  # Mudei os arquivos do projeto template para o src!

# Aqui usa o Azure core function que instalamos
# Publica um codigo para functional APP
func azure functionapp publish $APPNAME
