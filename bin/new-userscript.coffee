website='test.com'
name='test'
run_at='document-idle'

userscipt_dir='D:/Scripts/userscripts/'
dir="#{userscipt_dir}#{name}/"
js_path="#{dir}#{name}.js"
coffee_path="#{dir}#{name}.coffee"
header="""
// ==UserScript==
// @name         #{name}
// @match        *://#{website}/**
// @require      file://#{js_path}
// @run-at       #{run_at}
// @grant        GM_addStyle
// ==/UserScript==
"""
fs=require 'fs'
fs.mkdirSync(dir)
fs.writeFileSync coffee_path,''
(require 'copy-paste').copy(header)
(require 'child_process').execSync("coffee -w -b -M --no-header -c #{coffee_path}",{stdio:[0,1,2],cwd:'D:/',encoding:'utf-8'})

# useful header template
"""
// @description  .
// @grant        GM_getValue
// @grant        GM_setValue
// @version      0.1
// @author       沈鸿飞
// @namespace    https://github.com/ShenHongFei/
// @license      MIT License
"""