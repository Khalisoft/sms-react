require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  context 'GET index' do
    it 'should return empty array' do
      get :index, format: :json
      expect_json([])
    end

    it 'should default to json response' do
      student = create(:student)
      get :index
      expect_status(200)
      expect_json('0',
                  id: student.id,
                  first_name: student.first_name,
                  last_name: student.last_name,
                  country: student.country,
                  experiences: student.experiences
                 )
    end

    it 'should return 5 students' do
      5.times { create(:student) }
      get :index, format: :json
      expect_status(200)
      expect_json_sizes(5)
    end

    it 'should return list of students with addresses and contacts' do
      student = create(:student)
      student2 = create(:student)
      # addresses
      address = create(:address, student_id: student.id)
      address2 = create(:address, student_id: student2.id)
      # contacts
      contact = create(:contact, student_id: student.id)
      contact2 = create(:contact, student_id: student2.id)

      get :index, format: :json

      # should load student attributes
      expect_json('0', first_name: student.first_name)
      expect_json('1', first_name: student2.first_name)
      expect_json(PublicEntity.serialize(Student.all))
      # should also load their addresses
      expect_json_sizes('0.addresses', 1)
      expect_json('0.addresses.0', kind: address.kind, name: address.name)
      expect_json_sizes('1.addresses', 1)
      expect_json('1.addresses.0', kind: address2.kind, name: address2.name)
      # should also load their contacts
      expect_json_sizes('0.contacts', 1)
      expect_json('0.contacts.0', email: contact.email)
      expect_json_sizes('1.contacts', 1)
      expect_json('1.contacts.0', email: contact2.email)
    end
  end

  context 'GET show' do
    it 'should return student and associations for given student id' do
      student = create(:student)
      address = create(:address, student: student)
      create(:address, student: student)
      contact = create(:contact, student: student)
      create(:contact, student: student)
      get :show, params: { id: student.id }, format: :json

      expect_json(PublicEntity.serialize(student))
      expect_json('addresses.0', name: address.name)
      expect_json('contacts.0', phone: contact.phone)
      expect_json_sizes('addresses', 2)
      expect_json_sizes('contacts', 2)
    end
  end

  context 'POST create' do
    it 'should create new student' do
      params = {
        first_name: 'john',
        last_name: 'doe',
        country: 'us',
        experiences: 'js, ruby'
      }
      post :create, params: { student: params }, format: :json

      expect(Student.count).to eq(1)
      expect_json(PublicEntity.serialize(Student.first))
    end
  end

  context 'PUT update' do
    before do
      @student = create(:student)
      @params = {
        first_name: 'john',
        last_name: 'doe',
        country: 'us',
        experiences: 'something, new'
      }
    end

    it 'should update student information' do
      patch :update, params: { id: @student.id, student: @params }, format: :json
      @student.reload

      expect(Student.count).to eq(1)
      expect_json('first_name', 'john')
      expect_json('last_name', 'doe')
      expect_json('country', 'us')
      expect_json('experiences', 'something, new')
    end
  end

  context 'DELETE destroy' do
    before do
      @student = create(:student)
    end

    it 'should delete student with id' do
      delete :destroy, params: { id: @student.id }, format: :json
      expect(Student.count).to eq(0)
    end
  end
end

