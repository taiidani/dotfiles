---
name: coder
description: Information about the Coder platform and how to interact with it. This should be loaded any time I am referencing "Coder" or interacting with Coder related repositories such as https://github.com/hashicorp/coder and https://github.com/hashicorp/coder-templates.
---

# Coder Platform Skill

You are an expert in the Coder platform, a self-hosted development environment platform used at HashiCorp. You assist users with creating, managing, and troubleshooting Coder workspaces, templates, and CLI operations.

## Platform Overview

Coder is HashiCorp's self-hosted development environment platform that runs on existing infrastructure. It uses Terraform to define workspace templates as code, which developers can provision on-demand in minutes. Coder was adopted as a replacement for existing in-house tooling known as "PRDE" and "TF Cloud Boxes".

**Key Benefits:**
- **Infrastructure as Code**: Uses Terraform to define consistent workspace templates
- **On-Demand Provisioning**: Create workspaces in minutes (VMs, Kubernetes pods, GPU instances)
- **IDE Flexibility**: Connect using VS Code, JetBrains, Cursor, or any preferred IDE
- **Remote Development**: Offload compute-intensive workloads to cloud resources
- **AI Agent Support**: Provides secure environment isolation for AI coding agents

## HashiCorp Deployment

**CLI**: Installed via Homebrew

### Service - Development

**URL**: https://coder-dev.hashicorp.services

**Authentication**: Email+Password (Forge team members and select end users)

### Service - Production

**URL - Prod**: https://coder.hashicorp.services

**Authentication**: IBM W3 (all HashiCorp GitHub org members)

## Common Use Cases

### 1. Remote Development
Develop remotely on cloud-based workspaces, removing load from local machines. Automates provisioning of complex environment requirements and provides secure sandboxes for AI agents.

### 2. Agentic Development
Enables fully hands-off development flow where tasks can be provided to AI models to work independently on Coder workspaces until complete (e.g., "Here is a GitHub Issue. Please draft a Pull Request resolving this issue").

### 3. Ephemeral Sandboxes
Push-button compute for exploring new paradigms, innovation (Hack Weeks), quickly scaled to meet needs and torn down when no longer required.

### 4. Integration Testing
Create isolated environments for integration testing without affecting local development setups. Can be embedded into GitHub Actions or CI/CD pipelines for ephemeral test environments.

## CLI Commands

### Initial Setup
```bash
# Install Coder CLI
brew tap coder/coder
brew install coder/coder/coder

# Login to HashiCorp Coder (dev environment)
coder login https://coder-dev.hashicorp.services

# Login to HashiCorp Coder
coder login https://coder.hashicorp.services
```

### Workspace Management

**Create a workspace:**
```bash
coder create --template <template-name> <workspace-name>

# Create with specific parameters
coder create --template hashistack my-workspace \
  --parameter "instance_type=m5.large" \
  --stop-after 8h

# Create for another user (with permission)
coder create <username>/<workspace_name>
```

**List workspaces:**
```bash
coder list
```

**Start/Stop/Restart:**
```bash
coder start <workspace>
coder stop <workspace>
coder restart <workspace>
```

**Update workspace:**
```bash
# Updates and starts workspace if out of date
coder update <workspace>
```

**Delete workspace:**
```bash
coder delete <workspace>
```

**Show workspace details:**
```bash
coder show <workspace>
```

### Accessing Workspaces

**SSH into workspace:**
```bash
# Start interactive shell
coder ssh <workspace>

# Run a command
coder ssh <workspace> -- ls -la

# Forward SSH agent
coder ssh --forward-agent <workspace>

# Forward GPG agent
coder ssh --forward-gpg <workspace>
```

**Configure SSH:**
```bash
# Add SSH Host entry for workspaces
coder config-ssh
# Enables: ssh workspace.coder
```

**Port forwarding:**
```bash
coder port-forward <workspace> <local-port>:<remote-port>

# Reverse port forwarding
coder ssh -R <remote-port>:<local-address>:<local-port> <workspace>
```

**Open workspace in IDE:**
```bash
coder open <workspace>
```

### Template Management

**List templates:**
```bash
coder templates list
```

**Initialize template from example:**
```bash
coder templates init
```

**Push template update:**
```bash
coder templates push <template-name>
```

**Pull template version:**
```bash
# Pull active version
coder templates pull <template-name>

# Pull specific version
coder templates pull <template-name> --version <version-id>
```

**Template versions:**
```bash
coder templates versions <template-name>
```

### Workspace Automation

**Schedule auto-start/stop:**
```bash
coder schedule <workspace>

# Example start schedule (Mon-Fri 9am Pacific)
coder schedule start <workspace> "CRON_TZ=America/Los_Angeles 0 9 * * Mon-Fri"

# Example stop after 8 hours
coder schedule stop <workspace> 8h
```

**Auto-updates:**
```bash
# Enable/disable automatic updates
coder autoupdate <workspace> always
coder autoupdate <workspace> never
```

### Monitoring & Debugging

**View logs:**
```bash
coder logs <workspace>
```

**Resource usage:**
```bash
coder stat <workspace>
```

**Network diagnostics:**
```bash
# Network debug for DERP and STUN
coder netcheck

# Ping workspace
coder ping <workspace>

# Speed test
coder speedtest <workspace>
```

**Provisioner jobs:**
```bash
coder provisioner jobs
coder provisioner daemons
```

### Authentication & User Management

**Check current user:**
```bash
coder whoami
```

**Logout:**
```bash
coder logout
```

**Manage tokens:**
```bash
coder tokens list
coder tokens create
coder tokens delete <token-id>
```

**Git operations SSH key:**
```bash
# Output public key for Git operations
coder publickey

# Must be added to GitHub account at:
# https://github.com/settings/keys
# Don't forget to bless for HashiCorp SSO!
```

## Global Options

Available environment variables and flags for all commands:

- `--url` / `$CODER_URL`: URL to deployment (default: https://coder.hashicorp.services)
- `--token` / `$CODER_SESSION_TOKEN`: Authentication token (use env var for security)
- `-v, --verbose` / `$CODER_VERBOSE`: Enable verbose output
- `--global-config` / `$CODER_CONFIG_DIR`: Path to config directory (default: `~/Library/Application Support/coderv2`)
- `--disable-direct-connections` / `$CODER_DISABLE_DIRECT_CONNECTIONS`: Disable P2P connections
- `--no-version-warning`: Suppress client/server version mismatch warnings
- `--force-tty`: Force TTY use

## Templates

Templates are written in standard Terraform and describe the infrastructure for workspaces. Common HashiCorp templates include:

- **hashistack**: Standard HashiCorp development environment template

Templates define:
- Infrastructure resources (VMs, containers, storage)
- Development tools and dependencies
- Configuration and environment variables
- Startup scripts and initialization
- Resource limits and scheduling policies

## Workspace Lifecycle

1. **Create**: Provision workspace from template
2. **Start**: Boot workspace and run startup scripts
3. **Connect**: SSH, IDE, or web terminal access
4. **Work**: Develop in consistent, isolated environment
5. **Stop**: Suspend workspace to save resources
6. **Update**: Apply template changes to workspace
7. **Delete**: Destroy workspace and resources

## Documentation Resources

**Local Documentation**: `/Users/rnixon/hashicorp/coder/docs/`
- `tutorials/getting-started.md`: First workspace setup guide
- `concepts/`: Understanding-oriented explanations
- `procedures/`: Task-oriented how-to guides
- `admin/`: Administrative runbooks and rituals

**Online Documentation**: https://coder.com/docs
- User guides for developers
- Template admin guides
- Deployment admin guides
- Integration guides (VS Code, JetBrains, Backstage)

**GitHub Repository**: https://github.com/hashicorp/coder

## Troubleshooting

### Common Issues

**Connection Problems:**
```bash
# Check network connectivity
coder netcheck

# Test workspace connection
coder ping <workspace>

# View workspace logs
coder logs <workspace>
```

**Workspace Not Starting:**
```bash
# Check workspace status
coder show <workspace>

# View provisioner jobs
coder provisioner jobs

# Restart workspace
coder restart <workspace>
```

**Template Issues:**
```bash
# View template versions
coder templates versions <template>

# Check provisioner logs
coder provisioner jobs --template <template>
```

**SSH/Git Authentication:**
```bash
# Regenerate public key
coder publickey

# Verify SSH config
coder config-ssh
cat ~/.ssh/config | grep -A 10 "Host *.coder"
```

### Support Commands

```bash
# Generate support bundle
coder support bundle

# View detailed version info
coder version

# Enable debug mode
coder --verbose <command>
```

## Best Practices

1. **Use Scheduled Shutdown**: Configure `--stop-after` to save resources when workspaces aren't in use
2. **Keep Templates Updated**: Regularly update workspace templates for latest tools and security patches
3. **SSH Key Setup**: Configure SSH key in GitHub immediately after login for seamless Git operations
4. **Naming Convention**: Use descriptive workspace names (e.g., `feature-auth-service`, `hotfix-api-bug`)
5. **Resource Management**: Monitor workspace resource usage with `coder stat`
6. **Port Forwarding**: Use `coder port-forward` for accessing services running in workspaces
7. **Favorites**: Mark frequently used workspaces as favorites for quick access

## Integration Points

### VS Code
- Official extension available
- One-click workspace access from deployment
- Remote SSH development support

### Zed
- One-click workspace access from deployment
- Remote SSH development support

### JetBrains Gateway
- Access Coder environments from IntelliJ, PyCharm, etc.
- Full IDE feature support

### Dev Containers
- Build environments with Dev Containers
- Supports Docker, Kubernetes, OpenShift

### CI/CD
- Integrate with GitHub Actions for ephemeral test environments
- Use workspaces in pipeline jobs

## Version Information

**Current CLI**: v2.30.0+43e67d1
**Platform**: HashiCorp Coder deployment
**Documentation Framework**: Diátaxis (tutorials, concepts, procedures, reference)

## When to Use This Skill

Invoke this skill when users:
- Ask about Coder platform features or usage
- Need help creating, managing, or accessing workspaces
- Want to understand Coder templates or infrastructure
- Encounter workspace connection or provisioning issues
- Request information about HashiCorp's development environment setup
- Need CLI command examples or troubleshooting guidance
- Ask about remote development or AI agent integration with Coder
