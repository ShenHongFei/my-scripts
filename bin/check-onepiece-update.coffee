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

open_link=(url)->
    cp.spawn('cmd.exe',['/c','start',url])

main=(url='http://btbtt.org/thread-index-fid-981-tid-4349164.htm',db='D:/Scripts/data/onepiece.json')->
    html=await request.get(url)
    str2reg_map=
        '[':'\\['
        ']':'\\]'
        ' ':'\\s'
    pattern='<a href="(.*)" target="_blank" rel="nofollow"><img src="/view/image/filetype/torrent.gif" width="16" height="16" />([Skytree][ONE PIECE 海贼王][\\d+][X264][1080P][GB_BIG5_JP][MP4][CRRIP][简繁日中日双语内挂字幕].torrent)</a>'
    pattern_regex=(str2reg_map[c] or c for c in pattern).join('')
    links=html.match(new RegExp(pattern_regex,'g'))
    [...,newest_link]=links
    [_,torrent_link,title]=newest_link.match(pattern_regex)
    torrent_link='http://btbtt.org/'+torrent_link
    newest_item={torrent_link,title}
    fs=require 'fs'
    old_value=if fs.existsSync(db) then JSON.parse(fs.readFileSync(db)) else null
    newest_episode=title.match(/\[(\d+)\]/)[1]
    if !Object.isEqual(newest_item,old_value)
        console.log("发现更新！#{newest_episode}")
    else console.log("最新 #{newest_episode}")
    fs.writeFileSync(db,JSON.stringify(newest_item))
    console.log(newest_item)
    rl=require('readline').createInterface(input:process.stdin,output:process.stdout)
    rl.question '下载种子？',->
        open_link(torrent_link)
        rl.close()

main()
