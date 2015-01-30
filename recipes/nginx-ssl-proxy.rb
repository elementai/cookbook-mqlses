#
# Cookbook Name:: cookbook-mqlses
# Recipe:: nginx-ssl-proxy
#
# Copyright 2015, Twiket Ltd
#
n = node['mqlses']

include_recipe 'nginx'

service 'nginx' do
  action :nothing
end
cookbook_file '/etc/nginx/conf.d/nginx-ssl-proxy.htpasswd' do
  source 'nginx-ssl-proxy.htpasswd'
end

template '/etc/nginx/sites-available/nginx-ssl-proxy' do
  source 'nginx-ssl-proxy.erb'
  variables({
              :ssl_key => n['nginx-ssl-proxy']['ssl_key'],
              :ssl_cert => n['nginx-ssl-proxy']['ssl_cert']
            })
end


nginx_site 'nginx-ssl-proxy' do
  enable true
end

nginx_site 'default' do
  enable false
end