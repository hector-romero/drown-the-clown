#= require vendor/jquery

window.service =
  getPrize: (clown,success,error)->
    $.ajax(
      {
        type: 'get'
        url: SERVICE_URL + clown
        success:(data) ->
          if(data.iw_response && data.iw_response.type == 'winner')
            success data.iw_response.data
          else
            error()
        error: error
      }
    )