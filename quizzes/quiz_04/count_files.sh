#!/bin/bash

set -ueo pipefail


ls -l $1 | grep "^-" | wc -l
