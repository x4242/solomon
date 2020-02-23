#!/bin/sh
#
# ----------------------------------------
# Description
# ----------------------------------------
# Download filter lists from firebog.net and create DNS blacklist in unbound
# format for IPv4 and v6:
#   local-zone: "<BLOCKED_DOMAIN>" redirect
#   local-data: "<BLOCKED_DOMAIN>. A 0.0.0.0"
#   local-data: "<BLOCKED_DOMAIN>. AAAA ::"
#
# Aferwards the generated file (path/filename can be set via $BLACKLIST_FILE)
# must be included in unbound.conf (include: "/path/to/file").
#
# Instead of returning NXDOMAIN, returning 0.0.0.0 or :: (unspecified
# address, see RFC 3513 -> https://tools.ietf.org/html/rfc3513#section-2.5.2)
# will result in clients querying less often compared to NXDOMAIN (see Pi-hole
# documentation -> # https://docs.pi-hole.net/ftldns/blockingmode/).
#
# ----------------------------------------
# License
# ----------------------------------------
# Copyright (C) 2020 0x4242
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful,but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with
# this program.  If not, see <https://www.gnu.org/licenses/>.
#
# ----------------------------------------
# Social
# ----------------------------------------
# Web: http://0x4242.net
# Twitter: @0x4242 <https://twitter.com/0x4242>
# GitHub: x4242 <https://github.com/x4242>
#
# ----------------------------------------
# Change History
# ----------------------------------------
# lastmod: 2020-02-21T20:04:44+01:00
# changelog:
#  - 2020-02-21: changed license to GPLv3
#  - 2020-01-27: change metadata/header comment block
#  - 2020-01-25:
#    - fix stray <CR>s in output from inputs with <CR><LF>
#    - printf output to give user feedback
#    - adding of manual list entries from txt file to blacklist
#    - count domains and give info in blacklist file comment
#  - 2020-01-24: created

##########################################
# Blocking Lists URL
# ----------------------------------------
# see https://firebog.net/ for details of the lists:
#   - Lists bulleted with a tick are least likely to interfere with browsing
#   - Lists bulleted with a cross block multiple useful sites
#     (e.g: Pi-hole updates, Amazon, Netflix)
# URLs of diffrent lists can be found at https://v.firebog.net/hosts/lists.php
##########################################
LISTS_URL="https://v.firebog.net/hosts/lists.php?type=tick"

##########################################
# Blacklist Output File
# ----------------------------------------
# if absolute path is not given current working directory is used
##########################################
BLACKLIST_FILE="blacklist.conf"

##########################################
# Custom Blacklist
# ----------------------------------------
# Own list of blacklist domains. Can contain comment lines starting with #. Each
# line should contain an URL only as the file is parsed line by line with no
# rule exept lines with leading # are ignored.
# Example:
#   # this is my blacklist
#   google.com
#   amazon.com
#   youtube.com
#
# I think you get it...
##########################################
MANUAL_LIST="my_blacklist.txt"

# Get URL list from LISTS_URL, exit if error.
# wget: timeout of 3s (-T 3) and 3 retries (-t 3)
if ! urls_of_lists="$(wget -T 3 -t 3 -qO - "$LISTS_URL")"; then
  printf "Error: Could not get input list from %s -> exiting\n" "$LISTS_URL" >&2
  exit 1
fi

# create named piped for storing all URLs
if ! mkfifo raw_urls_to_block; then
  printf "Error: Could not create named pipe -> exiting\n"
  exit 1
fi

# Download content of all URLs in $urls_of_lists and combine in named pipe
# raw_urls_to_block. Some lists seemd to randomly have <CR><LF> as line break
# there 'sed' before writing to pipe.
printf "%s" "$urls_of_lists" | while IFS= read -r list_url; do
  printf "Downloading list from %s ..." "$list_url"
  if ! list="$(wget -T 3 -t 3 -qO - "$list_url")"; then
    printf "\nError: Could not get input list from %s -> skipping\n" "$list_url" >&2
  else
    printf " done\n"
    echo "$list" | sed 's/\r//' >> raw_urls_to_block &
  fi
done

# read every line in MANUAL_LIST and add to raw_urls_to_block
if [ -f $MANUAL_LIST ] && [ -r $MANUAL_LIST ]; then
  while IFS= read -r manual_url; do
    echo "$manual_url" >> raw_urls_to_block &
  done < "$MANUAL_LIST"
fi

# Strip $raw_urls_to_block from all comment lines, IPs and double entries:
# - some list are formated "<IP> <URL>", e.g. "127.0.0.1 10xcdn.com"
# - other have the URL only
# - therefore pay attention to awk
# TODO: some lists in format <URL><IP>?????
printf "Formating blacklist and writing to %s... " "$BLACKLIST_FILE"
urls_to_block="$(grep -o '^[^#]*' < raw_urls_to_block | \
               awk '{if ($2 == "") print $1; else print $2}' | \
               uniq | \
               sort)"
rm raw_urls_to_block

# Check if BLACKLIST_FILE can be written. If so, empty file (if exists) and
# insert create date/time.
if [ ! -f $BLACKLIST_FILE ] || \
   [ -w $BLACKLIST_FILE ] || \
   [ -w "$(dirname "$BLACKLIST_FILE")" ]; then
  {
    printf "# generated %s\n" "$(date -u)"
    printf "# domains in list: %s\n" "$(echo "$urls_to_block" | wc -l)"
  } > $BLACKLIST_FILE
else
  printf "Error: Cannot write %s -> exiting\n" "$BLACKLIST_FILE" >&2
  exit 1
fi

# write to BLACKLIST_FILE in unbound.conf format (IPv4 and v6)
printf "%s" "$urls_to_block" | while IFS= read -r url_to_block; do
  {
    printf "local-zone: \"%s\" redirect\n" "$url_to_block"
    printf "local-data: \"%s. A 0.0.0.0\"\n" "$url_to_block"
    printf "local-data: \"%s. AAAA ::\"\n" "$url_to_block"
  } >> $BLACKLIST_FILE
done

printf "Done.\n"

exit 0
