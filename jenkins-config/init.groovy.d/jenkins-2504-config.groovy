#!groovy

import jenkins.model.*
import hudson.security.*
import jenkins.security.s2m.AdminWhitelistRule
import jenkins.install.InstallState

def instance = Jenkins.getInstance()

// Skip setup wizard for Jenkins 2.504.2
if (!instance.getInstallState().isSetupComplete()) {
    println "Setting up Jenkins 2.504.2..."
    instance.setInstallState(InstallState.INITIAL_SETUP_COMPLETED)
}

// Configure security realm
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
if (!hudsonRealm.getAllUsers().find { it.getId() == "admin" }) {
    hudsonRealm.createAccount("admin", "admin123")
    instance.setSecurityRealm(hudsonRealm)
}

// Configure authorization strategy
def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)

// Disable Jenkins CLI over remoting
Jenkins.instance.getDescriptor("jenkins.CLI").get().setEnabled(false)

// Configure CSRF protection
instance.setCrumbIssuer(new hudson.security.csrf.DefaultCrumbIssuer(true))

// Disable usage statistics
instance.setNoUsageStatistics(true)

// Set number of executors
instance.setNumExecutors(2)

// Configure admin whitelist rule for Jenkins 2.504.2
try {
    Jenkins.instance.getInjector().getInstance(AdminWhitelistRule.class).setMasterKillSwitch(false)
} catch (Exception e) {
    println "AdminWhitelistRule configuration skipped: ${e.getMessage()}"
}

println "Jenkins 2.504.2 configuration completed"
instance.save() 