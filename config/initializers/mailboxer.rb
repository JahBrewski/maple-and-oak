Mailboxer.setup do |config|

  #Enables or disables email sending for Notifications and Messages
  config.uses_emails = true

  #Configures the default from for the email sent for Messages and Notifications of Mailboxer
  config.default_from = "notifications@mapleandoak.com"

  #Configures the methods needed by mailboxer
  config.email_method = :mailboxer_email
  config.name_method = :name

  #Configures if you use or not a search engine and wich one are you using
  #Supported enignes: [:solr,:sphinx]
  config.search_enabled = false
  config.search_engine = :solr
end
