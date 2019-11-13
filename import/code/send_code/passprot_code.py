import urllib
import urllib2
import cookielib
import sys

Agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36"

url="http://passport.cnmo.com/index.php?c=Member_Ajax_Register&m=SendMessageCode&Jsoncallback=jQuery183029507456273924304_1570100116192&mobile=%s&type=1&_=1570100154856"%(sys.argv[1])

request=urllib2.Request(url)
request.add_header("User-Agent",Agent)

response=urllib2.urlopen(request).read()
print response
