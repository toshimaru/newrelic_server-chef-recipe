#
# Cookbook Name:: newrelic_server
# Recipe:: default
#

if node["newrelic"]["license_key"].empty?
  warning = <<-EOM
The `newrelic_server` recipe was included, but a licence key was not provided.
Please set `node["newrelic"]["license_key"]` to avoid this warning.
EOM

  log warning do
    level :warn
  end

  return
end

# Install newrelic_sysmond
remote_rpm_package "newrelic_sysmond" do
  source node["newrelic"]["server"]["rpm_package_url"]
end

package "newrelic-sysmond" do
  action :install
  retries 3
  retry_delay 5
end

# Set newrelic license_key
execute "Configure NewRelic Server" do
  command "nrsysmond-config --set license_key=#{node["newrelic"]["license_key"]}"
end

# Start newrelic_sysmond
service "newrelic-sysmond" do
  action :start
end
