require 'rails_helper'

RSpec.describe User do
  it { is_expected.to have_many :questions }
  it { is_expected.to have_many :answers }
  it { is_expected.to have_many :rewards }

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }
end
