#! /bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

source $DIR/../.env

COMMAND_PACKAGE="aws cloudformation package --template-file aws-stack.json --output-template aws-stack.yaml --region us-east-1 --s3-bucket $DEPLOYMENT_BUCKET --profile=${AWS_CONTENT_PROFILE}"

COMMAND_DEPLOY="aws cloudformation deploy --template-file aws-stack.yaml \
--stack ${STACK_NAME:=test-server} --region us-east-1 \
--capabilities CAPABILITY_IAM --s3-bucket $DEPLOYMENT_BUCKET \
--parameter-overrides HttpApiDomainName=${HTTP_API_DOMAIN_NAME} \
ApiCertificateArn=${API_CERTIFICATE_ARN} \
--profile=${AWS_CONTENT_PROFILE}"

echo $COMMAND_PACKAGE;
echo $COMMAND_DEPLOY;


$COMMAND_PACKAGE

$COMMAND_DEPLOY
