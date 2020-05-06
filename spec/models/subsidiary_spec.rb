require 'rails_helper'

describe Subsidiary do
  context '#name' do 
    it 'cannot be blank' do
      subsidiary = Subsidiary.new(name: '')
      subsidiary.valid?
      expect(subsidiary.errors[:name]).to include('não pode ficar em branco')
    end

    it 'must be unique' do
      Subsidiary.create!(name: 'Paulista', cnpj: '75.641.502/0001-09', adress: 'Alameda santos, 524')
      subsidiary = Subsidiary.new(name: 'Paulista')
      subsidiary.valid?
      expect(subsidiary.errors[:name]).to include('já está em uso')
    end
  end

  context '#cnpj' do
    it 'cannot be blank' do
      subsidiary = Subsidiary.new(cnpj: '')
      subsidiary.valid?
      expect(subsidiary.errors[:cnpj]).to include('não pode ficar em branco')
    end

    it 'must be valid format' do
      subsidiary = Subsidiary.new(cnpj: '23.534.432/0010-00')
      subsidiary.valid?
      expect(subsidiary.errors[:cnpj]).to include('não é válido')
    end

    it 'must be ponctuacted' do
      subsidiary = Subsidiary.new(cnpj: '99117419427300')
      subsidiary.valid?
      expect(subsidiary.errors[:cnpj]).to include('não é válido')
    end
  end

  context '#adress' do 
    it 'cannot be blank' do
      subsidiary = Subsidiary.new(adress: '')
      subsidiary.valid?
      expect(subsidiary.errors[:adress]).to include('não pode ficar em branco')
    end

    it 'must be unique' do
      Subsidiary.create!(name: 'Alameda santos', adress: 'Alameda santos, 524', cnpj: '75.641.502/0001-09')
      subsidiary = Subsidiary.new(adress: 'Alameda santos, 524')
      subsidiary.valid?
      expect(subsidiary.errors[:adress]).to include('já está em uso')
    end
  end
end
