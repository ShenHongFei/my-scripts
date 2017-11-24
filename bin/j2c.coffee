require('copy-paste').global()
js2coffee=require('js2coffee')
coffee_src=js2coffee.build(paste(),{indent:4}).code
copy(coffee_src)