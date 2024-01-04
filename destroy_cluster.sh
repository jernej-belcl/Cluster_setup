#!/bin/bash

yes "yes" | op run --env-file=.env terraform destroy
