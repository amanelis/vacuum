require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  let(:user) { Fabricate(:user) }
  let(:admin) { Fabricate(:admin) }
  
  before {
    user.projects << Fabricate(:project)
  }
  
  context 'when user is an admin' do
    let(:ability) { Ability.new(admin) }
    
    context 'a user can manage all' do
      subject { ability }
      
      it{ should be_able_to(:manage, :all) }
    end
  end
  
  context 'when user is NOT an admin' do
    let(:ability) { Ability.new(user) }
    let(:project) { user.projects.first }
    
    context 'a user can :read, :update, :destroy a Project they own or are associated with' do
      subject { ability }
      
      it { should be_able_to(:read, project) }
      it { should be_able_to(:update, project) }
      it { should be_able_to(:destroy, project) }
    end
    
    context 'a user can :create an Error that belongs to their own project' do
      subject { ability }
      
      it { should be_able_to(:create, project.errors.new) }
    end
    
    context 'a user can :read an Error that belongs to their own project' do
      let(:error) { Fabricate(:error, project: user.projects.first) }
      
      subject { ability }
      
      it { should be_able_to(:read, error) }
    end
  end
end