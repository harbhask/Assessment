Author:
* Harshith Bhaskar

Date:    11.05.2020

#The folders and their functionality is mentioned below


###3 Tier Architecture
	This folder contains the Terraform codes for the 3 tier architecture. We have 2 sub folders named as modules and root-modules.
	1. Modules - Contains the source for the modules that are called in the Root-Modules folder
	2. Root-Modules - Contains two subfolders Wave_01_landing_zone and Wave_02_compute. As we are first deploying the Landing_Zone and then the Compute
	Note:
		1. Provider block doesnot contain any secrets as we are assuming that it will be deployed using Azure DevOps and Service connection can be used
		2. We have not written the code for Key Vault ,Key Vault Secrets and Key Vault Access Policy. These are manually created and the are being referenced in terraform using data block




###Azure Meta Data
	This folder contains the powershell code for extracting the metadata of an Azure Virtual Machine
	Note:
		1. A parameter by Name $KeyRequired is mandatory and value needs to be passed.
		2. For getting the full metadata, the value of $KeyRequired should be "all"
		3. For getting the value of a particular key , the value of $KeyRequired should be "key1/key2".
			Ex: "compute/region" ,"compute","network/interface/macaddress"

###Nested Object
	This folder	contains the powershell code which creates a function for getting the value of nested objects
	Note:
		1.The name of the function is "Get-NestedObjectValue" and 2 arguments needs to be passed.The arguments are $nestedobject & $keys.
		2.For getting the value of a particular key, the value of $nestedobject can be any nested Json Object and $keys should be "key1/key2"
			Ex: $nestedobject = '{"a":{"b":{"c":"d"}}}', $keys = "a/b"

###Output
	This folder	contains a word document, which has the results of all the scenarios with screenshot
		