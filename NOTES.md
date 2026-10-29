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
## Module 02 For Networking
### network-8365
- I create one virtual network 8365-VNET and one subnet 8365-SUBNET in my 8365-RG
- For my NSG there is 4 inbound rule: 22 (SSH), 3389 (RDP), 5985 (WINRM) and 80 (HTTP), I used priority using this numbers: 100, 110, 120, 130
- Now i guess my terraform plan will give me 5 resources to add : RG, VNET, subnet, NSG, association
## Module 03 For Common Services
### common-8365
- I created 3 things in 8365-RG : 1 log form monitoring, 1 recovery service vault, and one storage account different from the backend 
- I got an error tha recovery services vault name must start with a letter
- Fix: renamed 8365-vault to rsv-8365
## Module 04 For Linux VMs
### vmlinux-8365
- 3 linux VMs, each in different availabilty zone, using `for_each`. 
- each VM need: Public IP, unique DNS label, network card (NIC), boot diagnostics, 2 extensions , provisioner
- Canada central only ofred sizes that are not compatible with CentOs/windows x86
- I changed project region to East US (F1ads_v7 worked there in earlier labs ) so lets see
- I left my backend storage in canada central 
