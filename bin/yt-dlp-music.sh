#!/usr/bin/env bash

yt-dlp -f bestaudio --extract-audio --audio-format mp3 --embed-metadata --embed-thumbnail -o "%(title)s - %(uploader)s.%(ext)s" "$1"
