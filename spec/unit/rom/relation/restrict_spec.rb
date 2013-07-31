# encoding: utf-8

require 'spec_helper'

describe Relation, '#restrict' do
  include_context 'Relation'

  it 'restricts the relation' do
    expect(relation.restrict(name: 'Jane').to_a).to eq([user2])
  end
end
