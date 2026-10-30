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
- I will use stabdard F1ads_v7
- VM worked, I got error that domain_name_label must start with a letter so i used "vm-${each.key}" so DNS label is vm-8365-u-vm1
- i added 2 externsions per vm and remote-exec provisionner ( terraform data, for each)
- Plan is now 26 to add
- Error again : Azure refused to create Linux VMs. the message said `VM size cannot boot with the OS image`
- I guess the size dont match with my OS cause it is an old one 
- Lets change it to `Standard_D2as_v4` as it has 1,2,3 zones and restrictions None and also 10 vCPUs of quota.... lets see
- Error: ExtensionNotFoundForCPUArchitecture for both NetworkWatcherAgentLinux
and AzureMonitorLinuxAgent. Means version 1.0 is not found in azure 
- the latest versions fails on Centos 8.2... I think i need to change the image 
- lets try Centos 7.9 with Extensions: Network Watcher 1.4 ( as it worked before), Azure Monitor 1.0, both auto upgrade true
- Azure monitor agent 1.45 also rejected Centos 7 (`unsuported OS)
- Since ubuntu worked in my labs i guess i will try ubuntu latest version (22.04 Gen2 (Canonical:0001-com-ubuntu-server-jammy:22_04-lts-gen2))
- `worked` so what worked together is : Image Ubuntu 22.04 Gen2 (Canonical) with network watcher 1.4 with auto upgrade true, azure monitor 1.0 with auto upgrade true, size Standard D2as_v4 and in eastus
## Module 05 for Windows VM
### vmwindows-8365
- I used count, availability set, winrm_listener Http same as lab 04
- used windows Server 2022 Gen2 (2022-datacenter-g2), D2as_v4, no zone (availability set instaed)
- used password as variable same as lab04
- supposed to get 31 to be added ( vm, availability set, ip, nic, extension) in terraform plan
- terraform apply worked with 31 resources succeded, then destroyed