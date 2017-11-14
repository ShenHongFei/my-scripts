fs=require 'fs'

# 参数
subtitle_dir='D:\\[Moozzi2] Shouwa Genroku Rakugo Shinjuu - TV + OAD'
target_dir=subtitle_dir


# style模块
style_format='Format: Name, Fontname, Fontsize, PrimaryColour, SecondaryColour, OutlineColour, BackColour, Bold, Italic, Underline, StrikeOut, ScaleX, ScaleY, Spacing, Angle, BorderStyle, Outline, Shadow, Alignment, MarginL, MarginR, MarginV, Encoding'.remove('Format: ').split(', ')
style_header='Style: '

extract_style=(style_line)->
    style_line=style_line.removeAll(/[\r\n]/)
    styles=style_line.remove(style_header).split(',').map (x)->x.trim()
    style={}
    for i in [0...style_format.length]
        style[style_format[i]]=styles[i]
    style
    
generate_style=(style)->
    style_header+(style[style_format[i]] for i in [0...style_format.length]).join(',')

style_test=->
    style_line='Style: 注释,微软雅黑,52,&H14FFFFFF,&H000000FF,&H32B050F4,&H00000000,-1,0,0,0,100,100,0,0,1,1,0,7,10,10,10,1'
    style_line2='Style: Default,XHei iOS7 Mono,40,&H00000000,&H000000FF,&H00FDFFFF,&H00000000,0,0,0,0,100,100,0,0,1,2,2,2,10,10,15,1'
    style=extract_style(style_line)
    style.Fontname='XHei iOS7 Mono'
    generate_style(style)
    
    
# 批量修改ass字幕字体
subtitles=fs.readdirSync(subtitle_dir).filter (f)->f.endsWith('.ass')
if !fs.existsSync(target_dir)
    fs.mkdirSync(target_dir)
for subtitle in subtitles
    text=fs.readFileSync("#{subtitle_dir}/#{subtitle}").toString()
    newtext=''
    for line in text.split('\n')
        if /^Style:\s/.test(line)
            style=extract_style(line)
            style.Fontname='XHei iOS7 Mono'
            line=generate_style(style)
        newtext+=line+'\n'
    fs.writeFileSync("#{target_dir}/#{subtitle}",newtext)

