# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'helm_binary class' do
  context 'without any parameters', :cleanup_opt do
    let(:pp) do
      <<-EOS
      include helm_binary
      EOS
    end

    it_behaves_like 'an idempotent resource'

    %w[
      /opt/helm
      /opt/helm/3.7.2
      /opt/helm/3.7.2/bin
      /opt/helm/3.7.2/dl
    ].each do |d|
      describe file(d) do
        it { is_expected.to be_directory }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
        it { is_expected.to be_mode '755' }
      end
    end

    describe file('/opt/helm/3.7.2/dl/helm-v3.7.2-linux-amd64.tar.gz') do
      it { is_expected.to be_file }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      it { is_expected.to be_mode '644' }
    end

    describe file('/opt/helm/3.7.2/bin/helm') do
      it { is_expected.to be_file }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      it { is_expected.to be_mode '755' }
    end

    describe file('/usr/bin/helm') do
      it { is_expected.to be_symlink }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      it { is_expected.to be_linked_to '/opt/helm/3.7.2/bin/helm' }
    end
  end

  context 'with base_path param' do
    basedir = default.tmpdir('helm')

    let(:pp) do
      <<-EOS
      class { helm_binary:
        base_path => '#{basedir}',
      }
      EOS
    end

    it_behaves_like 'an idempotent resource'

    [
      basedir,
      "#{basedir}/3.7.2",
      "#{basedir}/3.7.2/bin",
      "#{basedir}/3.7.2/dl",
    ].each do |d|
      describe file(d) do
        it { is_expected.to be_directory }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
        it { is_expected.to be_mode '755' }
      end
    end

    describe file("#{basedir}/3.7.2/dl/helm-v3.7.2-linux-amd64.tar.gz") do
      it { is_expected.to be_file }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      it { is_expected.to be_mode '644' }
    end

    describe file("#{basedir}/3.7.2/bin/helm") do
      it { is_expected.to be_file }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      it { is_expected.to be_mode '755' }
    end

    describe file('/usr/bin/helm') do
      it { is_expected.to be_symlink }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      it { is_expected.to be_linked_to "#{basedir}/3.7.2/bin/helm" }
    end
  end

  context 'with version related params' do
    let(:pp) do
      <<-EOS
      class { helm_binary:
        version  => '3.5.4',
        checksum => 'a8ddb4e30435b5fd45308ecce5eaad676d64a5de9c89660b56face3fe990b318',
      }
      EOS
    end

    it_behaves_like 'an idempotent resource'

    %w[
      /opt/helm
      /opt/helm/3.5.4
      /opt/helm/3.5.4/bin
      /opt/helm/3.5.4/dl
    ].each do |d|
      describe file(d) do
        it { is_expected.to be_directory }
        it { is_expected.to be_owned_by 'root' }
        it { is_expected.to be_grouped_into 'root' }
        it { is_expected.to be_mode '755' }
      end
    end

    describe file('/opt/helm/3.5.4/dl/helm-v3.5.4-linux-amd64.tar.gz') do
      it { is_expected.to be_file }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      it { is_expected.to be_mode '644' }
    end

    describe file('/opt/helm/3.5.4/bin/helm') do
      it { is_expected.to be_file }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      it { is_expected.to be_mode '755' }
    end

    describe file('/usr/bin/helm') do
      it { is_expected.to be_symlink }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_grouped_into 'root' }
      it { is_expected.to be_linked_to '/opt/helm/3.5.4/bin/helm' }
    end
  end
end
