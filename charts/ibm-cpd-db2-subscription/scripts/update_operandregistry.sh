#!/bin/sh

ZEN_OPERATORS_NAMESPACE="${ZEN_OPERATORS_NAMESPACE}"
COMMAN_SERVICES_NAMESPACE="${COMMAN_SERVICES_NAMESPACE}"

oc get operandregistry common-service -n ${COMMAN_SERVICES_NAMESPACE} -o json > /temp/operandregistry.json

jq '(.spec.operators[] | select(.name == "ibm-db2u-operator")).namespace = "${OPERATORS_NAMESPACE}"' /temp/operandregistry.json > /temp/operandregistry_new.json

oc apply -f /temp/operandregistry_new.json