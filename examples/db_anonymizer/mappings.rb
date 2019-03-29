module DbAnonymizer::Mappings
  CLASSES_WITH_ATTRIBUTES = {
    User: [
      :name,
      :place,
      :birthdate,
      { email: :email },
      { token: :hex },
      { jsonb_field: %i(deep detect_type) },
      { remote_attachments_urls: { sample_pdf: true, default: [] } }
    ]
  }.freeze
end
