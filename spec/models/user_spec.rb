require 'rails_helper'

RSpec.describe User do
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to have_many :questions }
  it { is_expected.to have_many :answers }
end
