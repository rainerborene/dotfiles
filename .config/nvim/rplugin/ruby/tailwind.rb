# frozen_string_literal: true

require "neovim"

JIT_REGEX = /[\w+-]+\[[^\[\]]+\]/
CSS_REGEX = /(@apply\s*)(.*)(;)/
QUOTE_REGEX = /(["'])((?:(?!\1|<%=)[^'\n]|<%=.*?%>)*)(\1)/
TAILWIND_REGEX = /
  \b(?:
    # Layout
    (?:container|block|inline(?:-block|-flex|-grid|-table)?|flex(?:-(?:row|col|wrap(?:-reverse)?))?|grid|table|hidden|flow-root)|

    # Box Alignment
    (?:place|justify|content|items|self|gap|space-[xy]|order|float|clear)|

    # Sizing
    (?:w(?:-full|-screen)?|h(?:-full|-screen)?|min-w|min-h|max-w|max-h|aspect)|

    # Spacing (Padding & Margin)
    (?:p[trblxy]?|m[trblxy]?|inset|top|right|bottom|left)|

    # Borders
    (?:border(?:-[trblxy])?|rounded(?:-[trblxy]|-full)?)|

    # Effects
    (?:shadow(?:-(?:sm|md|lg|xl|2xl|inner))?|opacity|blur|brightness|contrast|grayscale|invert|sepia|backdrop(?:-blur|opacity|contrast|invert)?)|

    # Typography
    (?:text|leading|tracking|whitespace|break|truncate|font|italic|not-italic|uppercase|lowercase|capitalize|underline|line-through)|

    # Backgrounds & Decorations
    (?:bg(?:-gradient)?|decoration|shadow|ring|divide-[xy])|

    # Interactivity
    (?:cursor|resize|select|touch)|

    # Transitions & Animations
    (?:transition|duration|ease|animate)|

    # Flex Grid Positioning
    (?:grid-cols|grid-rows|col-span|col-start|col-end|row-span|row-start|row-end)|

    # Overflow & Display
    (?:overflow|overscroll|isolation|z)|

    # Filters & Backdrop
    (?:filter|backdrop|mix-blend|isolation)

    # Modifier suffix handling
    (?![a-z0-9-]) # Prevents unintended suffix matches
  )\b
/x

Neovim.plugin do |plug|
  plug.command(:Tw, nargs: 0) do |nvim|
    @nvim = nvim

    pattern = @nvim.current.buffer.name.include?(".css") ? CSS_REGEX : QUOTE_REGEX
    content = @nvim.current.buffer.lines.to_a.join("\n")
    content.gsub!(pattern) do
      prefix, classes, suffix = $1, $2, $3
      next it unless has_tailwind_class?(classes)
      %(#{prefix}#{sort_classes(classes)}#{suffix})
    end

    File.write(@nvim.current.buffer.name, "#{content}\n")

    @nvim.command(:checktime)
  end

  private
    def has_tailwind_class?(value)
      TAILWIND_REGEX.match?(value) || JIT_REGEX.match?(value)
    end

    def tokenize(class_name)
      stack, classes, outliers = [], [], []

      class_name.split(/\s+/).each do |token|
        case token
        when /#\{\w+\}/
          outliers << token
        when /<%=?/
          raise "Cannot parse nested ERB expressions" unless stack.empty?
          stack << token
        when /%>/
          outliers.concat(stack)
          outliers << token
          stack.clear
        else
          (stack.any? ? stack : classes) << token
        end
      end

      [classes.join(" "), outliers.join(" ")]
    end

    def sort_tailwind_classes(class_names)
      @nvim.exec_lua("return require('rainer.tailwind').sort({...})", [class_names])
    end

    def sort_classes(str)
      class_names, outliers = tokenize(str)
      sorted_class_names = sort_tailwind_classes(class_names)
      %(#{sorted_class_names} #{outliers}).strip
    end
end
