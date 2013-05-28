module ActiveAdmin
  class ResourceController < BaseController
    module DataAccess
      def max_csv_records
        150_000_000
      end
    end
  end
end
