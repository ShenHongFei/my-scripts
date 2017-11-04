fs=require 'fs'
subtitles=fs.readdirSync('D:/').filter (f)->f.endsWith('.ass')
if !fs.existsSync('D:/new-subtitle')
    fs.mkdirSync('D:/new-subtitle')
for subtitle in subtitles
    text=fs.readFileSync("D:/#{subtitle}").toString()
    newtext=''
    for line in text.split('\n')
        parts=line.match /^(Style:\s.+?,)(.*?)(,.*)/
        if parts?.length
            line=parts[1]+'XHei iOS7 Mono'+parts[3]
        newtext+=line+'\n'
    fs.writeFileSync("D:/new-subtitle/#{subtitle}",newtext)

'Style: 注释,微软雅黑,52,&H14FFFFFF,&H000000FF,&H32B050F4,&H00000000,-1,0,0,0,100,100,0,0,1,1,0,7,10,10,10,1\r'.match /^(Style:\s.+?,)(.*?)(,.*)$/
'Style: 注释,微软雅黑,52,&H14FFFFFF,&H000000FF,&H32B050F4,&H00000000,-1,0,0,0,100,100,0,0,1,1,0,7,10,10,10,1'.match /^(Style:\s.+?,)(.*?)(,.*)$/