# encoding: utf-8

require 'spec_helper'

describe Relation, '#drop' do
  include_context 'Relation'

  it 'drops the relation by the given offset' do
    expect(relation.drop(1).to_a).to eql([jane, jack, jade])
  end
end
