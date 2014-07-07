module TemplatesPaths
  extend self

  def templates
    Hash[
      Rails.application.assets.each_logical_path.
      select { |file| file.end_with?('swf', 'html', 'json') }.
      reject { |file| file.end_with?('/bower.json') }.
      reject { |file| file.end_with?('/composer.json') }.
      reject { |file| file.starts_with?('angular-ui-router') }.
      map { |file| [file, ActionController::Base.helpers.asset_path(file)] }
    ]
  end
end
