default['dotnet']['download']['apt'] = "https://apt-mo.trafficmanager.net/repos/dotnet-release/"
default['dotnet']['download']['link'] = 'https://go.microsoft.com/fwlink/?LinkID='

default['dotnet']['download']['ubuntu']['14.04'] = "#{node['dotnet']['download']['apt']} trusty main"
default['dotnet']['download']['ubuntu']['16.04'] = "#{node['dotnet']['download']['apt']} xenial main"
default['dotnet']['download']['ubuntu']['16.10'] = "#{node['dotnet']['download']['apt']} yakety main"

default['dotnet']['download']['debian']['8'] = '835021'
default['dotnet']['download']['fedora']['23'] = '835023'
default['dotnet']['download']['fedora']['24'] = '835025'
default['dotnet']['download']['centos']['7']= '835019'
default['dotnet']['download']['oracle']['7']= '835019'
default['dotnet']['download']['opensuse']['13']= '835027'
default['dotnet']['download']['opensuse']['42']= '835029'
