# W2D5 Lab - Containerized LLM Serving Stack

This repository contains the completed implementation and verification artifacts for the W2D5 lab container serving stack.

## 🐳 Container Deployment Status

The service runs inside a Docker container utilizing a specialized CPU-serving image and exposes port `8000`.

| Container Name | Image | Port Mapping | Status |
| :--- | :--- | :--- | :--- |
| `w2d5-lab-starter-serving-1` | `remaSwahas/aidc-serving:cpu-v1` | `0.0.0.0:8000->8000/tcp` | **Up & Healthy** ✅ |

### 📋 Container Status Verification
<img width="2532" height="242" alt="Screenshot 2026-08-27 181831" src="https://github.com/user-attachments/assets/86f8a8e7-68e1-4a68-9885-6e5b1809f404" />

---

## 🔍 API Endpoint Verification

Manual verification was successfully performed using `curl` against the local serving container endpoints, yielding the expected HTTP status codes.

| Test Case | Method & Endpoint | Headers | Expected Code | Actual Result | Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Health Check** | `GET /health` | None | `200` | **200** | **PASS** ✅ |
| **Unauthorized Request** | `POST /v1/chat/completions` | Content-Type: application/json | `401` | **401** | **PASS** ✅ |
| **Authorized Request** | `POST /v1/chat/completions` | Content-Type & Bearer Token | `200` | **200** | **GREEN CHECK: PASS** 🎉 |

### 🛠️ Curl Results & Verification Output
<img width="788" height="72" alt="Screenshot 2026-08-27 174348" src="https://github.com/user-attachments/assets/3c228c56-8665-4bd8-803b-2402f5916fdf" />

---
## 🚀 Quick Verification Commands

To run the checks locally:

1. **Check container status:**
   ```powershell
   docker compose ps
Verify endpoints using curl (PowerShell):

PowerShell
# Health Check
curl.exe -s -o /dev/null -w "%{http_code}\n" http://localhost:8000/health

# Authorized Chat Completion Test
curl.exe -s -o /dev/null -w "%{http_code}\n" -X POST http://localhost:8000/v1/chat/completions -H "Content-Type: application/json" -H "Authorization: Bearer secret123" -d "@payload.json"



🛠️ Tech Stack
Docker & Docker Compose for environment isolation and orchestration.

FastAPI / Uvicorn for high-performance API serving.

   
