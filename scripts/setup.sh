#!/bin/bash

echo "=== Jenkins CI/CD Demo Setup ==="

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "Error: Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Create necessary directories
echo "Creating necessary directories..."
mkdir -p jenkins-data
mkdir -p app

# Set permissions
echo "Setting permissions..."
sudo chown -R 1000:1000 jenkins-data

# Start Jenkins
echo "Starting Jenkins with Docker Compose..."
docker-compose up -d

echo "Waiting for Jenkins to start up..."
sleep 30

# Check if Jenkins is running
if curl -f http://localhost:8080 >/dev/null 2>&1; then
    echo "✅ Jenkins is running successfully!"
    echo "🌐 Access Jenkins at: http://localhost:8080"
    echo "👤 Username: admin"
    echo "🔑 Password: admin123"
else
    echo "❌ Jenkins failed to start. Check logs with: docker-compose logs jenkins"
fi

echo ""
echo "=== Next Steps ==="
echo "1. Access Jenkins at http://localhost:8080"
echo "2. Login with admin/admin123"
echo "3. Create a new pipeline job"
echo "4. Configure GitHub webhook for automatic triggering"
echo "5. Run your first CI/CD pipeline!" 