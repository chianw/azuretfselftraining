# ReadMe

This project reads an existing resource group "myabcdresourcegroup" which does not have tags. Then you have to import it into Terraform state using 

    terraform import "azurerm_resource_group.myresourcegroup" "/subscriptions/39da38bd-3466-40fd-ad8f-f21417a17841/resourceGroups/myabcdresourcegroup" 

Finally do "terraform plan" and "terraform apply" which will add the missing tags into the resource group