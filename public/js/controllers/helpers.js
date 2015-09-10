logged = function(data){
  if (data['code'] == 400001){
    window.location.replace("/user_tkw/login");
  }
}

generate_url_key = function(){
  return '?consumer_key=' + Cookies.get('consumer_key') + '&secret_key=' + Cookies.get('secret_key')
}

get_job_status_hash = function(){
  return {
    'DRAFT': 0,
    'PUBLISHED': 1,
    'FILLED': 2,
    'EXPIRED': 3,
    'DASHBOARD': 4
  };
}

set_title = function(input){
  var title_description = input.value.split('\n')[0]
  last = title_description.replace(/[^0-9a-z \-\_\.\,]/i, '')
  while(last != title_description){
    title_description = last
    last = title_description.replace(/[^0-9a-z \-\_\.\,]/i, '');
  };
  return title_description;
}
