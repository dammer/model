module Lotus
  module Model
    module Adapters
      module Sql
        class Query
          attr_reader :conditions

          def initialize(table_name, collection, mapper, &blk)
            @collection = collection
            @table_name = table_name
            @mapper     = mapper

            @conditions = []
            instance_eval(&blk) if block_given?
          end

          def all
            @mapper.deserialize(@table_name, Lotus::Utils::Kernel.Array(run))
          end

          def where(condition)
            conditions.push([:where, condition])
            self
          end

          alias_method :and, :where

          def limit(number)
            conditions.push([:limit, number])
            self
          end

          def offset(number)
            conditions.push([:offset, number])
            self
          end

          def order(column)
            conditions.push([:order, column])
            self
          end

          def or(condition)
            conditions.push([:or, condition])
            self
          end

          def average(column)
            @mapper.deserialize_column(
              @table_name,
              column,
              run.avg(column)
            )
          end

          alias_method :avg, :average

          def count
            run.count
          end

          private
          def run
            current_scope = @collection

            conditions.each do |(method,*args)|
              current_scope = current_scope.public_send(method, *args)
            end

            current_scope
          end
        end
      end
    end
  end
end
