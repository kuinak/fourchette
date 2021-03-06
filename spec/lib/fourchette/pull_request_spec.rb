require 'spec_helper'

describe Fourchette::PullRequest do
  describe '#perform' do
    let(:fork) { double('fork') }
    subject { described_class.new }

    after do
      Fourchette::Fork.stub(:new).and_return(fork)
      subject.perform(params)
    end

    context 'action == synchronize' do
      let(:params) do
        {
          'action' => 'synchronize',
          'pull_request' => { 'title' => 'Test Me' }
        }
      end

      it { fork.should_receive(:update) }
    end

    context 'action == closed' do
      let(:params) do
        {
          'action' => 'closed',
          'pull_request' => { 'title' => 'Test Me' }
        }
      end

      it { fork.should_receive(:delete) }
    end

    context 'action == reopened' do
      let(:params) do
        {
          'action' => 'reopened',
          'pull_request' => { 'title' => 'Test Me' }
        }
      end

      it { fork.should_receive(:create) }
    end

    context 'action == opened' do
      let(:params) do
        {
          'action' => 'opened',
          'pull_request' => { 'title' => 'Test Me' }
        }
      end

      it { fork.should_receive(:create) }
    end

    context 'title includes [qa skip]' do
      let(:params) do
        {
          'action' => 'opened',
          'pull_request' => { 'title' => 'Skip Me [QA Skip]' }
        }
      end

      it { fork.should_not_receive(:create) }
    end
  end
end
