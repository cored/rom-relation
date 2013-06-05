module ROM

  # Enhanced ROM relation wrapping axiom relation and using injected mapper to
  # load/dump tuples/objects
  #
  class Relation
    include Enumerable

    attr_reader :axiom_relation, :mapper

    alias_method :all, :to_a

    def initialize(axiom_relation, mapper)
      @axiom_relation = axiom_relation
      @mapper         = mapper
    end

    def each(&block)
      return to_enum unless block_given?
      axiom_relation.each { |tuple| yield(mapper.load(tuple)) }
      self
    end

    def insert(tuples)
      new(axiom_relation.insert(tuples))
    end
    alias_method :<<, :insert

    def update(old_tuples, new_tuples)
      new(axiom_relation.delete(old_tuples).insert(new_tuples))
    end

    def delete(tuples)
      new(axiom_relation.delete(tuples))
    end

    def replace(tuples)
      new(axiom_relation.replace(tuples))
    end

    def restrict(*args, &block)
      new(axiom_relation.restrict(*args, &block))
    end

    def take(limit)
      new(axiom_relation.take(limit))
    end

    def first(limit = 1)
      take(limit)
    end

    def last(limit = 1)
      new(axiom_relation.reverse.take(limit).reverse)
    end

    def drop(offset)
      new(axiom_relation.drop(offset))
    end

    def order(*attributes)
      sorted = axiom_relation.sort_by { |r| attributes.map { |attribute| r.send(attribute) } }
      new(sorted)
    end

    def sort_by(*args, &block)
      new(axiom_relation.sort_by(*args, &block))
    end

    def ordered
      new(axiom_relation.sort_by(axiom_relation.header))
    end

    private

    def new(new_axiom_relation)
      self.class.new(new_axiom_relation, mapper)
    end

  end # class Relation

end # module ROM
