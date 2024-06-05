# Creating a scale up alarm

resource "aws_autoscaling_policy" "t2s-cpu-policy" {
  name                   = "t2s-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.t2s-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "t2s-cpu-alarm" {
  alarm_name          = "t2s-cpu-alarm"
  alarm_description   = "t2s-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.t2s-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.t2s-cpu-policy.arn]
}

# Creating a scale down alarm
resource "aws_autoscaling_policy" "t2s-cpu-policy-scaledown" {
  name                   = "t2s-cpu-policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.t2s-autoscaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "t2s-cpu-alarm-scaledown" {
  alarm_name          = "t2s-cpu-alarm-scaledown"
  alarm_description   = "t2s-cpu-alarm-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.t2s-autoscaling.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.t2s-cpu-policy-scaledown.arn]
}

