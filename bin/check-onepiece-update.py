import requests
html=requests.get('http://btbtt.org/thread-index-fid-981-tid-4349164.htm').text
import re
pattern='<a href="(.*)" target="_blank" rel="nofollow"><img src="/view/image/filetype/torrent.gif" width="16" height="16" />([Skytree][ONE PIECE 海贼王][\\d+][X264][1080P][GB_BIG5_JP][MP4][CRRIP][简繁日中日双语内挂字幕].torrent)</a>'
pattern_regex=pattern.translate(str.maketrans({'[':'\\[', ']':'\\]', ' ':'\\s'}))
links=re.findall(pattern_regex,html)
torrent_link,title=links[-1]
torrent_link='http://btbtt.org/'+torrent_link
import os
my_latest=os.listdir('E:\影视\动漫\海贼王')[-2]
if re.findall(r'\[(\d+)\]',my_latest)!=re.findall(r'\[(\d+)\]',title):
    os.system(f'cmd.exe /c start {torrent_link}')
else: print(f'无更新\n{title}\n{torrent_link}')