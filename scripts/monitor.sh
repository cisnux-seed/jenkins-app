#!/bin/bash

# Monitoring script for Jenkins CI/CD Demo
# Checks Jenkins, applications, and system health

JENKINS_URL="${JENKINS_URL:-http://localhost:8080}"
STAGING_URL="${STAGING_URL:-http://localhost:8081}"
PROD_URL="${PROD_URL:-http://localhost:8090}"

echo "=== Jenkins CI/CD System Monitor ==="
echo "Timestamp: $(date)"
echo ""

# Function to check URL with authentication support
check_url() {
    local url="$1"
    local name="$2"
    local use_auth="$3"
    
    if [ "$use_auth" = "true" ]; then
        if curl -s -u admin:admin123 -f "$url" > /dev/null 2>&1; then
            echo "✅ $name: ONLINE ($url)"
            return 0
        else
            echo "❌ $name: OFFLINE ($url)"
            return 1
        fi
    else
        if curl -s -f "$url" > /dev/null 2>&1; then
            echo "✅ $name: ONLINE ($url)"
            return 0
        else
            echo "❌ $name: OFFLINE ($url)"
            return 1
        fi
    fi
}

# Check Jenkins
echo "🔧 Jenkins Status:"
check_url "$JENKINS_URL/login" "Jenkins Main" false
if curl -s -u admin:admin123 "$JENKINS_URL/api/json" 2>/dev/null | grep -q '"mode":"NORMAL"'; then
    echo "   ✅ Jenkins API: Responsive"
else
    echo "   ❌ Jenkins API: Not responding"
fi
echo ""

# Check Applications
echo "🚀 Application Status:"
check_url "$STAGING_URL/health" "Staging App" false
check_url "$PROD_URL/health" "Production App" false
echo ""

# Check Docker containers
echo "🐳 Docker Containers:"
if docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep -E "(jenkins|demo-app)"; then
    echo ""
else
    echo "❌ No Jenkins/Demo containers running"
fi

# Check system resources
echo "💻 System Resources:"
echo "   CPU Usage: $(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')"
echo "   Memory: $(memory_pressure | grep "System-wide memory free percentage" | awk '{print $5}')% free"
echo "   Disk: $(df -h / | tail -1 | awk '{print $5}') used"
echo ""

# Check network ports
echo "🌐 Network Ports:"
for port in 8080 8081 8090; do
    if lsof -i :$port > /dev/null 2>&1; then
        echo "   ✅ Port $port: Open"
    else
        echo "   ❌ Port $port: Closed"
    fi
done
echo ""

echo "=== Monitor Complete ===" 