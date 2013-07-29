# encoding: utf-8

require 'spec_helper'

describe Environment, '#[]' do
  include_context 'Environment'

  subject { object[:users] }

  context 'when relation exists' do
    fake(:relation, name: :users) { Axiom::Relation::Base }

    before do
      object.load_schema(test: [relation])
    end

    it { should be_instance_of(Axiom::Relation::Variable::Materialized) }
  end

  context 'when relation does not exist' do
    it { should be(nil) }
  end
end
