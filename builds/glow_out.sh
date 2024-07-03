#!/bin/sh
echo -ne '\033c\033]0;mini_jam_160_platformer\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/glow_out.x86_64" "$@"
