jQuery ->

  window.asset_descriptions = [ "liquid", "marketable_securities", "real_estate", "personal", "notes_receivable", "business_holdings" ]
  window.liability_descriptions = [ "notes_payable", "accounts_payable", "auto_loans", "mortgage", "other" ]

  get_value = (type, description) ->
    if type == "asset"
      val = $("#profile_assets_#{description}").val()
    else
      val = $("#profile_liabilities_#{description}").val()
    val = val.replace /[^\d\.\-\ ]/g, ''
    if val == ""
      0
    else
      parseFloat(val)

  get_total_assets = ->
    total_assets = 0
    for description in asset_descriptions
      total_assets += get_value("asset", description)
    total_assets

  get_total_liabilities = ->
    total_liabilities = 0
    for description in liability_descriptions
      total_liabilities += get_value("liability", description)
    total_liabilities

  get_net_worth = ->
    net_worth = 0
    net_worth = get_total_assets() - get_total_liabilities()
    net_worth

  update_fields_on_form_change = ->
    $("form :input").change ->
      update_dynamic_fields()

  update_dynamic_fields = ->
    $("#profile_assets_total").val(get_total_assets())
    $("#profile_liabilities_total").val(get_total_liabilities())
    $("#profile_net_worth").val(get_net_worth())

  is_investor_form = ->
    if $("#investor-form").length > 0
      return true
    else
      return false

  init = ->
    update_dynamic_fields()
    update_fields_on_form_change()

  if is_investor_form() == true
    init()
