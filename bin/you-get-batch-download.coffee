get_from_chrome=->
    video_links=$('.video-list').find('a.title').map (i,e)->'http:'+e.getAttribute('href')
        .get()
    copy(JSON.stringify(video_links))

video_links=["http://www.bilibili.com/video/av15987015","http://www.bilibili.com/video/av15987194","http://www.bilibili.com/video/av15987274","http://www.bilibili.com/video/av15987411","http://www.bilibili.com/video/av15987795","http://www.bilibili.com/video/av15987894","http://www.bilibili.com/video/av15987893","http://www.bilibili.com/video/av15988327","http://www.bilibili.com/video/av15988106","http://www.bilibili.com/video/av15988187","http://www.bilibili.com/video/av15988485","http://www.bilibili.com/video/av15988394","http://www.bilibili.com/video/av15988888","http://www.bilibili.com/video/av15988613","http://www.bilibili.com/video/av15988853","http://www.bilibili.com/video/av15989200","http://www.bilibili.com/video/av15989811","http://www.bilibili.com/video/av15989806","http://www.bilibili.com/video/av16364954","http://www.bilibili.com/video/av15990292","http://www.bilibili.com/video/av15990095","http://www.bilibili.com/video/av15989997","http://www.bilibili.com/video/av15990409","http://www.bilibili.com/video/av15990645","http://www.bilibili.com/video/av15990440","http://www.bilibili.com/video/av15990821","http://www.bilibili.com/video/av15990727","http://www.bilibili.com/video/av15991621","http://www.bilibili.com/video/av15990890","http://www.bilibili.com/video/av15991862","http://www.bilibili.com/video/av15991925"]
cp=require('child_process')
for link in video_links
    cp.execSync("you-get #{link}", {stdio:[0,1,2],cwd:'D:/mofan-python'})