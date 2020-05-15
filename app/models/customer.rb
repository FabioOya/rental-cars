class Customer < ApplicationRecord
  has_many :rentals
  scope :search, ->(query) { where('name LIKE ?', "%#{query}%")
                              .or(where(document: query)) }
  #def search(query)
    #where('name LIKE ?', "%#{query}%")
  #end
  #validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
