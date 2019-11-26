```python
import urllib
import urllib2
import cookielib
import sys

Agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36"

#opener.addheaders=[("User-Agent","Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36")]

url="http://my.edu.wanfangdata.com.cn/Account/SendMessageCode"

data={"MobilePhone":"%s"%(sys.argv[1]),"Type":"register"}

data=urllib.urlencode(data)

request=urllib2.Request(url,data=data)
request.add_header("User-Agent",Agent)

response=urllib2.urlopen(request).read()
print response
```
