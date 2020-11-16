#!/usr/bin/env python3

import datetime
import urllib.request
import sys
from urllib.error import URLError
from urllib.error import HTTPError

BLACKLIST_FILE = '/tmp/blacklist.conf.tmp'
CUTSOM_BLACKLIST_FILE = '/etc/unbound/blacklist.txt'
CUTSOM_WHITELIST_FILE = '/etc/unbound/whitelist.txt'
FIREBOG_URL = 'https://v.firebog.net/hosts/lists.php?type=tick'


def read_file(file_name):
    list_from_file = []
    with open(file_name) as file:
        lines = file.readlines()
        for domain in lines:
            if not domain.startswith('#'):
                list_from_file.append(domain.rstrip('\n'))
    return list_from_file

try:
    print('Retriving blacklists from \'{}\''.format(FIREBOG_URL))
    with urllib.request.urlopen(FIREBOG_URL) as response:
        blacklists = response.read().decode('utf-8').splitlines()
except HTTPError as error:
    print('An error occured while trying to access \'' + FIREBOG_URL + '\':')
    print(error)
    sys.exit()
except URLError as error:
    print('An error occured while trying to access \'' + FIREBOG_URL + '\':')
    print(error)
    sys.exit()

blacklist = []

for blacklists_entry in blacklists:
    blacklist_url = blacklists_entry.rstrip('\n')
    try:
        print('Processing \'{}\''.format(blacklist_url))
        with urllib.request.urlopen(blacklist_url) as response:
            response_list = response.read().decode('utf-8').splitlines()
            response_list_wo_empties = [str for str in response_list if str != '']
            for line in response_list_wo_empties:
                raw = line.rstrip('\n')
                if not raw.startswith('#'):
                    if '\t' in raw:
                        for item in raw.split():
                            if item != ('0.0.0.0', '127.0.0.1', 'localhost'):
                                blacklist.append(item)
                    elif ' ' in raw:
                        if '#' in raw:
                            blacklist.append(raw.split(' #')[0])
                        else:
                            if '.' in raw:
                                for item in raw.split():
                                    if item != ('0.0.0.0', '127.0.0.1', 'localhost'):
                                        blacklist.append(item)
                    else:
                        blacklist.append(raw)
    except HTTPError as error:
        print('An error occured while trying to access \'' + blacklist_url + '\':')
        print(error)
    except URLError as error:
        print('An error occured while trying to access \'' + blacklist_url + '\':')
        print(error)


blacklist.extend(read_file(CUTSOM_BLACKLIST_FILE))
blacklist.sort()
blacklist_list = set(blacklist)

for whitelist_domain in read_file(CUTSOM_WHITELIST_FILE):
    if whitelist_domain in blacklist_list:
        print('\'{}\' in blacklist but also in whitelist. Removing from blacklist'.format(whitelist_domain))
        blacklist_list.remove(whitelist_domain)


print('Found {} URLs to block'.format(len(blacklist_list)))
print('Wirting to \'{}\''.format(BLACKLIST_FILE))

blacklist_conf = open(BLACKLIST_FILE, 'w')
blacklist_conf.write('# generated {}\n'.format(datetime.datetime.now(tz=datetime.timezone.utc)))
blacklist_conf.write('# domains in list: {}\n'.format(len(blacklist_list)))
blacklist_conf.write('server:\n')

for item in blacklist_list:
    blacklist_conf.write('  local-zone: "{}." redirect\n'.format(item))
    blacklist_conf.write('  local-data: "{}. A 0.0.0.0"\n'.format(item))
    blacklist_conf.write('  local-data: "{}. AAAA ::"\n'.format(item))
