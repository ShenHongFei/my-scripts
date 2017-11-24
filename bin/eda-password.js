[original_password_input,new_password_input,new_password_confirm_input,submit_button]=document.querySelectorAll('input')

function change_password(original_password,new_password){
    original_password_input.value=original_password
    new_password_input.value=new_password
    new_password_confirm_input.value=new_password
    submit_button.onclick=null
    submit_button.click()
}

submit_button.parentNode.insertAdjacentHTML('beforeend',`<button type="button" onclick="change_password('jkjk1212','jkjkjk12')">改掉密码</button>`)
submit_button.parentNode.insertAdjacentHTML('beforeend',`<button type="button" onclick="change_password('jkjkjk12','jkjk1212')">改回密码</button>`)

if(unsafeWindow){
    unsafeWindow.change_password=change_password
}
