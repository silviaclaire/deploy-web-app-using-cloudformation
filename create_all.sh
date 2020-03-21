region=$1

# create IAM role
sh create.sh $region udagram-role role.yml role-parameters.json

# create network
sh create.sh $region udagram-network network.yml network-parameters.json

# deploy web application
sh create.sh $region udagram-server servers.yml server-parameters.json

# output application's URL
echo "Web Application URL: "
aws cloudformation describe-stacks \
    --region $region \
    --stack-name udagram-server \
    --query "Stacks[0].Outputs[?OutputKey=='WebAppURL'].OutputValue" \
    --output text
