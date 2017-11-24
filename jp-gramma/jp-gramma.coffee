$('.answerline').on 'click',(e)->
    answer=$(e.target).children('.hidex')
    if answer.length
        answer.show()
    else $(e.target).parent().click()
    

$('td.toggle').on 'click',(e)->
    $(e.target).next().show()
    
reset_event_listener=->
    $('td.toggle').off()
    $('.answerline').off()
    
$('.row>div:first-child').attr('class','col-lg-12 col-md-8 col-sm-12 col-xs-12')