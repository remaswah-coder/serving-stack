#!/usr/bin/env bash
set -e

echo "[*] Starting verification script..."

# 1. Bring up stack with docker compose
echo "[*] Running docker compose up -d..."
docker compose up -d

# 2. Wait for container health status
echo "[*] Waiting for container to report healthy (timeout 180s)..."
RETRIES=36
while [ $RETRIES -gt 0 ]; do
    HEALTH=$(docker compose ps --format json | grep -o '"Health":"[^"]*"' | cut -d'"' -f4 || true)
    if [ "$HEALTH" = "healthy" ]; then
        echo "[+] Container is healthy!"
        break
    fi
    sleep 5
    RETRIES=$((RETRIES - 1))
done

if [ "$HEALTH" != "healthy" ]; then
    echo "GREEN CHECK: FAIL (Container failed to become healthy within timeout)"
    docker compose down
    exit 1
fi

# Load port and key from local .env if available
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi
PORT=${HOST_PORT:-8000}
KEY=${API_KEY:-"dummy-key-change-me"}

# 3. Test unauthenticated health endpoint
echo "[*] Testing /health endpoint..."
STATUS_HEALTH=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:${PORT}/health)
if [ "$STATUS_HEALTH" != "200" ]; then
    echo "GREEN CHECK: FAIL (/health returned HTTP $STATUS_HEALTH instead of 200)"
    docker compose down
    exit 1
fi

# 4. Test authenticated completion endpoint
echo "[*] Testing /v1/chat/completions endpoint with API key..."
STATUS_COMPLETION=$(curl -s -o /dev/null -w "%{http_code}" -H "Authorization: Bearer ${KEY}" \
  -H "Content-Type: application/json" \
  -d '{"model":"Qwen/Qwen2.5-0.5B-Instruct","messages":[{"role":"user","content":"Say hi."}],"max_tokens":16}' \
  http://localhost:${PORT}/v1/chat/completions)

if [ "$STATUS_COMPLETION" != "200" ]; then
    echo "GREEN CHECK: FAIL (/v1/chat/completions returned HTTP $STATUS_COMPLETION instead of 200)"
    docker compose down
    exit 1
fi

# 5. Tear down stack
echo "[*] Tearing down compose stack..."
docker compose down

echo "GREEN CHECK: PASS"
exit 0