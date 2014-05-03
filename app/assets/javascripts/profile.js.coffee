jQuery ->

  update_profit_loss_visibility = ->
    if $("#profile_sub_category").val() == "startup"
      $("#profit-loss").hide() 
    else
      $("#profit-loss").show()

  update_profit_loss_visibility_on_category_change = ->
    $("#profile_sub_category").change ->
      update_profit_loss_visibility()

  init = ->
    update_profit_loss_visibility()
    update_profit_loss_visibility_on_category_change()
  
  is_entrepreneur_form = ->
    if $("#entrepreneur-form").length > 0
      return true
    else
      return false

  if is_entrepreneur_form() == true
    init()
