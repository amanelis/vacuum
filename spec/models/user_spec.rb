require 'spec_helper'

describe User do
  it { should respond_to :id }
  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
end