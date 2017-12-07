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
cheerio=require('cheerio')

((url='http://btbtt.co/thread-index-fid-981-tid-4349164.htm',db='D:/Scripts/data/onepiece.json')->
    html=await request.get(url)
    
    $=cheerio.load(html,{decodeEntities:false})
    
    # Cheerio.contents() 获取所有子节点，包括文本结点(CheerioElement[])
    # CheerioElement.childNodes 获取所有子节点，包括文本结点(CheerioElement[])
    # Cheerio[]
    # title='[Skytree][ONE PIECE 海贼王][786][X264][1080P][GB_BIG5_JP][MP4][CRRIP][简繁日中日双语内挂字幕].torrent'
    torrent_links=$('a').filter ->
        this.title=this.childNodes.last()?.data
        if !this.title?.match(/海贼王.*\.torrent/)
            return false
        this.href='http://btbtt.co/'+this.attribs['href']
        this.episode=this.title.match(/\[(\d{3})\]/)?[1]
        this.format=this.title.match(/\[(X26.)\]/)?[1]
        this.episode&&this.format
    .toArray()
    latest_link=torrent_links.reduce (latest,x)->
        if x.episode+x.format>latest.episode+latest.format then x else latest
    
    fs=require 'fs'
    old_episode=if fs.existsSync(db) then fs.readFileSync(db,{encoding:'utf-8'}) else null
    console.log (if latest_link.episode!=old_episode then '发现更新：' else '最新：')+latest_link.episode+'\n'+latest_link.href
    fs.writeFileSync(db,latest_link.episode)
    rl=require('readline').createInterface(input:process.stdin,output:process.stdout)
    open_link=(url)->
        cp.spawn('cmd.exe',['/c','start',url])
    rl.question '下载种子？',->
        open_link(latest_link.torrent_link)
        rl.close()
)()
