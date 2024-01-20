## Prepare to work:
 * Install Azure CLI https://learn.microsoft.com/en-us/cli/azure/install-azure-cli
 * Install Terraform CLI https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli
 * Clone Azure AZ-204 labs https://github.com/MicrosoftLearning/AZ-204-DevelopingSolutionsforMicrosoftAzure
 * register account on Azure Portal https://portal.azure.com/
 
## 1. Authenticate using the Azure CLI
Terraform must authenticate to Azure to create infrastructure.
In your terminal, use the Azure CLI tool to setup your account permissions locally.
```shell
az login
```
Your browser will open and prompt you to enter your Azure login credentials. After successful authentication, 
your terminal will display your subscription information.
```shell
[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "0envbwi39-home-Tenant-Id",
    "id": "35akss-subscription-id",
    "isDefault": true,
    "managedByTenants": [],
    "name": "Subscription-Name",
    "state": "Enabled",
    "tenantId": "0envbwi39-TenantId",
    "user": {
      "name": "your-username@domain.com",
      "type": "user"
    }
  }
]
```
Find the `id` column for the subscription account you want to use.
Once you have chosen the account subscription ID, set the account with the Azure CLI.
```shell
az account set --subscription "<SUBSCRIPTION_ID>"
```

## 2. Create a Service Principal
Next, create a Service Principal. A Service Principal is an application within Azure Active Directory with the authentication tokens Terraform needs to perform actions on your behalf. Update the <SUBSCRIPTION_ID> with the subscription ID you specified in the previous step.
```shell
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"
```
Creating 'Contributor' role assignment under scope '/subscriptions/35akss-subscription-id'
The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
```shell
{
  "appId": "xxxxxx-xxx-xxxx-xxxx-xxxxxxxxxx",
  "displayName": "azure-cli-2022-xxxx",
  "password": "xxxxxx~xxxxxx~xxxxx",
  "tenant": "xxxxx-xxxx-xxxxx-xxxx-xxxxx"
}
```
## 3. Set your environment variables
Copy the file export-variables.sample.sh to export-variables.sh  and fill it with the data obtained in the previous step.
```shell
cp ./deploy/local/export-variables.sample.sh ./deploy/local/export-variables.sh
```
## 4. Deploy configuration
To prepare terraform plan run command
```shell
sh ./deploy/local/plan.sh
```
check which resources will be created or modified when applying the configuration.
Run the terraform apply command to apply your configuration.
```shell
sh ./deploy/local/apply.sh
```
Visit the Azure portal to ensure that all resources are created correctly.
## 5. Deploy code sample
Go to the Azure Labs AZ-204 folder (cloned in preparation stage).
Use following command to deploy samples of code.
```shell
az webapp deployment source config-zip --name web-app-back-dev-we-001 --resource-group rg-managed-platform-dev-we-001 --src ./Allfiles/Labs/01/Starter/API/api.zip

az webapp deployment source config-zip --name web-app-back-dev-we-001 --resource-group rg-managed-platform-dev-we-001 --src ./Allfiles/Labs/01/Starter/Web/web.zip
```
Go to link and check working application
https://web-app-front-dev-we-001.azurewebsites.net/

## <span style="color:red"> 6. Destroy resources
> Remember that simply stopping some resources (like the app service plan) is not enough! You will still be charged for them. Don't forget to delete resources after the lesson is over.

Destroy resources with command
```shell
sh ./deploy/local/destroy.sh
```
