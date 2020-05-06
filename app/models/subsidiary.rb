class Subsidiary < ApplicationRecord
  validates :name, :cnpj, presence: true
  validates :name, uniqueness: true
  #validates :cnpj, format: { with: /\A}
  #valite :cnpj_must_be_valid

  private

  # def cnpj_must_be_valid
  #   unless CNPJ.valid?(cnpj)
  #     errors.add(:cnpj, :invalid)
  #   end
end
