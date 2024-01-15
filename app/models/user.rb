# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, # Save password
          :registerable, # Edit User
          :recoverable, # Recover password
          :rememberable, # Rememberable user
          :validatable, # Validations
          # :confirmable, # Confirm registration
          :trackable # Logins count

  include DeviseTokenAuth::Concerns::User

  attr_accessor :auth_token
end
