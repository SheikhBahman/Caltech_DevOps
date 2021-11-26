ip = '172.17.0.1/24' 
mask = netmask(ip) # here we use the library method 
Chef::Log.info("Netmask of #{ip}: #{mask}")

