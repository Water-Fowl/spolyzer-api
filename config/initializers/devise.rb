Devise.setup do |config|
  # The e-mail address that mail will appear to be sent from
  # If absent, mail is sent from "please-change-me-at-config-initializers-devise@example.com"
  config.mailer_sender = "yuhsukeshootsfc@gmail.com"
  config.secret_key = '4295bdc7f545fdfb21c49d93216f683045f9daf7f454ef46d8e60523821d96902b830b01c0320c2ead71c39a92729098647fe8aa77b0af4f7ae65da722437362'
  # If using rails-api, you may want to tell devise to not use ActionDispatch::Flash
  # middleware b/c rails-api does not include it.
  # See: http://stackoverflow.com/q/19600905/806956
  config.navigational_formats = [:json]
end
