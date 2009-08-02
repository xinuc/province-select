module ActionView
  module Helpers
    module FormOptionsHelper

      def province_select(object, method, priority_provinces = nil, options = {}, html_options = {})
        InstanceTag.new(object, method, self, options.delete(:object)).to_province_select_tag(priority_provinces, options, html_options)
      end

      def province_options_for_select(selected = nil, priority_provinces = nil)
        province_options = ""

        if priority_provinces
          province_options += options_for_select(priority_provinces, selected)
          province_options += "<option value=\"\" disabled=\"disabled\">-------------</option>\n"
        end

        return province_options+ options_for_select(PROVINCES, selected)
      end

      PROVINCES = ["Bali", "Banten", "Bengkulu", "Daerah Istimewa Yogyakarta", "DKI Jakarta", "Gorontalo", "Jambi", "Jawa Barat", "Jawa Tengah", "Jawa Timur", "Kalimantan Barat", "Kalimantan Selatan", "Kalimantan Tengah", "Kalimantan Timur", "Kepulauan Bangka Belitung", "Kepulauan Riau", "Lampung", "Maluku", "Maluku Utara", "Nanggroe Aceh Darussalam", "Nusa Tenggara Barat", "Nusa Tenggara Timur", "Papua", "Papua Barat", "Riau", "Sulawesi Barat", "Sulawesi Selatan", "Sulawesi Tengah", "Sulawesi Tenggara", "Sulawesi Utara", "Sumatera Barat", "Sumatera Selatan", "Sumatera Utara"] unless const_defined?("PROVINCES")
    end

    class InstanceTag
      def to_province_select_tag(priority_provinces, options, html_options)
        html_options = html_options.stringify_keys
        add_default_name_and_id(html_options)
        value = value(object)
        content_tag("select",
          add_options(
            province_options_for_select(value, priority_provinces),
            options, value
          ), html_options
        )
      end
    end

    class FormBuilder
      def province_select(method, priority_provinces = nil, options = {}, html_options = {})
        @template.province_select(@object_name, method, priority_provinces, options.merge(:object => @object), html_options)
      end
    end
  end
end