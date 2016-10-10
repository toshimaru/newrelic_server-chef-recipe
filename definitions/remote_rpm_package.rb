# Install rpm package via http like rpm -U http://....
#
# HOW TO USE
#
#     remote_rpm_package "#{name}" do
#       source "#{url}"
#     end
#
# OPTIONS
#
# Other options are same with `rpm_package` resource.
# See https://docs.chef.io/resource_rpm_package.html
#
# SOURCE
# See https://gist.github.com/sonots/c538cb368b3c2b366632

define :remote_rpm_package do
  name   = params[:name]
  _action = params[:action] || :install
  url    = params[:source]
  rpm_file = File.basename(url)
  rpm_name = File.basename(url, ".rpm")
  rpm_package_params = params.dup.tap do |params|
    params.delete(:name)
    params.delete(:source)
    params.delete(:action)
  end

  remote_file name do
    path "#{Chef::Config[:file_cache_path]}/#{rpm_file}"
    source url
    action :create
    not_if "rpm -q #{rpm_name}"
    notifies _action, "rpm_package[#{name}]", :immediately
  end

  rpm_package name do
    source "#{Chef::Config[:file_cache_path]}/#{rpm_file}"
    only_if "test -f #{Chef::Config[:file_cache_path]}/#{rpm_file}"
    action :nothing
    rpm_package_params.each {|key, val| send(key, val) }
  end

  file name do
    path "#{Chef::Config[:file_cache_path]}/#{rpm_file}"
    action :delete
  end
end
