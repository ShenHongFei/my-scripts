###
cd D:/Scripts
coffee bin/check-onepiece-update.coffee
yarn add coffeescript
yarn add request
yarn add request-promise-native
yarn add @types/request
yarn add undersco
###
request=require('request-promise-native')
require('sugar').extend()
cp=require('child_process')

main=(url='http://btbtt.org/thread-index-fid-981-tid-4349164.htm',db='D:/Scripts/data/onepiece.json')->
    html=await request.get(url)
    str2reg_map=
        '[':'\\['
        ']':'\\]'
        ' ':'\\s'
    pattern_x264='<a href="(.*)" target="_blank" rel="nofollow"><img src="/view/image/filetype/torrent.gif" width="16" height="16" />([Skytree][ONE PIECE 海贼王][\\d+][X264][1080P][GB_BIG5_JP][MP4][CRRIP][简繁日中日双语内挂字幕].torrent)</a>'
    pattern_x265='<a href="(.*)" target="_blank" rel="nofollow"><img src="/view/image/filetype/torrent.gif" width="16" height="16" />([Skytree][ONE PIECE 海贼王][\\d+][X265][1080P][GB_JP][MP4][CRRIP][中日双语字幕].torrent)</a>'
    extract_newest_item=(pattern)->
        pattern_regex=(str2reg_map[c] or c for c in pattern).join('')
        links=html.match(new RegExp(pattern_regex,'g'))
        [...,newest_link]=links
        [_,torrent_link,title]=newest_link.match(pattern_regex)
        torrent_link='http://btbtt.org/'+torrent_link
        episode=parseInt(title.match(/\[(\d+)\]/)[1])
        {torrent_link,title,episode}
    newest_x264=extract_newest_item(pattern_x264)
    newest_x265=extract_newest_item(pattern_x265)
    newest_item=if newest_x264.episode>newest_x265.episode then newest_x264 else newest_x265
    fs=require 'fs'
    old_value=if fs.existsSync(db) then JSON.parse(fs.readFileSync(db)) else null
    console.log (if newest_item.episode!=old_value.episode then '发现更新：' else '最新：')+newest_item.episode+'\n'+newest_item.torrent_link
    fs.writeFileSync(db,JSON.stringify(newest_item))
    rl=require('readline').createInterface(input:process.stdin,output:process.stdout)
    open_link=(url)->
        cp.spawn('cmd.exe',['/c','start',url])
    rl.question '下载种子？',->
        open_link(newest_item.torrent_link)
        rl.close()

main()
