class Customer < ApplicationRecord
  scope :search, ->(query) { where('name LIKE ?', "%#{query}%")
                              .or(where(document: query)) }
  #def search(query)
    #where('name LIKE ?', "%#{query}%")
  #end
  #validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
