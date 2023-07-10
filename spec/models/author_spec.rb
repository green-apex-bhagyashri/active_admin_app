require 'rails_helper'

RSpec.describe Author, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe "associations" do
    it { should have_many(:articles).class_name("Article") }
  end
end