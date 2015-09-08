logged = function(data){
  if (data['code'] == 400001){
    window.location.replace("/user_tkw/login");
  }
}

generate_url_key = function(){
  return '?consumer_key=' + Cookies.get('consumer_key') + '&secret_key=' + Cookies.get('secret_key')
}
