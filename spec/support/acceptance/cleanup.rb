# frozen_string_literal: true

def cleanup_opt
  on hosts, 'rm -rf /opt/helm'
end

RSpec.configure do |c|
  c.before(:context, :cleanup_opt) do
    cleanup_opt
  end
  c.after(:context, :cleanup_opt) do
    cleanup_opt
  end
end
