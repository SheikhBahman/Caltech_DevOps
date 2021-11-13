# See https://docs.chef.io/workstation/config_rb/ for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "bahman"
client_key               "#{current_dir}/bahman.pem"
chef_server_url          "https://ip-172-31-6-141.us-west-2.compute.internal/organizations/caltech"
cookbook_path            ["#{current_dir}/../cookbooks"]
