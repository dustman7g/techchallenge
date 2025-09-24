# Part Two – Operational Analysis and Improvement Plan

## Analysis of Deployed Infrastructure

### Security Gaps
- Management EC2 has direct internet access but no MFA/bastion protections.
- No encryption settings enforced on EBS volumes.
- Security groups allow SSH; no session logging or intrusion detection.
- No centralized logging of ALB or EC2 activity.

### Availability Issues
- Only one management instance (single point of failure).
- Auto Scaling Group (ASG) is spread across AZs, but backend subnet unused for HA.
- No health checks or alarms beyond ALB defaults.

### Cost Optimization Opportunities
- All EC2 are on-demand; reserved or spot instances could reduce cost.
- t2.micro may be over/under-provisioned depending on workload.
- Idle management instance incurs cost when not in use.

### Operational Shortcomings
- No automated backups (EBS snapshots, AMIs, or database backups).
- No CloudWatch alarms/metrics dashboards for visibility.
- No patching/AMIs baked with configuration.
- No runbooks for failure recovery.

---

## Improvement Plan

### Priority 1 – Security
- Restrict SSH access further (use Systems Manager Session Manager instead).
- Encrypt EBS volumes by default.
- Enable VPC Flow Logs and ALB access logs.

### Priority 2 – Availability
- Deploy a second management node in another AZ or replace with SSM.
- Add CloudWatch alarms for EC2 health and ASG scaling events.

### Priority 3 – Cost
- Shut down management instance when not needed or replace with on-demand SSM sessions.
- Consider spot instances for ASG if workload is fault-tolerant.

### Priority 4 – Maintainability
- Add Terraform modules for monitoring/backup automation.
- Implement CI/CD pipeline for infrastructure deployments.

---

## Implemented Improvements in Code
1. **Security Group Tightening**  
   - Restricted management SSH access to a single trusted IP.  
   - Allowed Application ASG only inbound HTTP (80) from ALB and SSH from Management subnet.  

2. **Monitoring Enhancement**  
   - Added CloudWatch alarm for high CPU on ASG instances.  
   - Sends notification to SNS topic (placeholder subscription).

---

## Runbook Notes

### Deploying the Environment
```bash
git clone https://github.com/dustman7g/techchallenge.git
cd https://github.com/dustman7g/techchallenge.git
terraform init
terraform plan
terraform apply

### Deploying the Environment
terraform destroy

