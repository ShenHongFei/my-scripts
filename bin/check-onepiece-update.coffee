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
html=(()=>await(request.get('http://btbtt.org/thread-index-fid-981-tid-4349164.htm')))()
console.log(typeof html)
str2reg_map=
    '[':'\\['
    ']':'\\]'
    ' ':'\\s'
pattern='<a href="(.*)" target="_blank" rel="nofollow"><img src="/view/image/filetype/torrent.gif" width="16" height="16" />([Skytree][ONE PIECE 海贼王][\\d+][X264][1080P][GB_BIG5_JP][MP4][CRRIP][简繁日中日双语内挂字幕].torrent)</a>'
pattern_regex=(str2reg_map[c] or c for c in pattern).join('')
links=html.match(new RegExp(pattern_regex,'g'))
[...,newest_link]=links
[_,torrent_link,title]=newest_link.match(pattern_regex)
store_path='./data/onepiece.json'
newest_item={torrent_link:'http://btbtt.org/'+torrent_link,title}
old_value=null
fs=require 'fs'
if fs.existsSync(store_path)
    console.log '读取数据'
    old_value=JSON.parse(fs.readFileSync(store_path))
if not (require 'underscore').isEqual(old_value,newest_item)
    console.log "有更新！"
    fs.writeFileSync(store_path,JSON.stringify(newest_item,null,4))
    (require 'child_process').spawn('cmd.exe',['/c','start',newest_item.torrent_link])
else 
    console.log "无更新。"
console.log newest_item
