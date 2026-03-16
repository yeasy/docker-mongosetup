#!/bin/bash
set -euo pipefail

mongo_host="${MONGO_HOST:-mongo}"
mongo_port="${MONGO_PORT:-27017}"
rs_name="${RS_NAME:-rs0}"
member_host="${MEMBER_HOST:-${mongo_host}:${mongo_port}}"

auth_args=()
if [ -n "${MONGO_USERNAME:-}" ] && [ -n "${MONGO_PASSWORD:-}" ]; then
  auth_args=(--username "${MONGO_USERNAME}" --password "${MONGO_PASSWORD}" --authenticationDatabase "${MONGO_AUTH_DB:-admin}")
fi

echo "Waiting for MongoDB at ${mongo_host}:${mongo_port}..."
until mongosh --quiet --host "${mongo_host}" --port "${mongo_port}" "${auth_args[@]}" --eval 'db.adminCommand({ping:1}).ok' | grep -q 1; do
  sleep 2
done

echo "Checking replica set status..."
init_result="$(mongosh --quiet --host "${mongo_host}" --port "${mongo_port}" "${auth_args[@]}" --eval "try{rs.status().ok}catch(e){e.codeName}")"
if [ "${init_result}" != "1" ]; then
  echo "Initializing replica set ${rs_name} with member ${member_host}"
  mongosh --quiet --host "${mongo_host}" --port "${mongo_port}" "${auth_args[@]}" --eval "rs.initiate({_id:'${rs_name}',members:[{_id:0,host:'${member_host}'}]})"
fi

echo "Waiting for node to become primary..."
until mongosh --quiet --host "${mongo_host}" --port "${mongo_port}" "${auth_args[@]}" --eval 'db.hello().isWritablePrimary ? 1 : 0' | grep -q 1; do
  sleep 2
done

echo "Replica set is ready."
if [ "$#" -eq 0 ]; then
  exit 0
fi

exec "$@"
