fs=require 'fs'
require('sugar').extend()

# class LineProcessor
# {pattern(RegExp),process(fun line,i->newline)}
# --------------- file manipulation lib ---------------
read_lines=(file)->
    fs.readFileSync(file,'utf-8').split(/\r?\n/)
write_lines=(lines,file)->
    fs.writeFileSync file,lines.join('\n')+'\n'
process_matched_lines=(lines,line_processors...)->
    new_lines=[]
    for line,i in lines
        for p in line_processors
            if p.pattern.test line
                line=p.process line
        new_lines.append(line)
    new_lines

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
    style_header_pattern.test 'Style: 注释,XHei iOS7 Mono,52,&H14FFFFFF,&H000000FF,&H32B050F4,&H00000000,-1,0,0,0,100,100,0,0,1,1,0,7,10,10,10,1'
    style_line='Style: 注释,微软雅黑,52,&H14FFFFFF,&H000000FF,&H32B050F4,&H00000000,-1,0,0,0,100,100,0,0,1,1,0,7,10,10,10,1'
    style_line2='Style: Default,XHei iOS7 Mono,40,&H00000000,&H000000FF,&H00FDFFFF,&H00000000,0,0,0,0,100,100,0,0,1,2,2,2,10,10,15,1'
    style=extract_style(style_line)
    style.Fontname='XHei iOS7 Mono'
    generate_style(style)

# --------------- line processors ---------------------
style_changer=
    # style header pattern
    pattern:style_header_pattern
    process:(line,i)->
        style=extract_style(line)
        style.Fontname='XHei iOS7 Mono'
        style.Bord='0'
        generate_style(style)

string_remover=
    pattern:/.*/
    process:(line,i)->
        line.remove('{\\fn方正中倩简体}')
        
style_viewer=
    pattern:style_header_pattern
    process:(line,i)->
        console.log extract_style(line)
        line
        
# --------------- 常用功能 -----------------------
view_style_of_file=(file='')->
    process_matched_lines read_lines(file),style_viewer
    
    
# 修改单个ass字幕
change_style_of_file=(file='',line_processors...)->
    lines=read_lines(file)
    lines=process_matched_lines lines,line_processors...
    console.log "#{lines.length} processed"
    write_lines(lines,file)

batch_change_file_styles=(src_dir='D:\\さくら荘のペットな彼女',file_pattern=/.ass$/)->
    for file in fs.readdirSync(src_dir)
        if file_pattern.test file
            console.log file
            change_style_of_file(src_dir+'/'+file,style_changer)
    return

# --------------- main -----------------------
#batch_change_file_styles()