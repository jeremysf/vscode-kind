#!/bin/bash

helm upgrade example ./chart --install -f ./chart/values.yaml
