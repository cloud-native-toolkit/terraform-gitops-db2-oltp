#!/bin/sh

ZEN_OPERATORS_NAMESPACE="${ZEN_OPERATORS_NAMESPACE}"
COMMON_SERVICES_NAMESPACE="${COMMON_SERVICES_NAMESPACE}"
SOURCE_NAME="ibm-operator-catalog"

oc get operandregistry common-service -n ${COMMON_SERVICES_NAMESPACE} -o json > /temp/operandregistry.json

jq --arg ZEN_OPERATORS_NAMESPACE $ZEN_OPERATORS_NAMESPACE '(.spec.operators[] | select(.name == "ibm-db2u-operator")).namespace |= $ZEN_OPERATORS_NAMESPACE' /temp/operandregistry.json > /temp/operandregistry_new.json

jq --arg SOURCE_NAME $SOURCE_NAME '(.spec.operators[] | select(.name == "ibm-db2u-operator")).sourceName |= $SOURCE_NAME' /temp/operandregistry_new.json > /temp/operandregistry_new1.json

oc apply -f /temp/operandregistry_new1.json