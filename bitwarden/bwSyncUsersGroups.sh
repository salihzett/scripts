#!/bin/bash
export BITWARDENCLI_CONNECTOR_PLAINTEXT_SECRETS=true
/usr/local/bin/bwdc clear-cache
/usr/local/bin/bwdc sync
