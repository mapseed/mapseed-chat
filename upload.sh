#!/bin/bash

case $AWS_PROFILE in
  default|"") 
  AWS_PROFILE=default
  ;;
esac
DRY_RUN_FLAG=""


if [[ $1 == "prod" ]]
then
  echo "Uploading to s3 bucket!"
elif [[ $1 == "test" ]]
then
  echo "Dry run of uploading s3 bucket!"
  DRY_RUN_FLAG="--dryrun"
else
  echo "You must indicate whether you are running this script in 'prod' or 'test' mode"
  echo "examples:"
  echo ""
  echo "./upload.sh test"
  echo "OR"
  echo "./upload.sh prod"
  echo ""
  echo "OR, to customize AWS_PROFILE:"
  echo "AWS_PROFILE=mapseed-user ./upload.sh prod"
  echo ""
  echo "Goodbye."
  exit 0
fi
aws s3 sync --profile $AWS_PROFILE $DRY_RUN_FLAG --region us-west-1 --acl public-read --cache-control "no-cache" --delete --exclude '.git/*' --exclude upload.sh _site s3://chat.mapseed.org/
