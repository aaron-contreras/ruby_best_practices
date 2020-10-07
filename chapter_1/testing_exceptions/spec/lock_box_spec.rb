# frozen_string_literal: true

require_relative '../lib/lock_box'

RSpec.describe LockBox do
  subject(:lock_box) { described_class.new(password: 'secret', content: 'My Secret Message') }

  it 'raises an error when an invalid password is used' do
    expect { lock_box.unlock('kitten') }.to raise_error(LockBox::InvalidPassword)
  end

  it 'raises an error when an invalid password is used' do
    expect { lock_box.unlock('barbara') }.to raise_error(LockBox::InvalidPassword)
  end

  it "doesn't raise an error when a valid password is used" do
    expect { lock_box.unlock('secret') }.not_to raise_error
  end

  it 'prevents access to content by default' do
    expect { lock_box.content }.to raise_error(LockBox::UnauthorizedAccess)
  end

  it 'allows access to content when box is properly unlocked' do
    lock_box.unlock('secret')
    expect { lock_box.content }.not_to raise_error
  end
end
