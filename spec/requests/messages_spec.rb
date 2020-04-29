# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessagesController, type: :request do
  describe '#create' do
    before do
      patient = User.create!(is_patient: true, first_name: 'Dyan', last_name: 'Carra')
      doctor = User.create!(is_doctor: true, first_name: 'Joao', last_name: 'Rudemar')
      patient_inbox = Inbox.create!(user: patient)
      inbox = Inbox.create!(user: doctor)
      outbox = Outbox.create!(user: patient)

      Message.create!(body: 'Existent', inbox: patient_inbox, outbox: outbox)
    end

    subject { post messages_path, params: { message: { body: 'New message' } } }

    context 'when success' do
      it 'creates a message with correct data' do
        subject
        expect(Message.last.body).to eq 'New message'
        expect(Message.last.read).to be_falsy
        expect(Message.last.inbox).to eq User.default_doctor.inbox
        expect(Message.last.outbox).to eq User.current.outbox
      end
    end
  end
end
