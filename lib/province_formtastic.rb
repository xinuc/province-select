module Formtastic
  class SemanticFormBuilder
    @@priority_provinces = ["DKI Jakarta", "Jawa Barat", "Jawa Tengah", "Jawa Timur"]
    cattr_accessor :priority_provinces

    def province_input(method, options)
      raise "To use the :province input, please install a province_select plugin http://github.com/xinuc/province-select" unless self.respond_to?(:province_select)

      html_options = options.delete(:input_html) || {}
      priority_provinces = options.delete(:priority_provinces) || @@priority_provinces

      self.label(method, options.slice(:label, :required)) +
      self.province_select(method, priority_provinces, set_options(options), html_options)
    end

    def default_input_type(method)
      return :string if @object.nil?

      column = @object.column_for_attribute(method) if @object.respond_to?(:column_for_attribute)

      if column
        return :time_zone if column.type == :string && method.to_s =~ /time_zone/
        return :select    if column.type == :integer && method.to_s =~ /_id$/
        return :datetime  if column.type == :timestamp
        return :numeric   if [:integer, :float, :decimal].include?(column.type)
        return :password  if column.type == :string && method.to_s =~ /password/
        return :country   if column.type == :string && method.to_s =~ /country/
        return :province   if column.type == :string && method.to_s =~ /province/

        return column.type
      else
        obj = @object.send(method) if @object.respond_to?(method)

        return :select   if find_reflection(method)
        return :file     if obj && @@file_methods.any? { |m| obj.respond_to?(m) }
        return :password if method.to_s =~ /password/
        return :string
      end
    end

  end
end