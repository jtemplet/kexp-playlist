# KEXP Playlist

This script makes it easier to get the KEXP playlist and print it in a more readable form


### Installation

```sh
$ gem install kexp-playlist
```

### Usage
```sh
$ kexp-playlist -s "2023-05-03" -t
```
This will print all the songs played on May 3rd, 2023 in sequential order

### Command Line Arguments

| Flag      | Description | Required? | Parameter? |
| ----------- | ----------- | ----------- | ----------- |
| -s      | Start time | Yes | Yes, in a Date format, e.g. '2023-05-01 |
| -t   | Display timestamp?    | No | No |


### License
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)  