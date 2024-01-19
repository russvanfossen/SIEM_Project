#  SIEM Lab in Azure
* Create custom resource group <br>
![image](https://github.com/russvanfossen/SIEM_Project_new/assets/10410808/28f02023-c5d3-4679-952e-b9166ea5796a)

* Create VM
* Create a custom security group to allow any inbound traffic on any port <br>
![image](https://github.com/russvanfossen/SIEM_Project_new/assets/10410808/8d8c6119-2eef-493b-9792-666c1c07e7e2)

* Create Custom Log Analytics Workspace
* Connet LAW to VM
* Add Microsoft Sentinel to workspace
* Connect to VM
* Disable firewall <br>
![image](https://github.com/russvanfossen/SIEM_Project_new/assets/10410808/69b42f49-9951-4e0a-a7f7-a1f1971b40ba)

* Run custom log exporter script
 > stupid json didn't work right
 ![image](https://github.com/russvanfossen/SIEM_Project_new/assets/10410808/887c5566-36c0-4631-833f-ac5dc4ad0fa0)

>got the json to work but then for some reason it wouldn't import into a DCR based table
>swiched back to a NL delimited log and that table worked fine
> powershell script was working though, somone from Lithuania hit it while I was working on the table in the LAW <br>
![image](https://github.com/russvanfossen/SIEM_Project_new/assets/10410808/ada03265-6398-4964-8fb3-35c38755de2c)

