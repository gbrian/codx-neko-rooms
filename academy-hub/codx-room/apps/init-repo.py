import json, os, logging
logging.basicConfig(level=logging.INFO)
logging.info("Initializing repository")

codxjson = None
with open('codx.json') as codx:
  codxjson = json.load(codx)

apps = codxjson.get('apps')
if apps:
  for app in apps.keys():
    logging.info("Installing dependencie: %s" % app)
    os.system('codx %s' % app)

logging.info("Updating firefox open tabs")
url = codxjson.get('url')
tabs = codxjson.get('tabs')

ffsettings = open('/usr/lib/firefox/distribution/policies.json')
ffpolicies = open('')
  ffsettingsjson = json.load(ffsettings)
  if tabs:
    ffsettingsjson["Homepage"]["Additional"] = tabs
  if url:
    ffsettingsjson["Homepage"]["URL"] = url

with open('/usr/lib/firefox/distribution/policies.json', 'w') as ffsettings:
  ffsettings.write(json.dumps(ffsettingsjson))
