# Get current AWS account ID for resource naming and ARN construction
data "aws_caller_identity" "current" {}

# Get current AWS region for cross-region resource references
data "aws_region" "current" {}