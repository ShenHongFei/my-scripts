fs=require 'fs'
cp=require 'child_process'
last=new Date()
#src_file='E:/学习/网络/UNIX网络编程/tcpcliserv/tcpservselect01.c'
src_file='D:/C/tcpservselect01.c'
target_file='/usr/home/fbd/unpv13e/tcpcliserv/tcpservselect01.c'
fs.watch src_file,(event)->
    now=new Date()
    if now.getTime()-last.getTime()>1000 and event=='change'
        cp.execSync("scp #{src_file} root@192.168.93.130:#{target_file}", {stdio:[0,1,2],cwd:'D:/',encoding:'utf-8'})
        console.log now+': synced'
    last=now