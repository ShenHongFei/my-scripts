fs=require 'fs'
subtitle_dir='D:\\1080P HEVC MKV 外挂\\S2正片修正版字幕'
target_dir='D:/new-subtitle'
subtitles=fs.readdirSync(subtitle_dir).filter (f)->f.endsWith('.ass')
if !fs.existsSync(target_dir)
    fs.mkdirSync(target_dir)
for subtitle in subtitles
    text=fs.readFileSync("#{subtitle_dir}\\#{subtitle}").toString()
    newtext=''
    for line in text.split('\n')
        parts=line.match /^(Style:\s.+?,)(.*?)(,.*)/
        if parts?.length
            line=parts[1]+'XHei iOS7 Mono'+parts[3]
        newtext+=line+'\n'
    fs.writeFileSync("#{target_dir}/#{subtitle}",newtext)

'Style: 注释,微软雅黑,52,&H14FFFFFF,&H000000FF,&H32B050F4,&H00000000,-1,0,0,0,100,100,0,0,1,1,0,7,10,10,10,1\r'.match /^(Style:\s.+?,)(.*?)(,.*)/