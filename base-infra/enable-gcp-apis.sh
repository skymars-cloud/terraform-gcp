#!/usr/bin/env bash

gcloud services enable cloudfunctions.googleapis.com --async --project prj-dev-palani-ram
gcloud services enable gkehub.googleapis.com --async --project prj-dev-palani-ram
gcloud services enable vpcaccess.googleapis.com --async --project prj-dev-palani-ram
gcloud services enable logging.googleapis.com --async --project prj-dev-palani-ram
gcloud services enable container.googleapis.com --async --project prj-dev-palani-ram
gcloud services enable compute.googleapis.com --async --project prj-dev-palani-ram
gcloud services enable containeranalysis.googleapis.com --async --project prj-dev-palani-ram
gcloud services enable iam.googleapis.com --async --project prj-dev-palani-ram
gcloud services enable serviceusage.googleapis.com --async --project prj-dev-palani-ram
gcloud services enable serviceconsumermanagement.googleapis.com --async --project prj-dev-palani-ram
gcloud services enable cloudbuild.googleapis.com --async --project prj-dev-palani-ram               # needed for cloud function

