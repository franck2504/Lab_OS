#!/usr/bin/env python3
import nmap
import json

nm = nmap.PortScanner()
nm.scan(hosts='192.168.56.0/24', arguments='-sn')

inventory = {
    'all': {
        'hosts': [],
        'vars': {}
    },
    'webservers': {
        'hosts': []
    }
}

for host in nm.all_hosts():
    inventory['all']['hosts'].append(host)
    if nm[host].hostname().startswith('debian'):
        inventory['webservers']['hosts'].append(host)

print(json.dumps(inventory))
