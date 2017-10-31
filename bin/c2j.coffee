coffee=require('coffeescript')
require('copy-paste').global()
copy(coffee.compile(paste(),{inlineMap:false,bare:true}))