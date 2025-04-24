#!/bin/bash

[[ "$EUID" -ne 0 ]] && { echo "Must be run as root"; exit 1; }

script_dir="$(dirname "$(realpath "$0")")"
service_dir="$script_dir/../services"
echo "Service directory: $service_dir"

for loc_file in "$service_dir"/*.loc; do
	service_name=$(basename "$loc_file" .loc)
	service_file="$service_dir/$service_name"
	if [[ -f "$service_file" ]]; then
		target_location=$(head -n 1 "$loc_file")
		echo "Target location: $target_location"
		if systemctl is-enabled --quiet "$service_name"; then
			sudo systemctl disable "$service_name"
		else
			echo "$service_name not running"
		fi
		ln -sf "$service_file" "$target_location"
		sudo systemctl enable "$service_name"
		sudo systemctl restart "$service_name"
		echo "Service $filename linked to $target_location, enabled, and restarted."
	else
		echo "No corresponding .service file for $loc_file"
	fi
done

sudo systemctl daemon-reload

