class Contact < MailForm::Base
  attribute :name, :validate => true
  attribute :email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message

  def headers
    {
      :subject => "New Contact Form Submission",
      #TODO Add Meghan's email
      :to => ["joelbrewer01@gmail.com"],
      :from => %("#{name}" <#{email}>)
    }
  end
end
