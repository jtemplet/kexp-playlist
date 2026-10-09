# KEXP Playlist

This script makes it easier to get the KEXP playlist and print it in a more readable form


### Installation

```sh
$ gem install kexp-playlist --user-install
```

### Usage
```sh
$ kexp-playlist -s "2023-05-03" -t
```
This will print all the songs played on May 3rd, 2023 in sequential order

All dates and times are Pacific time (KEXP's time zone). Timestamps are labeled PDT or PST to match the date.

```sh
$ kexp-playlist -s "2023-05-03" -e "2023-05-05"
```
This will print all the songs played from May 3rd to May 5th, 2023. Without `-e`, the end is 24 hours after the start.

### Command Line Arguments

| Flag      | Description | Required? | Parameter? |
| ----------- | ----------- | ----------- | ----------- |
| -s      | Start date | Yes | Yes, in a Date format, e.g. '2023-05-01' |
| -e      | End date | No | Yes, in a Date format; defaults to 24 hours after the start |
| -t   | Display timestamp?    | No | No |


### License
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)  