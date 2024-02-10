require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid with valid attributes' do
    post = Post.new(title: 'Sample Title', body: 'Sample body text.')
    expect(post).to be_valid
  end

  it 'is not valid without a title' do
    post = Post.new(title: nil, body: 'Sample body text.')
    expect(post).not_to be_valid
  end

  it 'is not valid without a body' do
    post = Post.new(title: 'Sample Title', body: nil)
    expect(post).not_to be_valid
  end
end
