require 'rails_helper'

RSpec.describe User, :type => :model do

    let(:user) {User.new(email: "test@test.com")}

    it "nameが入っていないと無効" do
      expect(user).to_not be_valid
    end

    let(:user) {User.new(name: "test")}

    it "emailが入っていないと無効" do
      expect(user).to_not be_valid
    end

end
