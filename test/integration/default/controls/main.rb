title 'AWS Budgets SNS Topic'

budgets_topic_arn = attribute('budgets_topic_arn')

control 'sns' do
  describe aws_sns_topic(arn: budgets_topic_arn) do
    it { should exist }
  end
end
