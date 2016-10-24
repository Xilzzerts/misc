#!/usr/bin/env python2
import urllib
CSINDEX_NEW = "http://www.csindex.com.cn/sseportal/ps/zhs/hqjt/csi/show_zsgz.js"
content = urllib.urlopen(CSINDEX_NEW).read()
main_array = content.decode("gbk").encode("utf-8").split("\r\n")
info = {}
main_list = []
temp_list = []
i = 0
for x in main_array[1:]:
    i = i + 1
    temp_list.append(x.split("=")[-1].strip().replace("\"", "").strip())
    if i % 9 == 0:
        main_list.append(temp_list)
        temp_list = []
for item in main_list:
    info[item[0]] = item[1:]
print main_array[0].split("=")[-1].strip().replace("\"", "")
for key in info:
    value = ("%.2f%%" % (1 / float(info[key][0]) * 100))
    info[key].append(value)
    print key, info[key][-1]
