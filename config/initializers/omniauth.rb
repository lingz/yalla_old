Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '333260533461225', 'ba73854a18ebd6981473116791ea5191'
end
