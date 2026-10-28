# Notes
## Backend file && Providers file 
- i created a resource group named tfstate8365RG, a storage account named tfstate8365sa, a container tfstatefiles
- I got error " Permission denied " when running ~/.profile
- I forgot the dot and space so I added them ` . ~/.profile` to load it 
- Error after running my first `terraform init` 
- the reason is that in the backend file i wrote groupe instaed of group
## Module 01 
### rgroup-8365
- I create one resource group 8365-RG that holds all my project resources
- there is 3 files vairables for inputs, main for building and outputs for the returns
- my inputs are rg_name, location, and tags
- I built azurerm resource group using my inputs 
- it returns rg_name 
#### Errors:
  - after terrafrom init I got error ` Unreadable module directory`
  - By mistake, I nested the folder as modules/modules/rgroup-8365
  - I moved it up and delete the sub folder module 
