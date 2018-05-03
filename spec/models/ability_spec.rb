require 'rails_helper'

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }
  
  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }

    it { should_not be_able_to :manage, :all }
  end

  describe 'for admin' do
    let(:user) { create :user, admin: true }

    it { should be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user) { create :user }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }
  end
end
