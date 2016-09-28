# Metrobus CLI

Command line utility to tell you how long it is until
the next bus on given route leaving from a given bus stop
going a given direction.  The bulk of the logic is contained in a gem which
can be found here: https://github.com/sbower/metrobus.

## Installation

### Ruby

First we need to install a working ruby development environment

    $ \curl -sSL https://get.rvm.io | bash -s stable --ruby

Then we can install the depedencies for this application

    $ bundle install

### Docker

Using docker can simply the process some by encapsulating the ruby build environment.  For information on how to install docker please visit: https://docs.docker.com/engine/installation/.

First, build the container:

```
docker build -t sbower/nextbus .
```

## Usage

### Ruby

Once you have a working ruby environment you can run the application as follows.

```
./nextbus.rb "METRO Blue Line" "Target Field Station Platform 1" "north"
```

This will return something like `The next bus from Target Field Station Platform 1 on METRO Blue Line traveling north departs in 2 Min`.  If the application can not find any departures it will provide an error with hints to what the issue could be.

### Docker

You can then run the application like so

```
docker run -i sbower/nextbus "METRO Blue Line" "Target Field Station Platform 1" "north"
```

NOTE:  You dont have to actuall build the docker image you can pull from docker hub, `docker pull sbower/nextbus`

## Improvements

* cache results, though this is hard with a cli tool
* add more in depth logging
* improve error handling
* DRY up the codebase
