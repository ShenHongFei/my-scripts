fs=require 'fs'
require('sugar').extend()

# --------------- file manipulation lib ---------------
read_lines=(file)->fs.readFileSync(file,'utf-8').split(/\r?\n/)
write_lines=(lines,file)->fs.writeFileSync file,lines.join('\n')+'\n'
# pattern(RegExp),line_processor(line->newline)
process_matched_lines=(lines,pattern,line_processor)->
    new_lines=[]
    for line,i in lines
        if pattern.test pattern
            result=line_processor(line,i)
            new_lines.append result if result
        else new_lines.append result

# --------------- style fun lib -----------------------
# [V4+ Styles]
style_format='Format: Name, Fontname, Fontsize, PrimaryColour, SecondaryColour, OutlineColour, BackColour, Bold, Italic, Underline, StrikeOut, ScaleX, ScaleY, Spacing, Angle, BorderStyle, Outline, Shadow, Alignment, MarginL, MarginR, MarginV, Encoding'.remove('Format: ').split(', ')
style_header='Style: '
style_header_pattern=RegExp('^'+style_header)

extract_style=(style_line)->
    styles=style_line.remove(style_header).split(',').map (x)->x.trim()
    style={}
    for attr,i in style_format
        style[attr]=styles[i]
    style
    
# 生成 'Style: xxx,xxx,...'
generate_style=(style)->
    style_header+(style[style_format[i]] for i in [0...style_format.length]).join(',')
        
style_test=->
    style_line='Style: 注释,微软雅黑,52,&H14FFFFFF,&H000000FF,&H32B050F4,&H00000000,-1,0,0,0,100,100,0,0,1,1,0,7,10,10,10,1'
    style_line2='Style: Default,XHei iOS7 Mono,40,&H00000000,&H000000FF,&H00FDFFFF,&H00000000,0,0,0,0,100,100,0,0,1,2,2,2,10,10,15,1'
    style=extract_style(style_line)
    style.Fontname='XHei iOS7 Mono'
    generate_style(style)

# --------------- main -----------------------
view_style_of_file=(file='D:/樱花庄的宠物女孩/01.ass')->
    process_matched_lines read_lines(file),style_header_pattern,(line,i)->
        console.log extract_style(line)
        line

my_style_hack=(style)->
    style.Fontname='XHei iOS7 Mono'
    style.Bord='0'
    style
    
# 修改单个ass字幕
change_style_of_file=(file='D:/樱花庄的宠物女孩/01.ass',style_changer=my_style_hack)->
    new_lines=process_matched_lines read_lines(file),style_header_pattern,(line)->
        style=extract_style(line)
        new_style=style_changer(style)
        generate_style(new_style)
    write_lines(file,new_lines)
    
batch_change_file_styles=(dir,file_pattern)->
    for file in fs.readdirSync(dir)
        if file_pattern.test file
            change_style_of_file(file)

