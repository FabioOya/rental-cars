class Subsidiary < ApplicationRecord
  validates :name, :cnpj, presence: true
  validates :name, uniqueness: true
  #valite :cnpj_must_be_vlaid

  private

  # def cnpj_must_be_valid
  #   unless CNPJ.valid?(cnpj)
  #     errors.add(:cnpj, 'não é válido')
  #   end
end
