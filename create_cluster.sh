#!/bin/bash

#login
eval $(op signin)

yes "yes" | op run --env-file=.env terraform init # or just terraform init
yes "yes" | op run --env-file=.env terraform plan
yes "yes" | op run --env-file=.env terraform apply
