# 🌐 mateo cordone — Personal Portfolio

This is my personal portfolio website, built as part of my learning journey in AWS, Terraform, and DevOps practices — while also serving as my public online profile.

## 🚀 Overview

The website is a **static site** hosted on **Amazon S3**, delivered globally through **CloudFront** with **OAC** (Origin Access Control), and secured via **HTTPS** using **AWS Certificate Manager** and **Route 53** for DNS.  
The infrastructure is fully managed using **Terraform**, and deployments are automated using **GitHub Actions**, including cache invalidation for CloudFront.

Although the frontend is based on an open-source HTML template, I extensively customized the CSS and JavaScript to better reflect my style and preferences.

---

## 🧰 Tech Stack

### Infrastructure
- **Terraform** — Infrastructure as Code
- **AWS S3** — Static site hosting
- **AWS CloudFront + OAC** — CDN with secure origin access
- **AWS ACM** — SSL/TLS certificate for HTTPS
- **AWS Route 53** — DNS management
- **GitHub Actions** — CI/CD and cache invalidation

### Frontend
- **HTML / CSS / JavaScript** — Customized static template

---

## 📁 Project Structure

```bash
.
├── infra            # Terraform modules and configurations
├── web              # Frontend source files (HTML, CSS, JS, images)
└── .github
    └── workflows    # GitHub Actions for CI/CD
```

## 📦 Deployment

Deployment is automated through GitHub Actions. On every push to the main branch:
1.	The static files in /web are synced to the S3 bucket.
2.	A CloudFront cache invalidation is triggered.
3.	HTTPS is maintained via ACM certificates validated through Route 53.

## 🌍 Live Site
You can visit the portfolio here: https://www.mateocordone.com.ar/ or https://mateocordone.com.ar/



## 📌 Notes
```
•	This project serves both as a learning experience and as my personal web presence.

•	More improvements and optimizations will be added as I grow in my cloud and DevOps journey.
```

Feel free to explore the code or reach out for collaboration!