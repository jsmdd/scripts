import urllib
import urllib2
import cookielib
import sys

Agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36"

#opener.addheaders=[("User-Agent","Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36")]

url="https://h5.ele.me/restapi/eus/login/mobile_send_code"

data={"mobile":"%s"%(sys.argv[1]),"captcha_value":"","captcha_hash":"","scf":"ms"}

data=urllib.urlencode(data)

request=urllib2.Request(url,data=data)
request.add_header("User-Agent",Agent)

response=urllib2.urlopen(request).read()
print response
