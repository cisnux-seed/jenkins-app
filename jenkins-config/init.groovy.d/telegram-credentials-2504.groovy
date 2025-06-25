#!groovy

import jenkins.model.*
import hudson.slaves.EnvironmentVariablesNodeProperty

println "=== Configuring Telegram for Jenkins 2.504.2 ==="

def instance = Jenkins.getInstance()

try {
    // Set global environment variables for Telegram
    def globalNodeProperties = instance.getGlobalNodeProperties()
    def envVarsNodeProperty = globalNodeProperties.get(EnvironmentVariablesNodeProperty.class)
    
    if (envVarsNodeProperty == null) {
        envVarsNodeProperty = new EnvironmentVariablesNodeProperty()
        globalNodeProperties.add(envVarsNodeProperty)
    }
    
    def envVars = envVarsNodeProperty.getEnvVars()
    
    // Add Telegram environment variables
    envVars.put("TELEGRAM_BOT_TOKEN", "7992323994:AAGFPm-f74H_39DpfPmMN7cJ8y6VE-YloOY")
    envVars.put("TELEGRAM_CHAT_ID", "1309089514")
    
    // Save the configuration
    instance.save()
    
    println "✅ Telegram environment variables configured successfully!"
    println "   - TELEGRAM_BOT_TOKEN: ****configured****"
    println "   - TELEGRAM_CHAT_ID: 1309089514"
    println "🎉 Jenkins is ready for Telegram notifications!"
    
} catch (Exception e) {
    println "❌ Error setting Telegram environment variables: ${e.message}"
    e.printStackTrace()
}

println "=== Telegram Configuration Complete ===" 