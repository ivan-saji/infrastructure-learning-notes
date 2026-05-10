#!/bin/bash

# Variables
RESOURCE_GROUP="rg-tf-backend"
LOCATION="Central India"
STORAGE_ACCOUNT="tfbackendstatestorage01"
CONTAINER_NAME="tfstate"

# Create Resource Group
az group create \
  --name $RESOURCE_GROUP \
  --location "$LOCATION"

# Create Storage Account
az storage account create \
  --resource-group $RESOURCE_GROUP \
  --name $STORAGE_ACCOUNT \
  --sku Standard_LRS

# Get Storage Account Key
ACCOUNT_KEY=$(az storage account keys list \
  --resource-group $RESOURCE_GROUP \
  --account-name $STORAGE_ACCOUNT \
  --query '[0].value' -o tsv)

# Create Blob Container
az storage container create \
  --name $CONTAINER_NAME \
  --account-name $STORAGE_ACCOUNT \
  --account-key $ACCOUNT_KEY

echo "Terraform backend storage created successfully."