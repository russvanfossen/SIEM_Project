##  SIEM Lab in Azure
- Create custom resource group
  * <img src="https://github.com/russvanfossen/SIEM_Project_new/assets/10410808/28f02023-c5d3-4679-952e-b9166ea5796a" width="25%"/>

* Create VM
* Create a custom security group to allow any inbound traffic on any port
  - <img src="https://github.com/russvanfossen/SIEM_Project_new/assets/10410808/8d8c6119-2eef-493b-9792-666c1c07e7e2" width="25%"/>

* Create Custom Log Analytics Workspace
* Connet LAW to VM
* Add Microsoft Sentinel to workspace
* Connect to VM
* Disable firewall
  - <img src="https://github.com/russvanfossen/SIEM_Project_new/assets/10410808/69b42f49-9951-4e0a-a7f7-a1f1971b40ba" width="25%"/>

* Run custom log exporter script
  [log_exporter](log_exporter.ps1)
 > 💢stupid json didn't work right
 ![image](https://github.com/russvanfossen/SIEM_Project_new/assets/10410808/887c5566-36c0-4631-833f-ac5dc4ad0fa0)

> ok, fixed it. 😌

* Set up some alerts to notify when there are new entries in the log
  - <img src="https://github.com/russvanfossen/SIEM_Project_new/assets/10410808/eeae1aab-e43f-47c2-8707-e5a5a6982630" width="25%"/>

* Alert Working
  - <img src="https://github.com/russvanfossen/SIEM_Project_new/assets/10410808/f5a91cb4-2a08-486b-b945-7ef1a1c28a33" width="25%"/>

* Set Up a Custom workbook in Microsoft Sentinel with some custom KQL

## Metrics
### A heatmap of where RDP attempts are coming from:
![image](https://github.com/russvanfossen/SIEM_Project_new/assets/10410808/78ebf32c-cb29-4f99-a1ae-882c2e181253)
```
FAILED_RDP_CL
| extend split_data = split(RawData, ",")
| extend Country = split(split_data[7], ":")[1]
| extend lat = split(split_data[5], ":")[1]
| extend lon = split(split_data[6], ":")[1]
| summarize count() by tostring(Country), tostring(lat), tostring(lon)
```
### A chart of popular usernames attempted:
![image](https://github.com/russvanfossen/SIEM_Project_new/assets/10410808/84d87d68-0fcf-4ab7-8724-22de67342c7c)
```
FAILED_RDP_CL
| extend split_data = split(RawData, ",")
| extend UserName = split(split_data[2], ":")[1]
| summarize count() by tostring(UserName)
```

