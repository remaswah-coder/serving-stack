# w2d5-lab-starter

This repository contains the completed implementation and verification artifacts for the W2D5 lab container serving stack.

## 🐳 Container Deployment Status

The service runs inside a Docker container utilizing a specialized CPU-serving image and exposes port `8000`.

| Container Name | Image | Port Mapping | Status |
| :--- | :--- | :--- | :--- |
| `w2d5-lab-starter-serving-1` | `remaSwahas/aidc-serving:cpu-v1` | `0.0.0.0:8000->8000/tcp` | **Up & Healthy** ✅ |

---

<img width="2524" height="588" alt="Screenshot 2026-08-27 173640" src="https://github.com/user-attachments/assets/c988c4c4-72aa-43ac-9b6f-764cf8c18324" />
Manual verification was successfully performed using `curl` against the local serving container endpoints, yielding the expected HTTP status codes.

| Test Case | Method & Endpoint | Headers | Expected Code | Actual Result | Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Health Check** | `GET /health` | None | `200` | **200** | **PASS** ✅ |
| **Unauthorized Request** | `POST /v1/chat/completions` | Content-Type: application/json | `401` | **401** | **PASS** ✅ |
| **Authorized Request** | `POST /v1/chat/completions` | Content-Type & Bearer Token | `200` | **200** | **GREEN CHECK: PASS** 🎉 |

---

<img width="788" height="72" alt="Screenshot 2026-08-27 174348" src="https://github.com/user-attachments/assets/fd7106b8-d860-40ff-8a8e-8706aa407366" />

To run the checks locally:

1. **Check container status:**
   ```powershell
   docker compose ps

   Verify endpoints using curl:
2. **Verify endpoints using curl:**

```powershell
# Health Check
curl.exe -s -o /dev/null -w "%{http_code}\n" http://localhost:8000/health

# Authorized Chat Completion Test
curl.exe -s -o /dev/null -w "%{http_code}\n" -X POST http://localhost:8000/v1/chat/completions -H "Content-Type: application/json" -H "Authorization: Bearer secret123" -d "@payload.json"
