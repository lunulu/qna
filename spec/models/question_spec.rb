require 'rails_helper'

RSpec.describe Question do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to have_many :answers }
end
