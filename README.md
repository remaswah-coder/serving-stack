# W2D4: GPU Serving and Verification Lab

This repository contains the complete implementation and verification evidence for the W2D4 GPU Serving lab.

## 🚀 Lab Overview & Objectives

* **Environment Setup**: Configured and tested a containerized serving stack using Docker.
* **GPU Inference Verification**: Successfully built and executed the GPU-enabled container (`Dockerfile.gpu`).
* **Evidence Generation**: Produced and verified the serving configuration through `gpu_evidence.json`.
* **Passing Criteria**: Achieved a confirmed `GREEN CHECK: PASS` status via the verification scripts (`verify.sh` and `verify.py`).

---

## 📊 Performance Report (W2D4)

| Environment | Hardware | Device Detected | Speed (Tokens/s) |
| :--- | :--- | :--- | :--- |
| Local (Laptop) | CPU | `cpu` | 3-5 |
| Google Colab | Tesla T4 GPU | `cuda` | 32.1 |

---

<img width="1950" height="340" alt="Screenshot 2026-08-26 201222" src="https://github.com/user-attachments/assets/36913c1d-ada7-4064-ad15-c9ceb46b2c11" />


### 1. Container Build & Run
* Built the GPU Docker image (`remaswah/aidc-serving:gpu-v1`) and initiated local execution.
* Checked container logs confirming CUDA version 12.4.1 initialization and environment readiness.

### 2. Health Check & Validation
* Verified server responsiveness and endpoints locally using `curl` (`/health` returning status ok).
* Executed the automated verification script (`./verify.sh`), which successfully validated all deployment checks:
  * **Part 1**: GPU image resolved.
  * **Part 2**: `/health` 200 on CPU fallback.
  * **Part 3**: Colab evidence shows `cuda: true`.
  * **Result**: `GREEN CHECK: PASS`.

---

## 📁 Repository Structure

* **`app/`**: Contains application logic, schemas, and endpoints.
* **`Dockerfile.gpu`**: The GPU-optimized container configuration.
* **`gpu_evidence.json`**: The evidence configuration file for verification.
* **`verify.sh / verify.py`**: Automated lab testing and validation scripts.
