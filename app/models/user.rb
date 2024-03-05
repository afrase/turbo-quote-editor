# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :validatable

  belongs_to :company

  # Eager load the company when getting the user for devise.
  def self.serialize_from_session(key, salt)
    eager_load(:company).scoping do
      super(key, salt)
    end
  end

  def name
    email.split('@').first&.capitalize
  end
end
