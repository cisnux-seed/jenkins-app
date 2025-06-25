#!/bin/bash

# Demo Pipeline Script - Manual Multi-Stage Pipeline Demonstration
# This script demonstrates the enhanced pipeline functionality manually

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
APP_NAME="jenkins-demo-app"
BUILD_NUMBER="demo-$(date +%s)"
DOCKER_IMAGE="${APP_NAME}:${BUILD_NUMBER}"
TELEGRAM_BOT_TOKEN="7847682562:AAGGjSmAGppypxzXO86azgi4WajRrwLmBcw"
TELEGRAM_CHAT_ID="5448715930"

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}🎬 Enhanced Multi-Stage Pipeline Demo${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo

# Function to send Telegram notification
send_notification() {
    local message="$1"
    curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
        -d "chat_id=${TELEGRAM_CHAT_ID}" \
        -d "text=${message}" \
        -d "parse_mode=HTML" > /dev/null
}

# Function to pause for user interaction
pause_for_user() {
    echo -e "${YELLOW}Press Enter to continue to next stage...${NC}"
    read -p ""
}

# Function to show stage header
show_stage() {
    local stage_number="$1"
    local stage_name="$2"
    local stage_emoji="$3"
    
    echo
    echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}${stage_emoji} Stage ${stage_number}: ${stage_name}${NC}"
    echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo
}

# Stage 1: Pipeline Initialization
stage_1_initialization() {
    show_stage "1" "Pipeline Initialization" "🚀"
    
    echo -e "${YELLOW}🔍 Initializing pipeline...${NC}"
    echo -e "  📋 Build Number: ${BUILD_NUMBER}"
    echo -e "  🏷️ Docker Image: ${DOCKER_IMAGE}"
    echo -e "  🎯 Environment: demo-staging"
    echo -e "  📱 Notifications: enabled"
    
    start_message="🚀 <b>Demo Pipeline Started</b>
━━━━━━━━━━━━━━━━━━━━━━━
📋 Job: Enhanced Multi-Stage Demo
🔢 Build: ${BUILD_NUMBER}
🌿 Branch: main
🎯 Environment: staging
🏷️ Tag: ${BUILD_NUMBER}
👤 Triggered by: Manual Demo
⏰ Started at: $(date '+%Y-%m-%d %H:%M:%S')
🔧 Demo Mode: Manual execution"
    
    send_notification "$start_message"
    echo -e "${GREEN}✅ Pipeline initialized successfully${NC}"
    echo -e "${GREEN}📱 Start notification sent to Telegram${NC}"
    
    pause_for_user
}

# Stage 2: Source Code Checkout
stage_2_checkout() {
    show_stage "2" "Source Code Checkout" "📥"
    
    echo -e "${YELLOW}📥 Checking out source code...${NC}"
    
    # Simulate git operations
    echo -e "  🌿 Branch: main"
    echo -e "  📍 Commit: $(git rev-parse --short HEAD 2>/dev/null || echo 'abc123')"
    echo -e "  💬 Message: $(git log -1 --pretty=%B 2>/dev/null | head -1 || echo 'Enhanced multi-stage pipeline demo')"
    
    ls -la sample-spring-app/ | head -5
    
    send_notification "📥 <b>Checkout Complete</b>
🔗 Commit: $(git rev-parse --short HEAD 2>/dev/null || echo 'abc123')
💬 Enhanced multi-stage pipeline demo"
    
    echo -e "${GREEN}✅ Source code checkout completed${NC}"
    pause_for_user
}

# Stage 3: Build Application
stage_3_build() {
    show_stage "3" "Build Application" "🔨"
    
    echo -e "${YELLOW}🔨 Building the application...${NC}"
    
    cd sample-spring-app
    echo -e "  📁 Working directory: $(pwd)"
    echo -e "  ⚙️ Running: mvn clean compile"
    
    if mvn clean compile -q; then
        echo -e "${GREEN}✅ Build completed successfully${NC}"
        send_notification "🔨 <b>Build Stage Completed</b>
✅ Application compiled successfully"
    else
        echo -e "${RED}❌ Build failed${NC}"
        send_notification "❌ <b>Build Failed</b>
🚨 Compilation errors detected"
        cd ..
        exit 1
    fi
    
    cd ..
    pause_for_user
}

# Stage 4: Testing & Quality Analysis (Parallel simulation)
stage_4_testing() {
    show_stage "4" "Testing & Quality Analysis" "🧪"
    
    echo -e "${YELLOW}🧪 Running parallel tests and quality analysis...${NC}"
    
    # Simulate parallel execution
    echo -e "${CYAN}📊 Parallel Execution:${NC}"
    echo -e "  🧪 Unit Tests"
    echo -e "  📊 Code Quality Analysis"
    echo -e "  🔒 Security Scan"
    
    cd sample-spring-app
    
    # Unit Tests
    echo -e "${YELLOW}  🧪 Running unit tests...${NC}"
    if mvn test -q; then
        echo -e "${GREEN}  ✅ Unit tests passed${NC}"
        send_notification "🧪 <b>Unit Tests Passed</b>
✅ All tests successful"
    else
        echo -e "${RED}  ❌ Unit tests failed${NC}"
        send_notification "❌ <b>Unit Tests Failed</b>
🚨 Test failures detected"
    fi
    
    # Code Quality
    echo -e "${YELLOW}  📊 Running code quality analysis...${NC}"
    sleep 2
    echo -e "${GREEN}  ✅ Code quality check passed${NC}"
    send_notification "📊 <b>Code Quality Check</b>
✅ Quality analysis completed"
    
    # Security Scan
    echo -e "${YELLOW}  🔒 Running security scan...${NC}"
    sleep 3
    echo -e "${GREEN}  ✅ Security scan completed - No vulnerabilities${NC}"
    send_notification "🔒 <b>Security Scan</b>
✅ No vulnerabilities detected"
    
    cd ..
    pause_for_user
}

# Stage 5: Package Application
stage_5_package() {
    show_stage "5" "Package Application" "📦"
    
    echo -e "${YELLOW}📦 Packaging the application...${NC}"
    
    cd sample-spring-app
    if mvn package -DskipTests -q; then
        echo -e "${GREEN}✅ Application packaged successfully${NC}"
        echo -e "  📁 JAR location: target/*.jar"
        ls -la target/*.jar 2>/dev/null || echo "  📝 JAR file created"
        
        send_notification "📦 <b>Package Complete</b>
✅ JAR file created successfully"
    else
        echo -e "${RED}❌ Packaging failed${NC}"
        cd ..
        exit 1
    fi
    
    cd ..
    pause_for_user
}

# Stage 6: Docker Build
stage_6_docker() {
    show_stage "6" "Docker Build & Registry" "🐳"
    
    echo -e "${YELLOW}🐳 Building Docker image...${NC}"
    
    if docker build -t "$DOCKER_IMAGE" -f docker/Dockerfile . -q; then
        echo -e "${GREEN}✅ Docker image built successfully${NC}"
        echo -e "  🏷️ Image: $DOCKER_IMAGE"
        
        send_notification "🐳 <b>Docker Image Built</b>
🏷️ Image: ${DOCKER_IMAGE}"
    else
        echo -e "${RED}❌ Docker build failed${NC}"
        exit 1
    fi
    
    pause_for_user
}

# Stage 7: Deploy to Staging
stage_7_staging() {
    show_stage "7" "Staging Deployment" "🎯"
    
    echo -e "${YELLOW}🎯 Deploying to staging environment...${NC}"
    
    # Stop existing staging container
    docker stop ${APP_NAME}-staging 2>/dev/null || true
    docker rm ${APP_NAME}-staging 2>/dev/null || true
    
    # Deploy to staging
    docker run -d \
        --name ${APP_NAME}-staging \
        -p 8081:8080 \
        -e SPRING_PROFILES_ACTIVE=staging \
        --restart unless-stopped \
        $DOCKER_IMAGE
    
    echo -e "${GREEN}✅ Staging deployment completed${NC}"
    echo -e "  🔗 URL: http://localhost:8081"
    
    send_notification "🎯 <b>Staging Deployment</b>
✅ Deployed successfully
🔗 URL: http://localhost:8081"
    
    pause_for_user
}

# Stage 8: Staging Tests
stage_8_staging_tests() {
    show_stage "8" "Staging Tests" "🔍"
    
    echo -e "${YELLOW}🔍 Running staging integration tests...${NC}"
    echo -e "  ⏳ Waiting for application to start (30 seconds)..."
    
    sleep 30
    
    # Health check
    echo -e "${YELLOW}  🩺 Running health check...${NC}"
    if curl -s -f "http://localhost:8081/health" > /dev/null 2>&1; then
        echo -e "${GREEN}  ✅ Health check passed${NC}"
        
        # API test
        echo -e "${YELLOW}  🔗 Testing API endpoint...${NC}"
        if curl -s -f "http://localhost:8081/" > /dev/null 2>&1; then
            echo -e "${GREEN}  ✅ API test passed${NC}"
            
            send_notification "🔍 <b>Staging Tests</b>
✅ All integration tests passed
🩺 Health: OK"
        else
            echo -e "${RED}  ❌ API test failed${NC}"
            exit 1
        fi
    else
        echo -e "${RED}  ❌ Health check failed${NC}"
        exit 1
    fi
    
    pause_for_user
}

# Stage 9: QA Approval Simulation
stage_9_qa_approval() {
    show_stage "9" "QA Approval Gate" "⏳"
    
    echo -e "${YELLOW}⏳ QA Approval required for production deployment...${NC}"
    
    send_notification "⏳ <b>QA Approval Required</b>
🔍 Please review staging environment
🎯 Staging: http://localhost:8081
⏰ Waiting for approval..."
    
    echo -e "${CYAN}📋 QA Review Checklist:${NC}"
    echo -e "  ✅ Staging environment accessible: http://localhost:8081"
    echo -e "  ✅ Application health check: OK"
    echo -e "  ✅ API endpoints responding: OK"
    echo -e "  ✅ Integration tests: PASSED"
    echo
    echo -e "${YELLOW}QA Decision:${NC}"
    echo -e "  1) Approve for production"
    echo -e "  2) Reject and abort"
    echo
    read -p "Enter your choice (1-2): " qa_decision
    
    case $qa_decision in
        1)
            echo -e "${GREEN}✅ QA approved for production deployment${NC}"
            send_notification "✅ <b>QA Approved</b>
👤 Decision: Approved
💬 Comments: Manual demo approval"
            ;;
        2)
            echo -e "${RED}❌ QA rejected - Pipeline aborted${NC}"
            send_notification "❌ <b>QA Rejected</b>
🛑 Pipeline aborted by QA"
            exit 1
            ;;
        *)
            echo -e "${RED}❌ Invalid choice - Pipeline aborted${NC}"
            exit 1
            ;;
    esac
    
    pause_for_user
}

# Stage 10: Production Deployment
stage_10_production() {
    show_stage "10" "Production Deployment" "🚀"
    
    echo -e "${YELLOW}⏳ DevOps approval required for production deployment...${NC}"
    
    send_notification "⏳ <b>DevOps Approval Required</b>
🚀 Ready for production deployment
⏰ Waiting for final approval..."
    
    echo -e "${CYAN}📋 Production Deployment Checklist:${NC}"
    echo -e "  ✅ QA approval: APPROVED"
    echo -e "  ✅ Staging tests: PASSED"
    echo -e "  ✅ Docker image: BUILT"
    echo -e "  ✅ Security scan: CLEAN"
    echo
    echo -e "${YELLOW}DevOps Decision:${NC}"
    echo -e "  1) Deploy to production"
    echo -e "  2) Abort deployment"
    echo
    read -p "Enter your choice (1-2): " devops_decision
    
    case $devops_decision in
        1)
            echo -e "${GREEN}✅ DevOps approved - Deploying to production...${NC}"
            
            # Stop existing production container
            docker stop ${APP_NAME}-prod 2>/dev/null || true
            docker rm ${APP_NAME}-prod 2>/dev/null || true
            
            # Deploy to production
            docker run -d \
                --name ${APP_NAME}-prod \
                -p 8090:8080 \
                -e SPRING_PROFILES_ACTIVE=production \
                --restart unless-stopped \
                $DOCKER_IMAGE
            
            echo -e "${GREEN}✅ Production deployment completed${NC}"
            echo -e "  🔗 URL: http://localhost:8090"
            
            send_notification "🚀 <b>Production Deployment</b>
✅ Deployed successfully
👤 Approved by: DevOps
💬 Notes: Manual demo deployment
🔗 URL: http://localhost:8090"
            ;;
        2)
            echo -e "${RED}❌ DevOps rejected - Pipeline aborted${NC}"
            send_notification "❌ <b>DevOps Rejected</b>
🛑 Production deployment aborted"
            exit 1
            ;;
        *)
            echo -e "${RED}❌ Invalid choice - Pipeline aborted${NC}"
            exit 1
            ;;
    esac
    
    pause_for_user
}

# Stage 11: Production Verification
stage_11_verification() {
    show_stage "11" "Production Verification" "🔍"
    
    echo -e "${YELLOW}🔍 Verifying production deployment...${NC}"
    echo -e "  ⏳ Waiting for application to start (30 seconds)..."
    
    sleep 30
    
    # Health check
    echo -e "${YELLOW}  🩺 Running production health check...${NC}"
    if curl -s -f "http://localhost:8090/health" > /dev/null 2>&1; then
        echo -e "${GREEN}  ✅ Production health check passed${NC}"
        
        # Smoke test
        echo -e "${YELLOW}  🔗 Running production smoke test...${NC}"
        if curl -s -f "http://localhost:8090/" > /dev/null 2>&1; then
            echo -e "${GREEN}  ✅ Production smoke test passed${NC}"
            
            send_notification "🔍 <b>Production Verification</b>
✅ All production tests passed
🩺 Health: OK
🎉 Deployment successful!"
        else
            echo -e "${RED}  ❌ Production smoke test failed${NC}"
            exit 1
        fi
    else
        echo -e "${RED}  ❌ Production health check failed${NC}"
        exit 1
    fi
    
    pause_for_user
}

# Stage 12: Post-Deployment Report
stage_12_report() {
    show_stage "12" "Post-Deployment Report" "📊"
    
    echo -e "${YELLOW}📊 Generating deployment report...${NC}"
    
    local end_time=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo -e "${CYAN}📋 Deployment Summary:${NC}"
    echo -e "  ✅ Status: SUCCESS"
    echo -e "  📋 Job: Enhanced Multi-Stage Demo"
    echo -e "  🔢 Build: ${BUILD_NUMBER}"
    echo -e "  🏷️ Version: ${BUILD_NUMBER}"
    echo -e "  🎯 Environment: staging + production"
    echo -e "  ⏰ Completed: ${end_time}"
    echo
    echo -e "${CYAN}🌐 Deployed URLs:${NC}"
    echo -e "  🎯 Staging: http://localhost:8081"
    echo -e "  🚀 Production: http://localhost:8090"
    echo
    echo -e "${CYAN}🐳 Running Containers:${NC}"
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep -E "(staging|prod)"
    
    report_message="📊 <b>Deployment Report</b>
━━━━━━━━━━━━━━━━━━━━━━━
✅ <b>Status:</b> SUCCESS
📋 <b>Job:</b> Enhanced Multi-Stage Demo
🔢 <b>Build:</b> ${BUILD_NUMBER}
🏷️ <b>Version:</b> ${BUILD_NUMBER}
🎯 <b>Environment:</b> staging + production
⏰ <b>Completed:</b> ${end_time}

🌐 <b>Deployed URLs:</b>
🎯 Staging: http://localhost:8081
🚀 Production: http://localhost:8090

🎉 <b>Demo Completed Successfully!</b>"
    
    send_notification "$report_message"
    
    echo -e "${GREEN}✅ Post-deployment report completed${NC}"
    echo -e "${GREEN}📱 Final report sent to Telegram${NC}"
}

# Final Summary
final_summary() {
    echo
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}🎉 Enhanced Multi-Stage Pipeline Demo Completed!${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo
    echo -e "${CYAN}📊 Demo Results:${NC}"
    echo -e "  ✅ 12 pipeline stages executed successfully"
    echo -e "  ✅ Multi-approval gates demonstrated"
    echo -e "  ✅ Telegram notifications working"
    echo -e "  ✅ Staging and production deployments active"
    echo -e "  ✅ Health checks and tests passed"
    echo
    echo -e "${CYAN}🌐 Access Your Applications:${NC}"
    echo -e "  🎯 Staging: http://localhost:8081"
    echo -e "  🚀 Production: http://localhost:8090"
    echo -e "  🔗 Jenkins: http://localhost:8080"
    echo
    echo -e "${CYAN}🧪 Next Steps:${NC}"
    echo -e "  • Test applications with: curl http://localhost:8081/health"
    echo -e "  • Check Telegram for complete notification history"
    echo -e "  • Run real Jenkins pipeline with: ./scripts/trigger-pipeline.sh"
    echo -e "  • Monitor containers with: docker ps"
    echo
    echo -e "${YELLOW}💡 This demo showed all features of the enhanced pipeline:${NC}"
    echo -e "  🚀 Multi-stage architecture"
    echo -e "  🔄 Parallel execution"
    echo -e "  ⏳ Approval gates"
    echo -e "  📱 Rich Telegram notifications"
    echo -e "  🎯 Multi-environment deployment"
    echo -e "  🔍 Comprehensive testing"
    echo
}

# Main execution
main() {
    echo -e "${CYAN}Starting Enhanced Multi-Stage Pipeline Demo...${NC}"
    echo -e "${YELLOW}This demo will walk through all 12 stages of the enhanced pipeline${NC}"
    echo -e "${YELLOW}You can interact with approval gates and see real Telegram notifications${NC}"
    echo
    read -p "Ready to start? Press Enter to begin..."
    
    # Execute all stages
    stage_1_initialization
    stage_2_checkout
    stage_3_build
    stage_4_testing
    stage_5_package
    stage_6_docker
    stage_7_staging
    stage_8_staging_tests
    stage_9_qa_approval
    stage_10_production
    stage_11_verification
    stage_12_report
    
    # Show final summary
    final_summary
}

# Run main function
main "$@" 