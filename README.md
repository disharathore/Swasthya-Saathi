# swasthya_saathi_final

Swasthya Saathi: Digital Health Records for Migrant Workers

Swasthya Saathi is an integrated digital health record management system designed to provide continuous, accessible, and secure healthcare for migrant workers in Kerala. The platform bridges the gap between workers, healthcare providers, and government health initiatives, aligning with UN Sustainable Development Goals.

## 🚀 The Problem

Migrant workers often face significant healthcare challenges due to language barriers, lack of medical history, and transient lifestyles. Critical health information is lost, leading to misdiagnosis and inefficient treatment. Our system ensures a worker's health history is always accessible, safe, and understandable.

## ✨ The Solution

We propose a four-part ecosystem built around a central, secure health database:

1.  **The Sahayak App (Volunteer's App):** An offline-first mobile app for authorized volunteers to register workers, capture demographic/medical data via Aadhaar QR scan, and instantly issue a physical **Swasthya Card**.
2.  **The Swasthya Card (Worker's ID):** A durable, physical ID card with a unique QR code. It's the worker's key to their health records, requiring no smartphone or technical skill from them.
3.  **The Doctor's Web Portal:** A secure, browser-based portal for doctors to scan a worker's QR code, get OTP-based consent, and instantly access their complete, translated medical history to provide safe and informed care.
4.  **The Public Health Dashboard:** An analytics platform for government officials to view anonymized, aggregated health data, identify disease hotspots, and formulate effective public health policies.

## 🛠️ Tech Stack

-   **Mobile App (Flutter):** For the Sahayak's registration app.
-   **Web Portal (React/TypeScript):** For the doctor's and government dashboards.
-   **Backend (Python/Flask):** For API services, data processing, and business logic.
-   **Database (MongoDB):** For storing health records and user data.
-   **AI/ML (OpenCV, MediaPipe):** *(Future scope for automated health assessments)*.

## ⚙️ Core Features

-   **Aadhaar QR Integration:** Fast and error-free data entry.
-   **Offline-First Capability:** The Sahayak App works reliably in low-connectivity areas using a local SQLite database for caching.
-   **On-the-Spot Card Printing:** Bluetooth printer integration to issue physical ID cards instantly.
-   **OTP-Based Consent:** Ensures patient privacy and control over their data.
-   **Real-time Analytics:** Anonymized data for public health monitoring.

## 📋 Project Status

This repository contains the source code for the Swasthya Saathi project. The current focus is on building the core functionality of the Sahayak's App and the Doctor's Web Portal.

---

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
