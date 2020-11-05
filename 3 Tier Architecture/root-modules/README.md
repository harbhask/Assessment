#These are the root modules and are deployed in two waves


###Wave_01_landing_zone
	This root module deploys the landing zone resources. For this scenario it is deploying the below resources
		1. Resource Group
		2. Vnet and Subnets
		Note :Resources like Vnet Peering, Keyvault, Vng, S2S Connection are excluded.


###Wave_02_compute 
	This root module deploys the computing resources. For this scenario it is deploying the below resources
		1. Windows Virtual Machines(1DB & 1Application)
		2. Linux Virtual Machines(1Web)
		Note: We are assuming that keyvault is already present and secrets are created