# frozen_string_literal: true

module ApplicationHelper
  def render_turbo_stream_flash_messages
    turbo_stream.prepend('flash', partial: 'layouts/flash')
  end

  def form_error_notification(record)
    return if record.errors.empty?

    tag.div(class: 'error-message') do
      record.errors.full_messages.to_sentence.capitalize
    end
  end

  def nested_dom_id(*args)
    args.map { |e| e.respond_to?(:to_key) || e.is_a?(Class) ? dom_id(e) : e }.join('_')
  end
end
