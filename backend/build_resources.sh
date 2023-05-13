#!/usr/bin/env bash
# exit when any command fails
set -e

TENANT="17fbab5b-34c7-4623-ba11-7c10638edff9"
#TENANT="d6899ed6-5580-44f1-a812-b557fe2f882c" #Usado no curso
SUBSCRIPTION="1a028b4d-0d39-45c0-9cb0-1953f27278e2"
#SUBSCRIPTION="d1b33a9b-d622-42a8-a58a-2f33f42da18e" # usado no curso
LOCATION="westeurope"
RESOURCEGROUP="ecommerce"

#Nenuma outra pessoa no mundo da Azure pode ter esse nome. pq ele sao publicos.
STORAGEACCOUNTNAME="ecommercestoragexavier"
STORAGEACCOUNTNAME="ecommerceappxavier"

do_login()
{
    echo "Start Login"
    subscriptionId="$(az account list --query "[?isDefault].id" -o tsv)"
    if [ $subscriptionId != $SUBSCRIPTION ]; then
        az login --tenant $TENANT
        az account set --subscription $SUBSCRIPTION
    fi
    echo "End Login"
}

do_resource_group()
{
    echo "Checking Resource Groups"
    if [ $(az group exists --name $RESOURCEGROUP) = false ]; then
        az group create --name $RESOURCEGROUP --location $LOCATION
    fi
    echo "End Resource Group"
}

do_function_app()
{
    echo "Start Function App"
    az deployment group create \
    --name CheckoutFunctionApp \
    --resource-group $RESOURCEGROUP \
    --template-file azuredeploy.json \
    --parameters azuredeploy.parameters.json \
    --verbose
    echo "End function App"
}

main()
{
    do_login
    do_resource_group
    do_function_app
}

# Start
main
# End