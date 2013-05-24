require 'spec_helper'

describe ProjectsController do
  include Devise::TestHelpers

  describe "GET 'index'" do
    let(:user) { Fabricate(:user) }
    
    context 'when logged in' do
      before {
        sign_in user
      }
      
      subject { get 'index' }
      it { should_not be_nil }
      it { should be_success }
    end
    
    context 'when not logged in' do
      subject { get 'index' }
      it { should_not be_nil }
      it { should be_redirect }
    end
  end
  
  describe "GET 'new'" do
    let(:user) { Fabricate(:user) }
    
    context "when logged in" do
      before {
        sign_in user
      }
      
      context 'and the user has not paid, but has added one project' do
        subject { get 'new' }
        it { should_not be_nil }
        it { should be_redirect }
      end
      
      context 'and the user has not paid, but has not added any projects' do
        before {
          user.projects.all.collect(&:destroy)
        }
        
        subject { get 'new' }
        it { should_not be_nil }
        it { should be_success }
      end
      
      context 'and the user has paid' do
        before {
          user.create_subscription
        }
        
        subject { get 'new' }
        it { should_not be_nil }
        it { should be_success }
      end
    end
    
    context 'when not logged in' do
      subject { get 'new' }
      it { should_not be_nil }
      it { should be_redirect }
    end
  end
  
  describe "POST 'create'" do
    let(:user) { Fabricate(:user) }
    
    context "when logged in" do
      before {
        sign_in user
      }
      
      context 'and the user can create a project' do
        before {
          user.projects.all.collect(&:destroy)
        }
        
        context 'and the proper attributes are sent in the request' do
          subject { post 'create', {project: {name: Faker::Internet.user_name, url: "http://#{Faker::Internet.domain_name}"}} }
          it { should_not be_nil }
          it { should be_redirect }
        end
        
        context 'and incorrect or missing attributes are sent in the request' do
          subject { post 'create', {project: {name: "", url: ""}} }
          it { should_not be_nil }
          it { should be_redirect }
        end
      end    
      
      context 'and the user cannot create a project' do
        pending 'need to test this ability ********'
      end
    end
    
    context "when not logged in" do
      subject { post 'create' }
      it { should_not be_nil }
      it { should be_redirect }
    end
  end
  
  describe "GET 'show'" do
    let(:user) { Fabricate(:user) }
    let(:project) { user.projects.first }
    let(:person) { Fabricate(:user) }
    
    context 'when logged in' do
      before {
        sign_in user
      }
      
      context 'when the user has the permissions to view a project' do
        subject { get 'show', id: project.id }
        it { should_not be_nil }
        it { should be_success }
      end
      
      context 'when the user does not have the permissions to view a project' do
        subject { get 'show', id: person.projects.first.id }
        it { should_not be_nil }
        it { should be_redirect }
      end
    end
    
    context 'when not logged in' do
      subject { get 'show', id: SecureRandom.hex(25)[0...20] }
      it { should_not be_nil }
      it { should be_redirect }
    end
  end
  
  describe "PUT 'update'" do
    let(:user) { Fabricate(:user) }
    let(:project) { user.projects.first }
    let(:person) { Fabricate(:user) }
    
    context 'when logged in' do
      context 'and the user owns the projes' do
        context 'and the request is made with proper attributes' do
          subject { put 'update', {id: project.id, project: {name: Faker::Internet.user_name, url: "http://#{Faker::Internet.domain_name}"}} }
          it { should_not be_nil }
          it { should be_redirect }
        end

        context 'and the request is made with in proper attributes' do
          subject { put 'update', {id: project.id} }
          it { should_not be_nil }
          it { should be_redirect }
        end
      end
      
      context 'and the user does not own the project' do
        subject { put 'update', {id: person.projects.first.id, project: {name: Faker::Internet.user_name, url: "http://#{Faker::Internet.domain_name}"}} }
        it { should_not be_nil }
        it { should be_redirect }
      end
    end
    
    context 'when not logged in' do
      subject { put 'update', id: SecureRandom.hex(25)[0...20] }
      it { should_not be_nil }
      it { should be_redirect }
    end
  end
end