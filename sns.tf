# Creating An SNS Topic. 
resource "aws_sns_topic" "t2s-sns" {
 name         = "sg-sns"
 display_name = "The SNS topic to deploy"
} 
resource "aws_autoscaling_notification" "t2s-notify" {
 group_names = ["${aws_autoscaling_group.t2s-autoscaling.name}"]
 topic_arn     = "${aws_sns_topic.t2s-sns.arn}"
 notifications  = [
   "autoscaling:EC2_INSTANCE_LAUNCH",
   "autoscaling:EC2_INSTANCE_TERMINATE",
   "autoscaling:EC2_INSTANCE_LAUNCH_ERROR"
 ]
}

resource "aws_sns_topic_subscription" "email-target" {
  topic_arn = aws_sns_topic.t2s-sns.arn
  protocol  = "email"
  endpoint  = var.email
}
