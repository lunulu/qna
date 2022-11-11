require 'rails_helper'

RSpec.describe Answer do
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to belong_to :question }
end
