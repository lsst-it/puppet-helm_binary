# frozen_string_literal: true

require 'spec_helper'

describe 'helm_binary::repo' do
  it { is_expected.to compile.with_all_deps }
end
