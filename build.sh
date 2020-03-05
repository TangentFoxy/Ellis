#!/usr/bin/env bash

set -e # exit on any failure

moonc .
sudo docker build -t guard13007/ellis:testing .
sudo docker push guard13007/ellis:testing
