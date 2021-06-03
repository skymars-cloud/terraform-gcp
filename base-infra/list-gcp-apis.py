#  pip install --upgrade google-api-python-client google-auth-httplib2 google-auth-oauthlib
#  pip install --upgrade oauth2client

from googleapiclient import discovery
from oauth2client.client import GoogleCredentials

credentials = GoogleCredentials.get_application_default()

project = 'projects/prj-dev-palani-ram'

service = discovery.build('serviceusage', 'v1', credentials=credentials)
gcp_services = service.services()
request = gcp_services.list(parent=project)

response = ''

try:
    response = request.execute()
except Exception as e:
    print(e)
    exit(1)

# FIX - This code does not process the nextPageToken
# next = response.get('nextPageToken')

services = response.get('services')

for index in range(len(services)):
    item = services[index]

    name = item['config']['name']
    state = item['state']

    print("%-50s %s" % (name, state))