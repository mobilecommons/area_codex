require 'concerns/with_area_codes'

module AreaCodex
  class Region < AreaCodex::Base
    include AreaCodex::WithAreaCodes

    NORTH_AMERICA = [:canada, :mexico, :united_states]

    def initialize(region_name)
      super()
      @region_name = constantize(region_name)
      @area_code_list = AreaCodex::AreaCodeList.new(area_code_files)
    end

    private

      def constantize(region_name)
        name = region_name.to_s.upcase.gsub(' ', '_')
        klass = self.class
        klass.const_defined?(name) ? klass.const_get(name) : klass.const_missing(name)
      end

      def area_code_files
        @region_name.map { |sym| "#{sym}.txt" }
      end
  end
end
