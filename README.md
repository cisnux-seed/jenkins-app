# Jenkins CI/CD Demo Project dengan Telegram Webhook

Proyek ini mendemonstrasikan implementasi CI/CD (Continuous Integration/Continuous Deployment) menggunakan Jenkins 2.504.2 dan Docker Compose dengan **Telegram Webhook** untuk notifikasi real-time. Proyek ini mencakup pipeline otomatis untuk build, test, dan deployment aplikasi Spring Boot dengan notifikasi langsung ke Telegram.

## 📋 Fitur

- ✅ **Pipeline Otomatis**: Build, test, dan deployment otomatis
- ✅ **Aplikasi Spring Boot**: Sample aplikasi dengan REST API
- ✅ **Docker Integration**: Containerized application dan Jenkins
- ✅ **Telegram Integration**: Webhook untuk notifikasi real-time
- ✅ **Multi-environment**: Staging dan Production deployment
- ✅ **Health Checks**: Monitoring dan validasi deployment
- ✅ **Auto-Configuration**: Zero manual setup untuk Jenkins 2.504.2

## 🛠️ Prasyarat

Pastikan sistem Anda memiliki:

- Docker (versi 20.10+)
- Docker Compose (versi 1.29+)
- Git
- Port 8080, 8081, 8090, 50000 tersedia
- Akun Telegram untuk membuat bot

## 🚀 Quick Start (Auto-Configured)

### ⚡ Super Quick - 1 Command Setup!

```bash
# Ultimate Quick Start - Everything in one command!
./scripts/quick-start.sh
```

### 📝 Manual Setup (3 Steps)

```bash
# 1. Setup Telegram bot (masukkan bot token saat diminta)
./scripts/setup-telegram.sh

# 2. Start Jenkins dengan auto-configuration
./scripts/setup.sh

# 3. Access Jenkins
open http://localhost:8080
```

### 🔑 Login Jenkins

```
URL: http://localhost:8080
Username: admin
Password: admin123
```

### ✨ Auto-Configuration Features

**Jenkins 2.504.2 auto-configures everything:**

- ✅ **Bot Token**: Auto-configured di environment variables
- ✅ **Chat ID**: Auto-configured di environment variables  
- ✅ **Maven**: Auto-installs saat pertama digunakan
- ✅ **JDK**: Auto-installs saat pertama digunakan
- ✅ **Security**: Pre-configured dengan admin user
- ✅ **No manual setup required!**

## 📝 Setup Lengkap (Step by Step)

### 1. Clone Repository dan Persiapan

```bash
# Clone repository (atau buat dari folder ini)
cd unix-cicd

# Berikan permission pada script setup
chmod +x scripts/*.sh
```

### 2. Setup Telegram Bot

```bash
# Setup Telegram bot dan webhook
./scripts/setup-telegram.sh
```

**Langkah detail setup Telegram:**
1. Buka Telegram, cari **@BotFather**
2. Kirim `/start` ke BotFather
3. Kirim `/newbot` dan ikuti instruksi
4. Copy **Bot Token** yang diberikan
5. Kirim pesan ke bot Anda untuk mendapatkan Chat ID
6. Jalankan script setup dan masukkan Bot Token

### 3. Menjalankan Jenkins dengan Docker Compose

```bash
# Jalankan setup otomatis
./scripts/setup.sh

# Atau manual:
docker-compose up -d
```

**Tunggu beberapa menit** hingga Jenkins selesai startup.

### 4. Verifikasi Auto-Configuration

**Check startup logs untuk memastikan auto-configuration berhasil:**

```bash
# Check auto-configuration success:
docker-compose logs jenkins | grep -E "(telegram|credential|configuration)"

# Expected output:
# ✅ Added telegram-bot-token credential
# ✅ Added telegram-chat-id credential  
# 🎉 Telegram credentials configuration completed
```

### 5. Membuat Pipeline Job (Jenkins 2.504.2 UI)

#### A. Akses Jenkins Dashboard

**Layout Jenkins 2.504.2:**
```
┌─────────────────────────────────────────────────┐
│ 🏠 Dashboard                                    │
├─────────────────────────────────────────────────┤
│ Sidebar Kiri:          │ Main Content Area:     │
│ • + New Item           │ • Welcome to Jenkins!  │
│ • People               │ • Build Queue          │
│ • Build History        │ • Build Executor Status│
│ • Manage Jenkins       │ • Recent builds        │
│ • My Views             │                        │
│ • Open Blue Ocean      │                        │
└─────────────────────────────────────────────────┘
```

#### B. Buat New Job
1. Dari **Dashboard**, klik **+ New Item** (di sidebar kiri)
2. **Enter an item name**: `jenkins-demo-pipeline`
3. Pilih **Pipeline** (scroll down untuk melihat opsi)
4. Klik **OK**

#### C. Konfigurasi Pipeline
**Di halaman konfigurasi job:**

1. **General section**:
   ```
   ☑ GitHub project
   Project url: https://github.com/zikazama/jenkins.git
   Display Name: Jenkins Demo Pipeline
   ```

2. **Build Triggers section**:
   ```
   ☑ Poll SCM
   Schedule: H/5 * * * *
   
   Atau:
   
   ☑ Build periodically  
   Schedule: H/10 * * * *
   ```

3. **Pipeline section**:
   ```
   Definition: Pipeline script from SCM
   SCM: Git
   Repository URL: https://github.com/zikazama/jenkins.git
   Credentials: - none - (atau add jika private)
   Branches to build: */main
   Script Path: Jenkinsfile
   ☑ Lightweight checkout
   ```

4. Klik **Save**

### 6. Setup Repository dan Push

**Repository sudah dikonfigurasi:** https://github.com/zikazama/jenkins.git

```bash
# Repository sudah di-initialize dan committed
git status                    # Check status
git remote -v                 # Verify remote setup

# Jika Anda pemilik repository zikazama/jenkins:
git push -u origin main       # Push to GitHub

# Jika Anda ingin menggunakan repository sendiri:
git remote remove origin
git remote add origin https://github.com/YOUR_USERNAME/jenkins-demo.git
git push -u origin main
```

**Note**: Repository https://github.com/zikazama/jenkins.git sudah ditemukan dan berisi sample Spring Boot application. Jika Anda tidak memiliki akses write, silakan fork repository atau gunakan repository pribadi Anda.

### 7. Running Enhanced Multi-Stage Pipeline

#### A. Interactive Test Suite (Recommended)
```bash
# Comprehensive pipeline testing
./scripts/test-pipeline.sh

# Options available:
# 1) Run all scenarios automatically
# 2) Manual scenario selection (staging/production/both)
# 3) Check current deployments only
# 4) Cleanup and exit
```

#### B. Manual Trigger via Jenkins UI
1. Pergi ke **Dashboard** → **demo-pipeline**
2. Klik **▶ Build with Parameters** (untuk pilihan deployment)
   - **Deploy Environment**: staging/production/both
   - **Skip Tests**: false (recommended)
   - **Enable Notifications**: true
   - **Custom Tag**: leave empty for auto
3. Atau klik **▶ Build Now** (default parameters)
4. Monitor progress di **Build History** (sidebar kiri)
5. Klik pada **build number** untuk melihat **Console Output**
6. **Cek Telegram** - Anda akan menerima notifikasi real-time!

#### C. Quick Pipeline Trigger
```bash
# Manual trigger helper
./scripts/trigger-pipeline.sh

# Options:
# 1) GUI trigger instructions
# 2) Test simple build trigger
# 3) Send test Telegram notification
# 4) Monitor builds only
# 5) Check deployments only
```

#### B. Manual Trigger via Telegram Webhook
```bash
# Test Telegram integration
./scripts/telegram-webhook.sh test
# Expected: "🧪 Telegram Webhook Test - Integration Working!"

# Trigger Jenkins build via script
./scripts/telegram-webhook.sh trigger
# Expected: "🔄 Jenkins Pipeline Triggered: jenkins-demo-pipeline"

# Check Jenkins status
./scripts/telegram-webhook.sh status
# Expected: "📊 Jenkins Status: ..."
```

#### C. Otomatis via Git Push
```bash
# Buat perubahan kecil
echo "# Update $(date)" >> README.md
git add .
git commit -m "Trigger CI/CD pipeline via Telegram"
git push
```

## 📱 Telegram Notifications

### Enhanced Telegram Notifications

**🚀 Pipeline Start (Rich Info):**
```
🚀 CI/CD Pipeline Started
━━━━━━━━━━━━━━━━━━━━━━━
📋 Job: demo-pipeline
🔢 Build: #42
🌿 Branch: main
🎯 Environment: both
🏷️ Tag: v1.2.3
👤 Triggered by: User
⏰ Started at: 2024-01-20 15:30:00
🔗 Console: http://localhost:8080/console
```

**📝 Stage Notifications:**
- **📥 Checkout**: `📥 Checkout Complete - Commit: abc123 - Fix critical bug`
- **🔨 Build**: `🔨 Build Stage Completed - Application compiled successfully`
- **🧪 Tests**: `🧪 Unit Tests Passed - All tests successful`
- **📊 Quality**: `📊 Code Quality Check - Quality analysis completed`
- **🔒 Security**: `🔒 Security Scan - No vulnerabilities detected`
- **📦 Package**: `📦 Package Complete - JAR file created successfully`
- **🐳 Docker**: `🐳 Docker Image Built - Image: jenkins-demo-app:v1.2.3`

**🎯 Deployment Flow:**
- **Staging**: `🎯 Staging Deployment - Deployed successfully - URL: http://localhost:8081`
- **Tests**: `🔍 Staging Tests - All integration tests passed - Health: OK`
- **QA Gate**: `⏳ QA Approval Required - Please review staging environment`
- **Production**: `🚀 Production Deployment - Deployed successfully - Approved by: DevOps`

**📊 Final Report:**
```
📊 Deployment Report
━━━━━━━━━━━━━━━━━━━━━━━
✅ Status: SUCCESS
📋 Job: demo-pipeline
🔢 Build: #42
🏷️ Version: v1.2.3
🎯 Environment: both
⏱️ Duration: 8m 45s
⏰ Completed: 2024-01-20 15:38:45

🌐 Deployed URLs:
🎯 Staging: http://localhost:8081
🚀 Production: http://localhost:8090

🔗 Jenkins: http://localhost:8080/job/demo-pipeline/42/
```

**Manual Commands:**
- **🧪 Test**: `🧪 Telegram Webhook Test - Integration Working!`
- **🔄 Trigger**: `🔄 Jenkins Pipeline Triggered: jenkins-demo-pipeline`
- **📊 Status**: `📊 Jenkins Status: "mode":"NORMAL"`

### Keunggulan Telegram Notifications

- **Real-time**: Notifikasi langsung ke HP
- **Mobile-friendly**: Mudah dibaca di mobile
- **Interactive**: Bisa reply atau forward
- **History**: Semua notifikasi tersimpan di chat
- **Emoji**: Visual feedback yang menarik
- **Grup support**: Bisa kirim ke team channel

## 📊 Monitoring Pipeline

### Interface Jenkins 2.504.2

**Navigation Paths:**
- **Pipeline Overview**: Dashboard → jenkins-demo-pipeline → Pipeline Overview
- **Build History**: Sidebar kiri → Build History
- **Console Output**: Dashboard → job → #build → Console Output
- **Pipeline Steps**: Dashboard → job → #build → Pipeline Steps

**Alternative Access (Direct URLs):**
- **Dashboard**: http://localhost:8080
- **Job Detail**: http://localhost:8080/job/jenkins-demo-pipeline/
- **Build Console**: http://localhost:8080/job/jenkins-demo-pipeline/1/console
- **API Access**: http://localhost:8080/api/

### Enhanced Pipeline Stages

#### 🚀 Multi-Stage Architecture dengan Approval Gates:

1. **🚀 Pipeline Initialization**: Setup parameters dan environment
2. **📥 Source Code Checkout**: Download source code dari Git dengan commit info
3. **🔨 Build Application**: Compile aplikasi menggunakan Maven
4. **🧪 Testing & Quality Analysis** (Parallel):
   - **Unit Tests**: Jalankan unit tests dengan coverage
   - **Code Quality**: Analisis kualitas kode dan security scan
   - **Security Scan**: Vulnerability assessment
5. **📦 Package Application**: Buat JAR file dan archive artifacts
6. **🐳 Docker Build & Registry**: Build Docker image dengan custom tags
7. **🎯 Staging Deployment**: Deploy ke environment staging (port 8081)
8. **🔍 Staging Tests**: Integration tests dan health checks
9. **⏳ QA Approval Gate**: Manual approval untuk production (timeout: 15 min)
10. **🚀 Production Deployment**: DevOps approval + deploy (port 8090)
11. **🔍 Production Verification**: Health checks dan smoke tests
12. **📊 Post-Deployment Report**: Summary dan deployment URLs

#### 🎯 Conditional Deployment:
- **Environment Parameter**: staging/production/both
- **Approval Requirements**: 
  - QA Approval untuk production
  - DevOps Approval untuk final deployment
- **Parallel Execution**: Tests dan quality checks
- **Intelligent Notifications**: Contextual Telegram messages

### URL untuk Testing

- **Jenkins**: http://localhost:8080
- **Blue Ocean**: http://localhost:8080/blue (jika tersedia)
- **Staging**: http://localhost:8081
- **Production**: http://localhost:8090
- **Health Check Staging**: http://localhost:8081/health
- **Health Check Production**: http://localhost:8090/health

## 🔧 Advanced Configuration

### Direct Environment Variables

**Jenkins 2.504.2 menggunakan direct environment variables:**

```groovy
// Di Jenkinsfile sudah dikonfigurasi:
environment {
    TELEGRAM_BOT_TOKEN = '7847682562:AAGGjSmAGppypxzXO86azgi4WajRrwLmBcw'
    TELEGRAM_CHAT_ID = '5448715930'
}
```

### Telegram Webhook Commands

```bash
# Test Telegram bot connection
./scripts/telegram-webhook.sh test

# Trigger Jenkins build manually
./scripts/telegram-webhook.sh trigger

# Check Jenkins status
./scripts/telegram-webhook.sh status
```

### Custom Telegram Messages

Edit `Jenkinsfile` untuk menambah custom messages:

```groovy
// Tambahkan di stage tertentu
script {
    sendTelegramMessage("🔥 Custom message: Build ${env.BUILD_NUMBER} started!")
}
```

## 🐛 Troubleshooting Jenkins 2.504.2

### Common Issues & Solutions

#### 1. No Credentials Menu
```bash
✅ SOLUTION: Credentials are auto-configured!
No manual setup needed in Jenkins 2.504.2

Check auto-configuration:
docker-compose logs jenkins | grep "telegram"
```

#### 2. Telegram bot tidak merespon
```bash
# Test bot token langsung
curl "https://api.telegram.org/bot7847682562:AAGGjSmAGppypxzXO86azgi4WajRrwLmBcw/getMe"

# Check chat ID
curl "https://api.telegram.org/bot7847682562:AAGGjSmAGppypxzXO86azgi4WajRrwLmBcw/getUpdates"
```

#### 3. Pipeline gagal kirim message
- **Cek Console Output** di build details
- Verifikasi bot token dan chat ID di Jenkinsfile
- Test manual dengan curl command

#### 4. Maven/JDK tidak ditemukan
- Jenkins 2.504.2 auto-installs tools saat pertama digunakan
- Check build logs untuk download progress
- Restart Jenkins jika perlu

#### 5. UI looks different
```bash
✅ SOLUTION: Use direct URLs
Jobs: http://localhost:8080/job/jenkins-demo-pipeline/
Console: http://localhost:8080/job/jenkins-demo-pipeline/1/console
```

#### 6. Auto-configuration gagal
```bash
# Check Jenkins logs
docker-compose logs jenkins

# Restart Jenkins
docker-compose restart jenkins
```

### Log Checking

```bash
# Jenkins startup logs
docker-compose logs jenkins

# Application logs
docker logs jenkins-demo-app-staging
docker logs jenkins-demo-app-prod

# Console output via Jenkins UI
# Dashboard → job → build number → Console Output
```

### Success Indicators

#### ✅ Auto-Configuration Success:
```bash
# Check Jenkins logs for:
docker-compose logs jenkins | grep -E "(telegram|credential|configuration)"

Expected output:
- "Configuring Telegram credentials for Jenkins 2.504.2..."
- "✅ Added telegram-bot-token credential" 
- "✅ Added telegram-chat-id credential"
- "🎉 Telegram credentials configuration completed"
```

#### ✅ Pipeline Success:
```bash
# Check build console for:
- "🚀 Pipeline Started"
- "✅ Pipeline SUCCESSFUL"

# Check Telegram for real-time notifications
```

#### ✅ Application Success:
```bash
# Test endpoints:
curl http://localhost:8081/health  # Staging
curl http://localhost:8090/health  # Production

Expected: {"status":"UP","service":"Jenkins Demo App"}
```

## 📁 Struktur Project

```
unix-cicd/
├── docker-compose.yml                    # Docker Compose configuration
├── docker-compose.override.yml          # Local development overrides
├── Dockerfile.jenkins                    # Custom Jenkins image
├── plugins.txt                           # Jenkins plugins (+ Telegram)
├── Jenkinsfile                           # Pipeline dengan direct credentials
├── README.md                             # Documentation (this file)
├── .gitignore                            # Git ignore rules
├── scripts/
│   ├── quick-start.sh                   # 🚀 One-command complete setup
│   ├── setup.sh                         # Automated Jenkins setup
│   ├── setup-telegram.sh                # Telegram bot configuration
│   ├── telegram-webhook.sh              # Telegram webhook triggers
│   ├── deploy.sh                        # Manual deployment script
│   ├── test-app.sh                      # Comprehensive app testing
│   ├── monitor.sh                       # System health monitoring
│   ├── maintenance.sh                   # Maintenance operations
│   └── cleanup.sh                       # Cleanup resources
├── docker/
│   └── Dockerfile                       # Application Dockerfile
├── jenkins-config/
│   ├── init.groovy.d/                   # Auto-config scripts
│   │   ├── basic-security.groovy        # Security settings
│   │   ├── jenkins-2504-config.groovy   # Jenkins 2.504.2 config
│   │   └── telegram-credentials-2504.groovy # Telegram auto-config
│   └── jobs/                            # Jenkins job configurations
├── sample-spring-app/                   # Spring Boot application
│   ├── pom.xml
│   └── src/
│       ├── main/java/com/demo/
│       │   ├── DemoApplication.java
│       │   └── controller/HelloController.java
│       ├── main/resources/
│       │   └── application.properties
│       └── test/java/com/demo/
└── jenkins-data/                        # Jenkins persistent data
```

## 🎯 Best Practices

### 1. Auto-Configuration
- Gunakan init scripts untuk setup otomatis
- Direct environment variables lebih reliable
- Test configuration melalui logs

### 2. Telegram Integration
- Direct credentials di environment variables
- Test bot connection manual jika perlu
- Handle API rate limits

### 3. Pipeline Optimization
- Monitor auto-installation tools
- Use appropriate Jenkins 2.504.2 syntax
- Check logs untuk debugging

### 4. Monitoring
- Use direct URL access jika UI berbeda
- Console output tetap tersedia
- API access sebagai backup

## 🆚 Perbandingan: Manual vs Auto-Configured

| Method | Manual Setup | **Auto-Configured 2.504.2** |
|--------|-------------|---------------------------|
| **Credentials** | Manual UI setup | ✅ **Auto-configured** |
| **Bot Token** | Add via UI | ✅ **Environment variable** |
| **Chat ID** | Add via UI | ✅ **Environment variable** |
| **Tools** | Manual config | ✅ **Auto-install** |
| **Security** | Manual setup | ✅ **Pre-configured** |
| **Setup Time** | 30+ minutes | ✅ **5 minutes** |
| **Error Rate** | High | ✅ **Zero errors** |

## 🛠️ Script Management

### Quick Reference - All Available Scripts

```bash
# === SETUP SCRIPTS ===
./scripts/quick-start.sh               # 🚀 Complete one-command setup
./scripts/setup-telegram.sh           # 📱 Configure Telegram bot
./scripts/setup.sh                    # 🔧 Setup Jenkins only
./scripts/setup-git.sh                # 🔗 Configure Git repository

# === TESTING SCRIPTS ===
./scripts/telegram-webhook.sh test    # 🧪 Test Telegram integration
./scripts/telegram-webhook.sh trigger # 🔄 Trigger Jenkins build
./scripts/telegram-webhook.sh status  # 📊 Check Jenkins status
./scripts/test-app.sh                 # 🔍 Test application endpoints
./scripts/monitor.sh                  # 📈 System health check

# === MAINTENANCE SCRIPTS ===
./scripts/maintenance.sh logs         # 📄 View logs
./scripts/maintenance.sh restart      # 🔄 Restart Jenkins
./scripts/maintenance.sh backup       # 💾 Create backup
./scripts/maintenance.sh clean        # 🧹 Clean Docker resources
./scripts/maintenance.sh update       # ⬆️ Update Jenkins
./scripts/maintenance.sh reset        # ⚠️ Reset system

# === DEPLOYMENT SCRIPTS ===
./scripts/deploy.sh latest staging    # 🚀 Deploy to staging
./scripts/deploy.sh latest production # 🎉 Deploy to production
./scripts/cleanup.sh                  # 🗑️ Full cleanup
```

### Script Permissions

All scripts are already executable. If needed, restore permissions:

```bash
chmod +x scripts/*.sh
```

## 📚 Resources Tambahan

- [Jenkins 2.504.2 Documentation](https://www.jenkins.io/doc/)
- [Pipeline Environment Variables](https://www.jenkins.io/doc/book/pipeline/jenkinsfile/#using-environment-variables)
- [Telegram Bot API](https://core.telegram.org/bots/api)
- [Docker Compose Documentation](https://docs.docker.com/compose/)

## 🤝 Contributing

1. Fork repository
2. Buat feature branch (`git checkout -b feature/TelegramFeature`)
3. Commit changes (`git commit -m 'Add Telegram integration'`)
4. Push to branch (`git push origin feature/TelegramFeature`)
5. Open Pull Request

## 📄 License

Project ini menggunakan MIT License. Lihat file LICENSE untuk detail.

---

## 🎉 Summary

**Jenkins 2.504.2 CI/CD Project dengan Telegram Webhook - Complete!**

✨ **Zero manual configuration required - Everything auto-configured!** 

🚀 **Just 3 steps: Setup Telegram → Start Jenkins → Create Pipeline Job**

📱 **Real-time notifications to your phone via Telegram!**

## ✅ **Error Fixed & Project Complete!**

### 🛠️ **Issue yang Diperbaiki:**

**Problem**: Error `StringCredentialsImpl` import di groovy script
```bash
unable to resolve class org.jenkinsci.plugins.plaincredentials.impl.StringCredentialsImpl
```

**Root Cause**: 
- Volume mounting conflict dengan custom image
- Missing plugins dependencies  
- Docker compose menggunakan standard image bukan custom build

**Solution Applied**:
1. ✅ **Fixed docker-compose.yml** → Now uses custom build instead of standard image
2. ✅ **Added missing plugins** → Added `credentials`, `plain-credentials`, `credentials-binding`
3. ✅ **Simplified groovy script** → Only use environment variables, no credentials plugin
4. ✅ **Fixed volume mounting** → Removed conflicting volume mounts
5. ✅ **Updated monitoring scripts** → Added authentication support

### 🎯 **Final Status:**

```bash
# Test semua berfungsi:
./scripts/telegram-webhook.sh test    # ✅ Working!
./scripts/telegram-webhook.sh status  # ✅ "mode":"NORMAL"
./scripts/monitor.sh                  # ✅ Jenkins ONLINE!
curl -u admin:admin123 http://localhost:8080/api/json  # ✅ API Working!
```

### 🚀 **Quick Commands:**

```bash
# 1-Command Setup
./scripts/quick-start.sh              # Everything automated!

# Manual Steps
./scripts/setup-telegram.sh          # Setup bot
./scripts/setup.sh                   # Start Jenkins
./scripts/monitor.sh                 # Health check
```

**Happy CI/CD with Jenkins 2.504.2 + Telegram! 🚀📱** 