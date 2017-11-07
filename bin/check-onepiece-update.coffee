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
request.get('http://btbtt.org/thread-index-fid-981-tid-4349164.htm').then (html)->
    str2reg_map=
        '[':'\\['
        ']':'\\]'
        ' ':'\\s'
    pattern='<a href="(.*)" target="_blank" rel="nofollow"><img src="/view/image/filetype/torrent.gif" width="16" height="16" />([Skytree][ONE PIECE 海贼王][\\d+][X264][1080P][GB_BIG5_JP][MP4][CRRIP][简繁日中日双语内挂字幕].torrent)</a>'
    pattern_regex=(str2reg_map[c] or c for c in pattern).join('')
    links=html.match(new RegExp(pattern_regex,'g'))
    [...,newest_link]=links
    [_,torrent_link,title]=newest_link.match(pattern_regex)
    newest_item={torrent_link:'http://btbtt.org/'+torrent_link,title}
    fs=require 'fs'
    latest_file=fs.readdirSync('E:\\影视\\动漫\\海贼王').at(-2)
    episode_pattern='\\[(\\d+)\\]'
    local_latest_episode=latest_file.match(episode_pattern)[1]
    web_latest_episode=title.match(episode_pattern)[1]
    if local_latest_episode!=web_latest_episode
        (require 'child_process').spawn('cmd.exe',['/c','start',newest_item.torrent_link])
    else console.log("无更新。")
    console.log title
