require 'rails_helper'

RSpec.describe AddressesController, type: :controller do
  let(:student) { create(:student) }

  context 'GET index' do
    it 'should return empty array' do
      get :index, format: :json
      expect_json([])
    end

    it 'should default to json response' do
      address = create(:address, student: student)
      get :index
      expect_status(200)
      expect_json(PublicEntity.serialize(Address.all))
    end

    it 'should return 5 students' do
      5.times { create(:address, student: student) }
      get :index, format: :json
      expect_status(200)
      expect_json_sizes(5)
    end

    it 'should return list of students with addresses and contacts' do
      address = create(:address, student: student)
      address2 = create(:address, student: student)

      get :index, format: :json
      expect_json('0', kind: address.kind)
      expect_json('0', name: address.name)
      expect_json('1', kind: address2.kind)
      expect_json('1', name: address2.name)
      expect_json(PublicEntity.serialize(Address.all))
    end
  end

  context 'GET show' do
    it 'should return address and associations for given address id' do
      address = create(:address, student: student)
      get :show, params: { id: address.id }, format: :json

      expect_json(kind: address.kind, name: address.name)
      expect_json('student', first_name: student.first_name)
      expect_json(PublicEntity.serialize(address))
    end
  end

  context 'POST create' do
    # also should not create without student
    it 'should create new address' do
      params = {
        kind: 'work',
        name: 'something',
        student_id: student.id
      }
      post :create, params: { address: params }, format: :json

      expect(Address.count).to eq(1)
      expect_json(kind: 'work', name: 'something')
      expect_json('student.first_name', student.first_name)
      expect_json(PublicEntity.serialize(Address.first))
    end
  end

  context 'PUT update' do
    before do
      @address = create(:address, student: student)
      @params = {
        kind: 'home',
        name: 'abc street, 10922'
      }
    end

    it 'should update address information' do
      patch :update, params: { id: @address.id, address: @params }, format: :json
      @address.reload

      expect_json(kind: 'home', name: 'abc street, 10922')
      expect_json('student', first_name: student.first_name)
      expect_json(PublicEntity.serialize(@address))
    end
  end

  context 'DELETE destroy' do
    before do
      @address = create(:address, student: student)
    end

    it 'should delete address with id' do
      delete :destroy, params: { id: @address.id }, format: :json
      expect(Address.count).to eq(0)
    end
  end
end

