module ROM
  class Schema
    class Definition
      class Relation

        class Base < self

          def repository(name = Undefined)
            if name == Undefined
              @repository
            else
              @repository = name
            end
          end

        end # Base

      end # Relation
    end # Definition
  end # Schema
end # ROM
