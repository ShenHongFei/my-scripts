fs=require 'fs'
subtitles=fs.readdirSync('D:/').filter (f)->f.endsWith('.ass') and /\[08\]/.test f
for subtitle in subtitles
    text=fs.readFileSync("D:/#{subtitle}").toString()
    newtext=''
    for line in text.split('\n')
        parts=line.match /^(Style:\s\w+,)(.*?)(,.*)$/
        if parts?.length
            line=parts[1]+'XHei iOS7 Mono'+parts[3]
        newtext+=line+'\n'
    fs.writeFileSync("D:/new-subtitle/#{subtitle}",newtext)

'Style: Default,方正粗圆_GBK,52,&H00FFFFFF,&HF0000000,&H00000000,&HF0000000,0,0,0,0,100,100,0,0,1,2,0,2,30,30,30,1'.match /^(Style:\s\w+,)(.*?)(,.*)$/