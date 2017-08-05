require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  let(:student) { create(:student) }

  context 'GET index' do
    it 'should return empty array' do
      get :index, format: :json
      expect_json([])
    end

    it 'should default to json response' do
      contact = create(:contact, student: student)
      get :index
      expect_status(200)
      expect_json(PublicEntity.serialize(Contact.all))
    end

    it 'should return 5 students' do
      5.times { create(:contact, student: student) }
      get :index, format: :json
      expect_status(200)
      expect_json_sizes(5)
    end

    it 'should return list of students with contactes and contacts' do
      contact = create(:contact, student: student)
      contact2 = create(:contact, student: student)

      get :index, format: :json
      expect_json('0', phone: contact.phone)
      expect_json('0', email: contact.email)
      expect_json('1', phone: contact2.phone)
      expect_json('1', email: contact2.email)
      expect_json(PublicEntity.serialize(Contact.all))
    end
  end

  context 'GET show' do
    it 'should return contact and associations for given contact id' do
      contact = create(:contact, student: student)
      get :show, params: { id: contact.id }, format: :json

      expect_json(phone: contact.phone, email: contact.email)
      expect_json('student', first_name: student.first_name)
      expect_json(PublicEntity.serialize(contact))
    end
  end

  context 'POST create' do
    # also should not create without student
    it 'should create new contact' do
      params = {
        phone: '9898989898',
        email: 'test@example.com',
        student_id: student.id
      }
      post :create, params: { contact: params }, format: :json

      expect(Contact.count).to eq(1)
      expect_json(phone: '9898989898', email: 'test@example.com')
      expect_json('student.first_name', student.first_name)
      expect_json(PublicEntity.serialize(Contact.first))
    end
  end

  context 'PUT update' do
    before do
      @contact = create(:contact, student: student)
      @params = {
        phone: '9898989898',
        email: 'test@example.com',
      }
    end

    it 'should update contact information' do
      patch :update, params: { id: @contact.id, contact: @params }, format: :json
      @contact.reload

      expect_json(phone: '9898989898', email: 'test@example.com')
      expect_json('student', first_name: student.first_name)
      expect_json(PublicEntity.serialize(@contact))
    end
  end

  context 'DELETE destroy' do
    before do
      @contact = create(:contact, student: student)
    end

    it 'should delete contact with id' do
      delete :destroy, params: { id: @contact.id }, format: :json
      expect(Contact.count).to eq(0)
    end
  end
end
